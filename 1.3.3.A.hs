
-- 1.3.3.A Multiply permutations in cycle form

-- data Letter = Tagged Char | Untagged Char deriving (Show)
-- letters :: [[Char]] -> [[Letter]]
-- letters l = map (\xs -> map (\x -> Untagged x) xs) l


multiplyCycle :: [String] -> [String]
multiplyCycle [] = []
multiplyCycle
