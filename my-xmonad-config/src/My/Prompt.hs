module My.Prompt (gotoWindow, bringWindow) where

import XMonad
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Window

gotoWindow :: X ()
gotoWindow = windowPrompt dtXPConfig Goto wsWindows

bringWindow :: X ()
bringWindow = windowPrompt dtXPConfig BringCopy allWindows

dtXPConfig :: XPConfig
dtXPConfig = def
  { font = "xft:Mononoki Nerd Font:size=9"
  , bgColor = "#292d3e"
  , fgColor = "#d0d0d0"
  , bgHLight= "#c792ea"
  , fgHLight= "#000000"
  , borderColor = "#535974"
  , promptBorderWidth = 0
  , position = Top
  --    , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
  , height = 20
  , historySize = 256
  , showCompletionOnTab = False
  , alwaysHighlight     = True
  , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
  , searchPredicate = fuzzyMatch
  , sorter          = fuzzySort
  }
