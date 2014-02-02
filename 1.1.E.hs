
lcd :: Integral a => a -> a -> a
lcd m n
  | r == 0 = n
  | otherwise = lcd n r
  where r = m `mod` n

-- lcd 119 544
