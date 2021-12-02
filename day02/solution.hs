import System.IO
import Data.Char (toUpper)

data Instruction = Forward Int | Up Int | Down Int deriving (Read)

readInstruction :: String -> Instruction
readInstruction (x:xs) = read capitalized where capitalized = toUpper x : xs

solvePart1 :: [Instruction] -> Int
solvePart1 input = solve (0, 0) input
    where
        solve (x, y) [] = x * y
        solve (x, y) (instruction:rest) =
            let nextPos = case instruction of
                    Forward n -> (x + n, y)
                    Up n      -> (x, y - n)
                    Down n    -> (x, y + n)
            in solve nextPos rest

solvePart2 :: [Instruction] -> Int
solvePart2 input = solve (0, 0, 0) input
    where
        solve (x, y, aim) [] = x * y
        solve (x, y, aim) (instruction:rest) =
            let nextPos = case instruction of
                    Forward n -> (x + n, y + n * aim, aim)
                    Up n      -> (x, y, aim - n)
                    Down n    -> (x, y, aim + n)
            in solve nextPos rest

main :: IO()
main = do
    contents <- openFile "input.txt" ReadMode >>= hGetContents
    let input = map readInstruction $ lines contents
    print $ solvePart1 input
    print $ solvePart2 input
