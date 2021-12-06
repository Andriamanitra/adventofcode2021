import Data.List

-- Integer rather than Int for arbitrary precision
type Fishies = (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer)

readNums :: String -> [Int]
readNums s = case break (','==) s of
    (first, (',':rest)) -> read first : readNums rest
    (first, "") -> [read first]

fishiesByAge :: Fishies -> [Int] -> Fishies
fishiesByAge fs [] = fs
fishiesByAge (f0, f1, f2, f3, f4, f5, f6, f7, f8) (x:xs) =
    fishiesByAge
        ( f0 + toInteger (fromEnum (x == 0))
        , f1 + toInteger (fromEnum (x == 1))
        , f2 + toInteger (fromEnum (x == 2))
        , f3 + toInteger (fromEnum (x == 3))
        , f4 + toInteger (fromEnum (x == 4))
        , f5 + toInteger (fromEnum (x == 5))
        , f6 + toInteger (fromEnum (x == 6))
        , f7 + toInteger (fromEnum (x == 7))
        , f8 + toInteger (fromEnum (x == 8))
        ) xs

advanceDay :: Fishies -> Fishies
advanceDay (f0, f1, f2, f3, f4, f5, f6, f7, f8) =
    (f1, f2, f3, f4, f5, f6, f7+f0, f8, f0)

fishCount :: Fishies -> Integer
fishCount (f0, f1, f2, f3, f4, f5, f6, f7, f8) =
    f0 + f1 + f2 + f3 + f4 + f5 + f6 + f7 + f8

main = do
    input <- readNums  <$> readFile "input.txt"
    let fishies = fishiesByAge (0,0,0,0,0,0,0,0,0) input
    let fishiesOnDay = iterate advanceDay fishies
    -- Part 1
    print $ fishCount $ fishiesOnDay !! 80
    -- Part 2
    print $ fishCount $ fishiesOnDay !! 256
