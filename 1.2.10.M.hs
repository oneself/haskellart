**Given a list of *n* numbers, find the maximum number, and the index of the maximum.**

    maxi :: (Ord a) => [a] -> (a, Int)
    maxi l =
      let pmaxi :: (Ord a) => [a] -> Int -> (a, Int) -- Internal function to do the work
          pmaxi [] _  = error "Empty list"           -- List is empty, error
          pmaxi [x] xi = (x, xi)                     -- List has one item, return it and the index
          pmaxi (x:xs) xi                            -- More than one item, break list apart
            | x > t     = (x, xi)                    -- If current item is bigger, return it and its index
            | otherwise = (t, ti)                    -- If list tail has a bigger item, return that
            where (t, ti) = pmaxi xs (xi + 1)        -- Get max of tail of the list
      in pmaxi l 0                                   -- Call internal function with start index


    ghci> maxi [2, 3, 4, 2, 1, 2, 3]
    (4,2)

<br />
**Lessons Learned**

My initial implementation had a bug in the where clause. I defined it as follows

    (t, ti) = pmaxim xs (ti + 1)

So, ti was defined as a function of itself, which made it impossible to actually calculate.  The
weird thing was that Haskell was actually able to partially figure out the maximum value "t" because
of its lazy nature.  When I ran that buggy version I got the following:

    ghci> maxi [2, 3, 4, 2, 1, 2, 3]
    (4,

So, Haskell calculated that max value but hanged waiting for the max index to resolve itself
somehow.
