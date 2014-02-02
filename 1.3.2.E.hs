-- 1.3.2.E Date of Easter

**Given an year, calculate the date at which Easter falls.**

    easter :: Int -> String
    easter y =
      let g  = y `mod` 19 + 1
          c  = floor (fromIntegral y / 100) + 1
          x  = floor (3 * fromIntegral c / 4) - 12
          z  = floor ((8 * fromIntegral c + 5) / 25) - 5
          d  = floor (5 * fromIntegral y / 4) - x - 10
          e1 = (11 * g + 20 + z - x) `mod` 30
          e2 = if e1 == 25 && g > 11 then e1 + 1 else e1
          n1 = 44 - e2
          n2 = if n1 < 21 then n1 + 30 else n1
          n3 = n2 + 7 - ((d + n2) `mod` 7)
      in if n3 > 31
         then show (n3 - 31) ++ " April, " ++ show y
         else show n3 ++ " March, " ++ show y
    ghci> easter 2012
    "8 April, 2012"

<br />
**Lessons Learned**

My initial attempt to implement this did not contain any calls to "fromIntegral" that you see above. However, that version did not compile. It took me some time to figure out -- with help from the nice people at [Stack Overflow](http://stackoverflow.com/questions/14667662/haskell-type-coercion).  I learned more about Haskell's type system, which doesn't support any type coercion. Instead, it is parametric polymorphic.

When you use a literal in a program, let's say 3, Haskell will assign a type derived from Num to it depending on the expression it is used in.

    ghci> :t 3
    3 :: Num a => a
    ghci> :t 3 / 4
    3 / 4 :: Fractional a => a

In the first example, 3 is not used, so the compiler is not sure what actual type it is, so it is left as Num.  In the second example it is used with the / operator which has the type: Fractional a => a -> a -> a, so the compiler assumes you mean 5 to be a Fractional, and everything is fine.

The problem I had was that once a variable is defined to as a concrete type, the compiler does not convert it automatically.  For example:

    ghci> let x = 3
    ghci> :t x
    x :: Integer
    ghci> x / 4

    <interactive>:8:3:
        No instance for (Fractional Integer)
          arising from a use of `/'
        Possible fix: add an instance declaration for (Fractional Integer)
        In the expression: x / 4
        In an equation for `it': it = x / 4

In this case, x is an Integer, and it does not play well with the / operator.  To fix this we need to use the fromIntegral, which returns a Num, thus releasing the variable from its type constraint and allowing it to be used with any function which takes any number type.

    ghci> fromIntegral x / 4
    0.75

Here is Haskell's number type hierarchy:
![Haskell Type Hierarchy](http://media.tumblr.com/af016a9af121e27d4ea63954057fa00e/tumblr_inline_mhmeo7RVcf1qz4rgp.png)
