

elcd :: Integral a => a -> a -> (a, a, a)
elcd m n | m < n     = elcd n m
         | otherwise = pelcd m 1 0 n 0 1
  where q = m `div` n
        pelcd :: Integral a => a -> a -> a -> a -> a -> a -> (a, a, a)
        pelcd c a1 b1 d a2 b2
          | c == 1 || d == 0 = (c, a1, b1)
          | otherwise        = pelcd d a2 b2 (c - q * d) (a1 - q * a2) (b1 - q * b2)
          where q = c `div` d

-- ghci> elcd 1769 551
-- (29,5,-16)
