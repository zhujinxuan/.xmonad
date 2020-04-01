module Main where

import XMonad
import Lib

main :: IO ()
main = xmonad Lib.config
