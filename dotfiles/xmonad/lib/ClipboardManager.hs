{-# LANGUAGE ScopedTypeVariables #-}

module ClipboardManager
  ( clipboardDaemon
  , clipboardMenu
  , clipboardClear
  , clipboardPrint
  ) where

import System.IO
  ( Handle
  , IOMode(AppendMode)
  , hFlush
  , hPutStrLn
  , withFile
  )

import Control.Concurrent (threadDelay)
import Control.Exception (SomeException, try)
import Control.Monad (unless, when)
import System.Directory
import System.Environment (lookupEnv)
import System.Exit (ExitCode (..))
import System.FilePath (takeDirectory, (</>))
import System.IO
import System.Process

maxEntries :: Int
maxEntries = 80

getHistoryFile :: IO FilePath
getHistoryFile = do
  cacheHome <- lookupEnv "XDG_CACHE_HOME"
  home <- getHomeDirectory
  let base = maybe (home </> ".cache") id cacheHome
  pure (base </> "rofi" </> "clipboard-history")

getThemeFile :: IO FilePath
getThemeFile = do
  home <- getHomeDirectory
  pure (home </> ".config" </> "rofi" </> "clipboard.rasi")

normalize :: String -> String
normalize = concatMap (\c -> if c == '\n' then "\\n" else [c])

restore :: String -> String
restore [] = []
restore ('\\' : 'n' : rest) = '\n' : restore rest
restore (c : rest) = c : restore rest

readClipboard :: IO String
readClipboard =
  readProcess "xclip" ["-o", "-selection", "clipboard"] ""

setSelection :: String -> String -> IO ()
setSelection sel text = do
  (Just hin, _, _, ph) <-
    createProcess
      (proc "xclip" ["-selection", sel])
        { std_in = CreatePipe
        }

  hPutStr hin text
  hClose hin
  _ <- waitForProcess ph
  pure ()

setClipboard :: String -> IO ()
setClipboard text = do
  setSelection "clipboard" text
  setSelection "primary" text

trimHistory :: FilePath -> IO ()
trimHistory histFile = do
  contents <- readFile histFile

  let ls = lines contents
      trimmed = drop (max 0 (length ls - maxEntries)) ls
      tmp = histFile ++ ".tmp"

  length trimmed `seq` writeFile tmp (unlines trimmed)
  renameFile tmp histFile

addEntry :: FilePath -> String -> IO ()
addEntry histFile text = do
  exists <- doesFileExist histFile
  unless exists $ writeFile histFile ""

  contents <- readFile histFile

  let ls = lines contents
      entry = normalize text

  if entry `elem` ls
    then pure ()
    else do
      appendFile histFile (entry ++ "\n")
      trimHistory histFile

recentEntries :: FilePath -> IO [String]
recentEntries histFile = do
  exists <- doesFileExist histFile

  if not exists
    then pure []
    else do
      contents <- readFile histFile
      let ls = lines contents
      pure (drop (max 0 (length ls - maxEntries)) ls)

clipboardDaemon :: IO ()
clipboardDaemon = do
  histFile <- getHistoryFile
  createDirectoryIfMissing True (takeDirectory histFile)

  exists <- doesFileExist histFile
  unless exists $ writeFile histFile ""

  let logFile = histFile ++ ".log"

  withFile logFile AppendMode $ \logHandle -> do
    hPutStrLn logHandle $ "Clipboard history: " ++ histFile
    hFlush logHandle

    loop logHandle histFile ""
  where
    loop :: Handle -> FilePath -> String -> IO ()
    loop logHandle histFile lastVal = do
      result <- try $ do
        cur <- readClipboard

        hPutStrLn logHandle $ "Clipboard: " ++ show cur
        hFlush logHandle

        if not (null cur) && cur /= lastVal
          then do
            hPutStrLn logHandle "Adding clipboard entry"
            hFlush logHandle
            addEntry histFile cur
            pure cur
          else
            pure lastVal

      newLastVal <-
        case result of
          Left (err :: SomeException) -> do
            hPutStrLn logHandle $ "Clipboard error: " ++ show err
            hFlush logHandle
            pure lastVal

          Right val ->
            pure val

      threadDelay 1000000
      loop logHandle histFile newLastVal

clipboardMenu :: IO ()
clipboardMenu = do
  histFile <- getHistoryFile
  entries <- recentEntries histFile

  unless (null entries) $ do
    themeFile <- getThemeFile
    themeExists <- doesFileExist themeFile

    let mostRecentFirst = reverse entries
        baseArgs =
          [ "-dmenu"
          , "-p"
          , ""
          , "-mesg"
          , "clipboard history"
          ]
        rofiArgs =
          baseArgs
            ++ if themeExists
              then ["-theme", themeFile]
              else []

    result <-
      readCreateProcessWithExitCode
        (proc "rofi" rofiArgs)
        (unlines mostRecentFirst)

    case result of
      (ExitSuccess, out, _) ->
        case lines out of
          (pick : _)
            | not (null pick) ->
                setClipboard (restore pick)
          _ -> pure ()
      _ -> pure ()

clipboardClear :: IO ()
clipboardClear = do
  histFile <- getHistoryFile
  exists <- doesFileExist histFile

  when exists $ removeFile histFile

clipboardPrint :: IO ()
clipboardPrint = do
  histFile <- getHistoryFile
  entries <- recentEntries histFile
  mapM_ putStrLn (reverse entries)

