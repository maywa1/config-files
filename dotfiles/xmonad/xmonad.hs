import XMonad
import XMonad.Main (launch)
import XMonad.Util.EZConfig (additionalKeysP)

import Control.Concurrent
import Control.Monad (void)
import System.IO (hPutStrLn)

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers (isDialog, doCenterFloat)

import XMonad.Layout.Spacing

import qualified XMonad.StackSet as W

import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce

import Control.Concurrent
import System.IO (hPutStrLn)

import ClipboardManager (clipboardDaemon, clipboardMenu)


keybinds =
    [ ("M-<Return>", spawn "alacritty")
    , ("M-<Space>",  spawn "rofi -show drun")
    , ("M-c",        kill)

    , ("M-S-r",      spawn "xmonad --recompile && xmonad --restart")

    , ("M-l",        spawn "slock")
    , ("M-S-s",      spawn "flameshot gui")

    , ("M-v",        io clipboardMenu)

    -- Master pane
    , ("M-,", sendMessage (IncMasterN 1))
    , ("M-.", sendMessage (IncMasterN (-1)))

    --  power
    , ("M-S-e", spawn "systemctl suspend")

    -- Workspace d
    , ("M-d", windows $ W.greedyView "d")

    -- Brightness
    , ("<XF86MonBrightnessUp>",
        spawn "brightnessctl set +5%")

    , ("<XF86MonBrightnessDown>",
        spawn "brightnessctl set 5%-")

    -- Keyboard backlight
    , ("<XF86KbdBrightnessUp>",
        spawn "brightnessctl -d *::kbd_backlight set +10%")

    , ("<XF86KbdBrightnessDown>",
        spawn "brightnessctl -d *::kbd_backlight set 10%-")

    -- Volume
    , ("<XF86AudioRaiseVolume>",
        spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")

    , ("<XF86AudioLowerVolume>",
        spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")

    , ("<XF86AudioMute>",
        spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

    , ("<XF86AudioMicMute>",
        spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")

    -- Media playback
    , ("<XF86AudioPlay>",
        spawn "playerctl play-pause")

    , ("<XF86AudioNext>",
        spawn "playerctl next")

    , ("<XF86AudioPrev>",
        spawn "playerctl previous")

    , ("<XF86AudioStop>",
        spawn "playerctl stop")

    -- WiFi
    , ("<XF86WLAN>",
        spawn "nmcli radio wifi toggle")
    ]


main :: IO ()
main = do
    xmobarProc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"

    dirs <- getDirectories

    launch
        (docks
            $ def
                { terminal = "alacritty"

                , modMask = mod4Mask

                , borderWidth = 1

                , normalBorderColor = "#424242"

                , focusedBorderColor = "#6e6e6e"

                , workspaces =
                    [ "1"
                    , "2"
                    , "3"
                    , "4"
                    , "5"
                    , "6"
                    , "7"
                    , "8"
                    , "9"
                    , "d"
                    ]

                , layoutHook = layout

                , manageHook =
                    manageDocks <+> manageRules

                , startupHook =
                    startup

                , logHook =
                    dynamicLogWithPP xmobarPP
                        { ppOutput =
                            hPutStrLn xmobarProc

                        , ppCurrent =
                            xmobarColor "#81a2be" "" .
                            wrap "[" "]"

                        , ppTitle =
                            xmobarColor "#c5c8c6" "" .
                            shorten 50

                        , ppSep =
                            " <fc=#444444>|</fc> "
                        }
                }
            `additionalKeysP` keybinds
        )
        dirs


startup :: X ()
startup = do
    spawnOnce "dunst"
    liftIO $ void $ forkIO clipboardDaemon

layout =
    avoidStruts
        $ spacing 10
            ( tiled
                ||| Mirror tiled
                ||| Full
            )
    where
        tiled =
            Tall 1 (3 / 100) (1 / 2)


manageRules :: ManageHook
manageRules =
    composeAll
        [ className =? "Firefox"
            --> doShift "2"

        , className =? "vesktop"
            --> doShift "d"

        , isDialog
            --> doCenterFloat
        ]
