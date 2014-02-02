induction :: (Integral a) => (a -> a) -> (a -> a) -> a -> Bool
induction f g n
  | n == 0 = True
  | fsum f n /= g n = False
  | otherwise = True               
  where fsum :: (Integral a) => (a -> a) -> a -> a
        fsum _ 0 = 0
        fsum f n = f n + fsum f (n - 1)
                     
-- induction (\x -> 2 * x - 1) (\x -> x ^ 2) 1000
-- True
