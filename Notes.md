## Notes

#### Abstract Syntax Tree (AST) (src/AST.hs)

AST (Abstract Syntax Tree): This file will contain the definitions for the Abstract Syntax Tree (AST) of the language.

Module Declaration: The line `module AST where` declares that this file is a module named `AST`. This makes it available to be imported in other files, such as your parser or main module.

Data Type Definition: The Expr data type is defined with several constructors:

 - `Num Double`: Represents numeric literals.
 - `Add`, `Sub`, `Mul`, `Div`: Each takes two `Expr` values, representing binary operations.

#### Parser (src/Parser.hs)

Module Declaration: The first line declares the module `Parser` and exports the function `parseExpr`.

Imports:

 - We import `Text.Parsec` and `Text.Parsec.String (Parser)` for parsing combinators.
 - We also import your `AST` module so we can build an `Expr` from parsed input.

Parsing Numbers (`number`):

This parser reads one or more digits using `many1 digit` and converts the resulting string to a `Double` to construct a `Num`.

Parsing Factors (`factor`):

A factor can be a number or an expression inside parentheses. We use `<|>` to try parsing a number first; if that fails, it looks for an expression enclosed by `(` and `)`.

Parsing Terms (`term`) and Multiplicative Operators (`mulOp`):

`term` uses the `chainl1` combinator to parse a left-associative chain of factors separated by `*` or `/`. The `mulOp` parser maps these characters to their corresponding AST constructors (`Mul` or `Div`).

Parsing Expressions (`expr`) and Additive Operators (`addOp`):

Similarly, `expr` uses `chainl1` to parse a chain of terms separated by `+` or `-`, with `addOp` mapping them to `Add` or `Sub`.

Combining Everything (`parseExpr`):

The function `parseExpr` runs the `expr` parser on a given input string and ensures that all input is consumed (using `<* eof`).

#### Evaluator (src/Evaluator.hs)

Module Declaration:

We declare the module `Evaluator` and export only the `eval` function.

Importing AST:

This brings in the definition of `Expr` from the **AST.hs** module.

eval Function:

The function pattern-matches on the expression type:

 - For a number (`Num n`), it returns `n`.
 - For an addition (`Add a b`), it computes the sum of the evaluations of `a` and `b`.
 - Similarly, subtraction, multiplication, and division are handled appropriately.

