import System.IO

solvePart1 :: [[String]] -> Int
solvePart1 input = solve (0, 0) input
    where
        solve (x, y) [] = x * y
        solve (x, y) ([instruction, num]:rest) = solve nextPos rest
            where
                n = read num :: Int
                move "forward" = (x + n, y)
                move "up"      = (x, y - n)
                move "down"    = (x, y + n)
                nextPos = move instruction

solvePart2 :: [[String]] -> Int
solvePart2 input = solve (0, 0, 0) input
    where
        solve (x, y, aim) [] = x * y
        solve (x, y, aim) ([instruction, num]:rest) = solve nextPos rest
            where
                n = read num :: Int
                move "forward" = (x + n, y + n * aim, aim)
                move "up"      = (x, y, aim - n)
                move "down"    = (x, y, aim + n)
                nextPos = move instruction

main :: IO()
main = do
    contents <- openFile "input.txt" ReadMode >>= hGetContents
    let input = map words $ lines contents
    print $ solvePart1 input
    print $ solvePart2 input
