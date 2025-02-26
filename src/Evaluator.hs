module Evaluator (eval) where

import AST

-- The eval function recursively computes the value of an expression.
eval :: Expr -> Double
eval (Num n)   = n
eval (Add a b) = eval a + eval b
eval (Sub a b) = eval a - eval b
eval (Mul a b) = eval a * eval b
eval (Div a b) = eval a / eval b
