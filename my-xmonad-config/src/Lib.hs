module Lib (Lib.config) where

import My.XFCE
import           XMonad.Hooks.EwmhDesktops        (ewmh)
import           XMonad.Hooks.ManageDocks

config =
       -- docks allows xmonad to handle taffybar
       docks $
       -- ewmh allows taffybar access to the state of xmonad/x11
       ewmh $
       xfce_config
