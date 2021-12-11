import System.IO
import Data.Char (digitToInt)
import Data.Set (Set)
import qualified Data.Set as Set

rows = 10
cols = 10

validNeighbors :: Int -> [Int]
validNeighbors i = map toFlatIndex $ filter valid neighbors
  where valid (x, y) = x >= 0 && x < cols && y >= 0 && y < rows
        c = i `mod` cols
        r = i `div` cols
        neighbors = [(x,y) | x <- [c-1,c,c+1], y <- [r-1,r,r+1]]
        toFlatIndex (x, y) = y * cols + x

flash :: (Set Int) -> [Int] -> (Int, [Int])
flash flashed input
  | flashes == [] = (Set.size flashed, input)
  | otherwise = flash (Set.union flashed $ Set.fromList flashes) out
  where flashes = [i | (i, v) <- zip [0..] input, v > 9, i `Set.notMember` flashed]
        toIncrement = [i | f <- flashes, i <- validNeighbors f]
        out = [v + (length $ filter (==i) toIncrement) | (i, v) <- zip [0..] input]

resetFlashed :: (Int, [Int]) -> (Int, [Int])
resetFlashed (x, input) = (x, out)
    where out = map (\x -> if x > 9 then 0 else x) input

step :: (Int, [Int]) -> (Int, [Int])
step (acc, input) = resetFlashed $ flash Set.empty $ map (+1) input

part1 :: [Int] -> Int
part1 input = sum $ map fst $ take 100 $ tail $ iterate step (0, input)

part2 :: [Int] -> Int
part2 input = length $ takeWhile (<100) $ map fst $ iterate step (0, input)

main = do
    contents <- openFile "input.txt" ReadMode >>= hGetContents
    let input = map digitToInt $ concat $ lines contents
    print $ part1 input
    print $ part2 input
