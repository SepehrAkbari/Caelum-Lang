module AST (Expr(..)) where

-- Define a data type for arithmetic expressions
data Expr
  = Num Double        -- Represents a numeric literal
  | Add Expr Expr     -- Represents addition of two expressions
  | Sub Expr Expr     -- Represents subtraction
  | Mul Expr Expr     -- Represents multiplication
  | Div Expr Expr     -- Represents division
  deriving (Show, Eq)

