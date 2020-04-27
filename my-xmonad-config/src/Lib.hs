module Lib (Lib.config) where

import XMonad
import XMonad.Config.Kde
import XMonad.Config.Desktop
import qualified XMonad.Util.EZConfig as EZ
import qualified XMonad.StackSet as W -- to shift and float windows
import XMonad.Layout.NoBorders (hasBorder)
import XMonad.Util.SpawnOnce (spawnOnce)
import qualified Data.Map as M
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CycleWS (nextScreen)
import qualified XMonad.Util.Dzen as DZ
import qualified My.Pads as Pads


config = myConfig kde4Config
myConfig c = c  -- this bit calls the kdeConfig
    { modMask = mod4Mask -- use the Windows button as mod
    , terminal = "urxvt"
    , manageHook = manageHook c <+> myManageHook <+> Pads.manageHooks
    , startupHook =startupHook c <+> myStartupHook
    } `EZ.additionalKeysP` myKeymaps

myKeymaps =
  [ ("M-f s", spawn "scrot shots/screen_%Y-%m-%d-%H-%M-%S.png -d 1")
  , ("M-f S-s", spawn "scrot shots/screen_%Y-%m-%d-%H-%M-%S.png -d 1")
  , ("M-f <Space>", Pads.popupTerminal)
  ]

myManageHook = composeAll . concat $
    [ [ className   =? c --> hasBorder False >> doIgnore >> doFloat | c <- myFloats]
    , [ title       =? t --> doFloat           | t <- myOtherFloats]
    , [ className   =? c --> doF (W.shift "4") | c <- webApps]
    , [ className   =? c --> doF (W.shift "3") | c <- emacsApps]
    , [ isKDETrayWindow --> doFloat ]
    ]
  where myFloats      = ["plasmashell", "krunner",  "yakuake", "kmix", "plasma-desktop", "Desktop - Plasma"]
        myOtherFloats = ["alsamixer", "Plasma-desktop", "Desktop"]
        webApps       = ["Firefox"] -- open on desktop 2
        emacsApps     = ["Emacs"]   -- open on desktop 3

myStartupHook = do
  spawnOnce "plasmashell"
  spawnOnce "krunner"
  spawnOnce "yakuake"
  return ()
  EZ.checkKeymap Lib.config myKeymaps
