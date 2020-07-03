module Lib (Lib.config) where

import My.XFCE
import           XMonad.Hooks.EwmhDesktops        (ewmh)
import           XMonad.Hooks.ManageDocks
import           System.Taffybar.Support.PagerHints (pagerHints)

config =
       -- docks allows xmonad to handle taffybar
       docks $
       -- ewmh allows taffybar access to the state of xmonad/x11
       ewmh $
       -- pagerHints supplies additional state that is not supplied by ewmh
       pagerHints
       xfce_config
