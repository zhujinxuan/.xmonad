{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_my_xmonad_config (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/jinxuanzhu/.xmonad/my-xmonad-config/.stack-work/install/x86_64-linux-nix/f3e81135d6faef53dd5100b2e1aeeccda9c6187cb99cd3423d0791e085d37bb2/8.8.3/bin"
libdir     = "/home/jinxuanzhu/.xmonad/my-xmonad-config/.stack-work/install/x86_64-linux-nix/f3e81135d6faef53dd5100b2e1aeeccda9c6187cb99cd3423d0791e085d37bb2/8.8.3/lib/x86_64-linux-ghc-8.8.3/my-xmonad-config-0.1.0.0-4vIv8WCGCfY2v0CDJqWcAv"
dynlibdir  = "/home/jinxuanzhu/.xmonad/my-xmonad-config/.stack-work/install/x86_64-linux-nix/f3e81135d6faef53dd5100b2e1aeeccda9c6187cb99cd3423d0791e085d37bb2/8.8.3/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/jinxuanzhu/.xmonad/my-xmonad-config/.stack-work/install/x86_64-linux-nix/f3e81135d6faef53dd5100b2e1aeeccda9c6187cb99cd3423d0791e085d37bb2/8.8.3/share/x86_64-linux-ghc-8.8.3/my-xmonad-config-0.1.0.0"
libexecdir = "/home/jinxuanzhu/.xmonad/my-xmonad-config/.stack-work/install/x86_64-linux-nix/f3e81135d6faef53dd5100b2e1aeeccda9c6187cb99cd3423d0791e085d37bb2/8.8.3/libexec/x86_64-linux-ghc-8.8.3/my-xmonad-config-0.1.0.0"
sysconfdir = "/home/jinxuanzhu/.xmonad/my-xmonad-config/.stack-work/install/x86_64-linux-nix/f3e81135d6faef53dd5100b2e1aeeccda9c6187cb99cd3423d0791e085d37bb2/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "my_xmonad_config_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "my_xmonad_config_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "my_xmonad_config_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "my_xmonad_config_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_xmonad_config_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_xmonad_config_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
