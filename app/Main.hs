module Main (main) where

import Lib

-- My Imports
import Parser (parseExpr)
import Evaluator (eval)
import System.IO (hFlush, stdout)

main :: IO ()
main = do
  putStrLn "Enter an arithmetic expression:"
  input <- getLine
  case parseExpr input of
    Left err  -> print err
    Right ast -> do
      let result = eval ast
      putStrLn $ "Result: " ++ show result