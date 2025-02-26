module Parser (parseExpr) where

import Text.Parsec
import Text.Parsec.String (Parser)
import AST

-- Parse a number (as a sequence of digits)
number :: Parser Expr
number = do
  numStr <- many1 digit
  return $ Num (read numStr)

-- Parse a factor: a number or a parenthesized expression
factor :: Parser Expr
factor = number <|> do
  char '('
  e <- expr
  char ')'
  return e

-- Parse multiplication and division (left-associative)
term :: Parser Expr
term = factor `chainl1` mulOp

-- Define the multiplication/division operator parser
mulOp :: Parser (Expr -> Expr -> Expr)
mulOp = do
  op <- oneOf "*/"
  return $ case op of
    '*' -> Mul
    '/' -> Div
    _   -> error "Unexpected operator in multiplication/division"

-- Parse addition and subtraction (left-associative)
expr :: Parser Expr
expr = term `chainl1` addOp

-- Define the addition/subtraction operator parser
addOp :: Parser (Expr -> Expr -> Expr)
addOp = do
  op <- oneOf "+-"
  return $ case op of
    '+' -> Add
    '-' -> Sub
    _   -> error "Unexpected operator in addition/subtraction"

-- Top-level function to run the parser on a given input string.
parseExpr :: String -> Either ParseError Expr
parseExpr input = parse (expr <* eof) "" input
