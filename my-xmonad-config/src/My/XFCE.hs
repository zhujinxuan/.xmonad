module  My.XFCE (xfce_config) where

import XMonad
import XMonad.Config.Xfce
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
import My.Tabbed (myLayout)
import My.Prompt (bringWindow, gotoWindow)


xfce_config = myConfig xfceConfig
-- My custom config.
myConfig c = c  -- this bit calls the kdeConfig
    { modMask = mod4Mask -- use the Windows button as mod
    , terminal = "urxvt"
    , manageHook = manageHook c <+> myManageHook <+> Pads.manageHooks
    , startupHook =startupHook c <+> myStartupHook
    , layoutHook = myLayout ||| layoutHook c
    } `EZ.additionalKeysP` myKeymaps

myKeymaps =
  [ ("M-] s", spawn "scrot shots/screen_%Y-%m-%d-%H-%M-%S.png -d 1")
  , ("M-] S-s", spawn "scrot shots/screen_%Y-%m-%d-%H-%M-%S.png -d 1")
  , ("M-] ;", gotoWindow)
  , ("M-] '", bringWindow)
  , ("<F12>", Pads.popupTerminal)
  , ("M-] ]", spawn "clipmenu")
  ]

myManageHook = composeAll . concat $
    [ [ className   =? c --> hasBorder False >> doIgnore >> doFloat | c <- myFloats]
    , [ title       =? t --> doFloat           | t <- myOtherFloats]
    , [ className   =? c --> doF (W.shift "2") | c <- webApps]
    , [ className   =? c --> doF (W.shift "3") | c <- emacsApps]
    , [ isKDETrayWindow --> doFloat ]
    ]
  where myFloats      = []
        myOtherFloats = ["alsamixer"]
        webApps       = ["Firefox"] -- open on desktop 2
        emacsApps     = ["Emacs"]   -- open on desktop 3

myStartupHook = do
  spawnOnce "clipmenud"
  spawnOnce "$HOME/.nix-profile/libexec/org_kde_powerdevil"
  EZ.checkKeymap xfce_config myKeymaps
