import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers (isDialog, doCenterFloat)
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders (smartBorders)
import qualified XMonad.StackSet as W
import XMonad.Util.Run (spawnPipe)
import System.IO (Handle, hPutStrLn)
import XMonad.Util.SpawnOnce

keybinds =
    [ ("M-<Return>", spawn "alacritty")
    , ("M-<Space>",  spawn "dmenu_run -i -l 15 -fn 'JetBrainsMono Nerd Font:size=12' -nb '#1d1f21' -nf '#c5c8c6' -sb '#81a2be' -sf '#1d1f21' -p '>'")
    , ("M-c",        kill)
    , ("M-S-r",      spawn "xmonad --recompile && xmonad --restart")
    , ("M-S-q",      spawn "xmonad --recompile && xmonad --restart") -- alias, some muscle memory expects this

    , ("M-S-s",      spawn "flameshot gui")
    -- Master pane
    , ("M-,", sendMessage (IncMasterN 1))
    , ("M-.", sendMessage (IncMasterN (-1)))

    -- Lock / power
    , ("M-C-l", spawn "i3lock")
    , ("M-S-e", spawn "systemctl suspend")

    , ("M-d", windows $ W.greedyView "d")

    -- Screenshots (needs maim + slop + xclip, or swap for scrot)
    , ("<Print>",   spawn "maim ~/Pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png")
    , ("M-<Print>", spawn "maim -s ~/Pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png") -- select region
    , ("M-S-<Print>", spawn "maim -s | xclip -selection clipboard -t image/png") -- select -> clipboard

    -- Brightness
    , ("<XF86MonBrightnessUp>",   spawn "brightnessctl set +5%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")

    -- Keyboard backlight (skip if your keyboard has none — harmless no-op if device missing)
    , ("<XF86KbdBrightnessUp>",   spawn "brightnessctl -d *::kbd_backlight set +10%")
    , ("<XF86KbdBrightnessDown>", spawn "brightnessctl -d *::kbd_backlight set 10%-")

    -- Volume
    , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
    , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
    , ("<XF86AudioMute>",        spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
    , ("<XF86AudioMicMute>",     spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")

    -- Media playback (works with playerctl + most players: Spotify, mpv, browsers)
    , ("<XF86AudioPlay>",  spawn "playerctl play-pause")
    , ("<XF86AudioNext>",  spawn "playerctl next")
    , ("<XF86AudioPrev>",  spawn "playerctl previous")
    , ("<XF86AudioStop>",  spawn "playerctl stop")

    -- Airplane/WiFi toggle (adjust device name via `nmcli device`)
    , ("<XF86WLAN>", spawn "nmcli radio wifi toggle")
    ]

main :: IO ()
main = do
    xmobarProc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
    xmonad
        . docks
        $ def
            { terminal           = "alacritty"
            , modMask            = mod4Mask
            , borderWidth        = 1
            , normalBorderColor  = "#424242"
            , focusedBorderColor = "#6e6e6e"
            , workspaces         = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "d"]
            , layoutHook         = layout
            , manageHook         = manageDocks <+> manageRules
            , startupHook        = startup
            , logHook            = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmobarProc
                , ppCurrent = xmobarColor "#81a2be" "" . wrap "[" "]"
                , ppTitle   = xmobarColor "#c5c8c6" "" . shorten 50
                , ppSep     = " <fc=#444444>|</fc> "
                }
            }
        `additionalKeysP` keybinds

startup :: X ()
startup = do
    spawnOnce "dunst"

layout =
    avoidStruts
    $ spacing 10 (tiled ||| Mirror tiled ||| Full)
    where
    tiled = Tall 1 (3/100) (1/2)

manageRules :: ManageHook
manageRules = composeAll
    [ className =? "Firefox" --> doShift "2"
    , className =? "vesktop" --> doShift "d"
    , isDialog               --> doCenterFloat
    ]
