module Lib (Lib.config) where

import XMonad
import XMonad.Config.Kde
import qualified XMonad.StackSet as W -- to shift and float windows
import XMonad.Layout.NoBorders (hasBorder)
import XMonad.Util.SpawnOnce (spawnOnce)
import qualified Data.Map as M


config = kde4Config  -- this bit calls the kdeConfig
    { modMask = mod4Mask -- use the Windows button as mod
    , manageHook = manageHook kde4Config <+> myManageHook
    , startupHook =startupHook kde4Config <+> myStartupHook
    , keys = keys kde4Config <+> myKeys
    }

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    --take a screenshot of entire display
  [((modm ,              xK_Print ), spawn "scrot shots/screen_%Y-%m-%d-%H-%M-%S.png -d 1")
    --take a screenshot of focused window
  , ((modm .|. controlMask, xK_Print ), spawn "scrot shots/window_%Y-%m-%d-%H-%M-%S.png -d 1 -u")
  ]

myManageHook = composeAll . concat $
    [ [ className   =? c --> doIgnore <+> doFloat >> hasBorder False| c <- myFloats]
    , [ title       =? t --> doFloat           | t <- myOtherFloats]
    , [ className   =? c --> doF (W.shift "4") | c <- webApps]
    , [ className   =? c --> doF (W.shift "3") | c <- emacsApps]
    ]
  where myFloats      = ["plasmashell", "krunner"]
        myOtherFloats = ["alsamixer", "Plasma-desktop"]
        webApps       = ["Firefox"] -- open on desktop 2
        emacsApps     = ["Emacs"]   -- open on desktop 3

myStartupHook = do
  spawnOnce "plasmashell"
  spawnOnce "krunner"
