module Main where

import Data.Set (Set)
import Data.Set qualified as Set

parseInput :: [String] -> Set (Int, Int)
parseInput input =
  Set.fromList
    [ (x, y)
    | (y, row) <- zip [0 ..] input,
      (x, char) <- zip [0 ..] row,
      char == '@'
    ]

isAccessible :: Set (Int, Int) -> (Int, Int) -> Bool
isAccessible allRolls (x, y) = activeNeighbors < 4
  where
    activeNeighbors =
      length
        [ ()
        | dx <- [-1 .. 1],
          dy <- [-1 .. 1],
          (dx, dy) /= (0, 0),
          Set.member (x + dx, y + dy) allRolls
        ]

solvePart1 :: Set (Int, Int) -> Int
solvePart1 initialRolls =
  Set.size (Set.filter (isAccessible initialRolls) initialRolls)

solvePart2 :: Set (Int, Int) -> Int
solvePart2 currentRolls =
  let removable = Set.filter (isAccessible currentRolls) currentRolls
      count = Set.size removable
   in if count == 0
        then 0
        else
          let remainingRolls = Set.difference currentRolls removable
           in count + solvePart2 remainingRolls

main :: IO ()
main = do
  rawInput <- getContents
  let allRolls = parseInput (lines rawInput)

  putStrLn "--- Day 4 Solutions ---"

  putStr "Part 1: "
  print (solvePart1 allRolls)

  putStr "Part 2: "
  print (solvePart2 allRolls)
