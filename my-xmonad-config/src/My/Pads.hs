module My.Pads (pads, popupTerminal, manageHooks)
where

import XMonad
import XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad
import qualified Data.Map as M

term = "terminal"

pads = [ NS term spawnTerm findTerm manageTerm
       ] where
  spawnTerm = "urxvt --title scratchpad"
  findTerm = title =? "scratchpad"
  manageTerm = let h = 0.9
                   w = 0.9
                   t = 0.5 - h/2
                   l = 0.5 - w/2
               in customFloating $ W.RationalRect l t w h

popupTerminal = namedScratchpadAction pads term

manageHooks = namedScratchpadManageHook pads
