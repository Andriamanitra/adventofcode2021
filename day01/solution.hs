import System.IO

readInt :: String -> Int
readInt = read

main :: IO()
main = do
    contents <- openFile "input.txt" ReadMode >>= hGetContents
    let nums = map readInt $ lines contents
    
    let countLatterGreater = sum . map (fromEnum . uncurry (<))

    -- Part 1
    print $ countLatterGreater $ zip nums (drop 1 nums)
    
    -- Part 2
    print $ countLatterGreater $ zip nums (drop 3 nums)
