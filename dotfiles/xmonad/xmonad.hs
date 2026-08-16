import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.Run (spawnPipe)
import System.IO (Handle)
import XMonad.Hooks.ManageHelpers (isDialog, doCenterFloat)

keybinds =
    [ ("M-<Return>", spawn "alacritty")
    , ("M-<Space>",        spawn "dmenu_run")
    , ("M-c",      kill)
    , ("M-S-r",      spawn "xmonad --recompile && xmonad --restart")

    -- Increase/decrease master count
    , ("M-,",        sendMessage (IncMasterN 1))
    , ("M-.",        sendMessage (IncMasterN (-1)))

    -- Lock screen
    , ("M-C-l",      spawn "i3lock")
    ]

main :: IO ()
main = do
    xmobarProc <- spawnPipe "xmobar"
    xmonad
        . docks
        $ def
            { terminal           = "alacritty"
            , modMask            = mod4Mask
            , borderWidth        = 2
            , normalBorderColor  = "#444444"
            , focusedBorderColor = "#88c0d0"
            , workspaces         = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
            , layoutHook         = myLayout
            , manageHook         = manageDocks <+> myManageHook
            }
        `additionalKeysP` keybinds

myLayout =
    avoidStruts
    $ spacingWithEdge 5
    $ tiled ||| Mirror tiled ||| Full
  where
    tiled = Tall 1 (3/100) (1/2)

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Firefox" --> doShift "2"
    , className =? "discord" --> doShift "3"
    , className =? "Spotify" --> doShift "4"
    , isDialog               --> doCenterFloat
    ]
