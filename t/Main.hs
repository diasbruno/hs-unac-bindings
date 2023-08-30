module Main (main) where

import Control.Monad (when)
import System.Exit
import Test.Hspec
import Test.Hspec.Runner
import Text.Unac (unacStringUtf8)

tests :: Spec
tests = describe "unac:" $ do
  it "été" $ do
    res <- unacStringUtf8 "été"
    res `shouldBe` Right "ete"

main :: IO ()
main = do
  summary <- hspecWithResult defaultConfig tests
  when (summaryFailures summary == 0)
    exitSuccess
  exitFailure
