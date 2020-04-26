module Lib (Lib.config) where

import XMonad
import XMonad.Config.Kde
import XMonad.Util.EZConfig (additionalKeysP)
import qualified XMonad.StackSet as W -- to shift and float windows
import XMonad.Layout.NoBorders (hasBorder)
import XMonad.Util.SpawnOnce (spawnOnce)
import qualified Data.Map as M
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CycleWS (nextScreen)
import qualified My.Pads as Pads



config = kde4Config  -- this bit calls the kdeConfig
    { modMask = mod4Mask -- use the Windows button as mod
    , manageHook = manageHook kde4Config <+> myManageHook <+> Pads.manageHooks
    , startupHook =startupHook kde4Config <+> myStartupHook
    , keys = keys kde4Config <+> myKeys
    } `additionalKeysP` Pads.keys

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    --take a screenshot of entire display
  [ ((modm ,              xK_Print ), spawn "scrot shots/screen_%Y-%m-%d-%H-%M-%S.png -d 1")
    --take a screenshot of focused window
  , ((modm .|. controlMask, xK_Print ), spawn "scrot shots/window_%Y-%m-%d-%H-%M-%S.png -d 1 -u")
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
