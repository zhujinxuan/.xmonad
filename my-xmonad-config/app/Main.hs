module Main where

import XMonad (xmonad)
import Lib (config)

main :: IO ()
main = xmonad config
