module Main
  (
    main
  ) where
    
import qualified Data.Map
import Data.Char
import System.Console.ANSI

-- types and data
data Player = Player1 | Player2 | EmptyPl | Selected deriving (Eq, Show)
data Direction = UpD | DownD | LeftD | RightD
data Quadrant = FirstQuad | SecondQuad | ThirdQuad | FourthQuad
data Difficulty = Easy | Medium | Hard deriving Show

type Position = (Char, Char)
type Cell = (Char, Player)
type Board = Data.Map.Map Position Cell
type MatchData = (Difficulty, String, String)
type Coordinates = (Int, Int)
type CapturedPieces = ([Char], [Char])

-- Auxiliary functions:
opponent :: Player -> Player
opponent Player1 = Player2
opponent Player2 = Player1
opponent _ = EmptyPl

uppercase :: [Char] -> [Char]
uppercase [] = []
uppercase (h:t) = toUpper h : uppercase t


-- Positions mapping:
invalidCell :: Cell
invalidCell = ('*', EmptyPl)

getPiece :: Cell -> Char
getPiece (piece, _) = piece

getPlayer :: Cell -> Player
getPlayer (_, player) = player

playerAtPos :: Board -> Position -> Player
playerAtPos board position = getPlayer $ Data.Map.findWithDefault invalidCell position board 

pieceAtPos :: Board -> Position -> Char
pieceAtPos board position = getPiece $ Data.Map.findWithDefault invalidCell position board

cellAtPos :: Board -> Position -> Cell
cellAtPos board pos = Data.Map.findWithDefault invalidCell pos board

posIndexes :: Position -> Coordinates
posIndexes (l, c) = (fromEnum(l) - fromEnum('A'), fromEnum(c) - fromEnum('0'))

coordinateToPosition :: Coordinates -> Position
coordinateToPosition (l, c) = (chr(l+65), chr(c + 48))

line :: Coordinates -> Int
line (l, _) = l

column :: Coordinates -> Int
column (_, c) = c

-- Data structures:
newEasyBoard :: Board
newEasyBoard = Data.Map.fromList[(('A', '0'), ('r', Player2)), (('A', '1'), ('K', Player2)), (('A', '2'), ('b', Player2)), 
                                 (('B', '0'), (' ', EmptyPl)), (('B', '1'), ('p', Player2)), (('B', '2'), (' ', EmptyPl)), 
                                 (('C', '0'), (' ', EmptyPl)), (('C', '1'), ('p', Player1)), (('C', '2'), (' ', EmptyPl)), 
                                 (('D', '0'), ('b', Player1)), (('D', '1'), ('K', Player1)), (('D', '2'), ('r', Player1))] 

newMediumBoard :: Board
newMediumBoard = Data.Map.fromList[(('A', '0'), ('l', Player2)), (('A', '1'), ('n', Player2)), (('A', '2'), ('s', Player2)),  (('A', '3'), ('G', Player2)), (('A', '4'), ('K', Player2)), (('A', '5'), ('G', Player2)), (('A', '6'), ('s', Player2)), (('A', '7'), ('n', Player2)), (('A', '8'), ('l', Player2)),
                                   (('B', '0'), (' ', EmptyPl)), (('B', '1'), ('r', Player2)), (('B', '2'), (' ', EmptyPl)),  (('B', '3'), (' ', EmptyPl)), (('B', '4'), (' ', EmptyPl)), (('B', '5'), (' ', EmptyPl)), (('B', '6'), (' ', EmptyPl)), (('B', '7'), ('b', Player2)), (('B', '8'), (' ', EmptyPl)),
                                   (('C', '0'), ('p', Player2)), (('C', '1'), ('p', Player2)), (('C', '2'), ('p', Player2)),  (('C', '3'), ('p', Player2)), (('C', '4'), ('p', Player2)), (('C', '5'), ('p', Player2)), (('C', '6'), ('p', Player2)), (('C', '7'), ('p', Player2)), (('C', '8'), ('p', Player2)),
                                   (('D', '0'), (' ', EmptyPl)), (('D', '1'), (' ', EmptyPl)), (('D', '2'), (' ', EmptyPl)),  (('D', '3'), (' ', EmptyPl)), (('D', '4'), (' ', EmptyPl)), (('D', '5'), (' ', EmptyPl)), (('D', '6'), (' ', EmptyPl)), (('D', '7'), (' ', EmptyPl)), (('D', '8'), (' ', EmptyPl)),
                                   (('E', '0'), (' ', EmptyPl)), (('E', '1'), (' ', EmptyPl)), (('E', '2'), (' ', EmptyPl)),  (('E', '3'), (' ', EmptyPl)), (('E', '4'), (' ', EmptyPl)), (('E', '5'), (' ', EmptyPl)), (('E', '6'), (' ', EmptyPl)), (('E', '7'), (' ', EmptyPl)), (('E', '8'), (' ', EmptyPl)),
                                   (('F', '0'), (' ', EmptyPl)), (('F', '1'), (' ', EmptyPl)), (('F', '2'), (' ', EmptyPl)),  (('F', '3'), (' ', EmptyPl)), (('F', '4'), (' ', EmptyPl)), (('F', '5'), (' ', EmptyPl)), (('F', '6'), (' ', EmptyPl)), (('F', '7'), (' ', EmptyPl)), (('F', '8'), (' ', EmptyPl)),
                                   (('G', '0'), ('p', Player1)), (('G', '1'), ('p', Player1)), (('G', '2'), ('p', Player1)),  (('G', '3'), ('p', Player1)), (('G', '4'), ('p', Player1)), (('G', '5'), ('p', Player1)), (('G', '6'), ('p', Player1)), (('G', '7'), ('p', Player1)), (('G', '8'), ('p', Player1)),
                                   (('H', '0'), (' ', EmptyPl)), (('H', '1'), ('b', Player1)), (('H', '2'), (' ', EmptyPl)),  (('H', '3'), (' ', EmptyPl)), (('H', '4'), (' ', EmptyPl)), (('H', '5'), (' ', EmptyPl)), (('H', '6'), (' ', EmptyPl)), (('H', '7'), ('r', Player1)), (('H', '8'), (' ', EmptyPl)),
                                   (('I', '0'), ('l', Player1)), (('I', '1'), ('n', Player1)), (('I', '2'), ('s', Player1)),  (('I', '3'), ('G', Player1)), (('I', '4'), ('K', Player1)), (('I', '5'), ('G', Player1)), (('I', '6'), ('s', Player1)), (('I', '7'), ('n', Player1)), (('I', '8'), ('l', Player1))]

newHardBoard :: Board
newHardBoard = Data.Map.fromList[   (('A', '0'), ('l', Player2)), (('A', '1'), ('n', Player2)), (('A', '2'), ('i', Player2)), (('A', '3'), ('c', Player2)), (('A', '4'), ('s', Player2)), (('A', '5'), ('G', Player2)), (('A', '6'), ('K', Player2)), (('A', '7'), ('G', Player2)), (('A', '8'), ('s', Player2)), (('A', '9'), ('c', Player2)), (('A', 'X'), ('i', Player2)), (('A', 'Y'), ('n', Player2)), (('A', 'Z'), ('l', Player2)), 
                                    (('B', '0'), ('f', Player2)), (('B', '1'), ('d', Player2)), (('B', '2'), (' ', EmptyPl)), (('B', '3'), (' ', EmptyPl)), (('B', '4'), ('t', Player2)), (('B', '5'), (' ', EmptyPl)), (('B', '6'), ('m', Player2)), (('B', '7'), (' ', EmptyPl)), (('B', '8'), ('t', Player2)), (('B', '9'), (' ', EmptyPl)), (('B', 'X'), (' ', EmptyPl)), (('B', 'Y'), ('d', Player2)), (('B', 'Z'), ('f', Player2)), 
                                    (('C', '0'), ('p', Player2)), (('C', '1'), ('p', Player2)), (('C', '2'), ('p', Player2)), (('C', '3'), ('p', Player2)), (('C', '4'), ('p', Player2)), (('C', '5'), ('p', Player2)), (('C', '6'), ('p', Player2)), (('C', '7'), ('p', Player2)), (('C', '8'), ('p', Player2)), (('C', '9'), ('p', Player2)), (('C', 'X'), ('p', Player2)), (('C', 'Y'), ('p', Player2)), (('C', 'Z'), ('p', Player2)), 
                                    (('D', '0'), (' ', EmptyPl)), (('D', '1'), (' ', EmptyPl)), (('D', '2'), (' ', EmptyPl)), (('D', '3'), (' ', EmptyPl)), (('D', '4'), (' ', EmptyPl)), (('D', '5'), (' ', EmptyPl)), (('D', '6'), ('w', Player2)), (('D', '7'), (' ', EmptyPl)), (('D', '8'), (' ', EmptyPl)), (('D', '9'), (' ', EmptyPl)), (('D', 'X'), (' ', EmptyPl)), (('D', 'Y'), (' ', EmptyPl)), (('D', 'Z'), (' ', EmptyPl)), 
                                    (('E', '0'), (' ', EmptyPl)), (('E', '1'), (' ', EmptyPl)), (('E', '2'), (' ', EmptyPl)), (('E', '3'), (' ', EmptyPl)), (('E', '4'), (' ', EmptyPl)), (('E', '5'), (' ', EmptyPl)), (('E', '6'), (' ', EmptyPl)), (('E', '7'), (' ', EmptyPl)), (('E', '8'), (' ', EmptyPl)), (('E', '9'), (' ', EmptyPl)), (('E', 'X'), (' ', EmptyPl)), (('E', 'Y'), (' ', EmptyPl)), (('E', 'Z'), (' ', EmptyPl)), 
                                    (('F', '0'), (' ', EmptyPl)), (('F', '1'), (' ', EmptyPl)), (('F', '2'), (' ', EmptyPl)), (('F', '3'), (' ', EmptyPl)), (('F', '4'), (' ', EmptyPl)), (('F', '5'), (' ', EmptyPl)), (('F', '6'), (' ', EmptyPl)), (('F', '7'), (' ', EmptyPl)), (('F', '8'), (' ', EmptyPl)), (('F', '9'), (' ', EmptyPl)), (('F', 'X'), (' ', EmptyPl)), (('F', 'Y'), (' ', EmptyPl)), (('F', 'Z'), (' ', EmptyPl)), 
                                    (('G', '0'), (' ', EmptyPl)), (('G', '1'), (' ', EmptyPl)), (('G', '2'), (' ', EmptyPl)), (('G', '3'), (' ', EmptyPl)), (('G', '4'), (' ', EmptyPl)), (('G', '5'), (' ', EmptyPl)), (('G', '6'), (' ', EmptyPl)), (('G', '7'), (' ', EmptyPl)), (('G', '8'), (' ', EmptyPl)), (('G', '9'), (' ', EmptyPl)), (('G', 'X'), (' ', EmptyPl)), (('G', 'Y'), (' ', EmptyPl)), (('G', 'Z'), (' ', EmptyPl)), 
                                    (('H', '0'), (' ', EmptyPl)), (('H', '1'), (' ', EmptyPl)), (('H', '2'), (' ', EmptyPl)), (('H', '3'), (' ', EmptyPl)), (('H', '4'), (' ', EmptyPl)), (('H', '5'), (' ', EmptyPl)), (('H', '6'), (' ', EmptyPl)), (('H', '7'), (' ', EmptyPl)), (('H', '8'), (' ', EmptyPl)), (('H', '9'), (' ', EmptyPl)), (('H', 'X'), (' ', EmptyPl)), (('H', 'Y'), (' ', EmptyPl)), (('H', 'Z'), (' ', EmptyPl)), 
                                    (('I', '0'), (' ', EmptyPl)), (('I', '1'), (' ', EmptyPl)), (('I', '2'), (' ', EmptyPl)), (('I', '3'), (' ', EmptyPl)), (('I', '4'), (' ', EmptyPl)), (('I', '5'), (' ', EmptyPl)), (('I', '6'), (' ', EmptyPl)), (('I', '7'), (' ', EmptyPl)), (('I', '8'), (' ', EmptyPl)), (('I', '9'), (' ', EmptyPl)), (('I', 'X'), (' ', EmptyPl)), (('I', 'Y'), (' ', EmptyPl)), (('I', 'Z'), (' ', EmptyPl)), 
                                    (('J', '0'), (' ', EmptyPl)), (('J', '1'), (' ', EmptyPl)), (('J', '2'), (' ', EmptyPl)), (('J', '3'), (' ', EmptyPl)), (('J', '4'), (' ', EmptyPl)), (('J', '5'), (' ', EmptyPl)), (('J', '6'), ('w', Player1)), (('J', '7'), (' ', EmptyPl)), (('J', '8'), (' ', EmptyPl)), (('J', '9'), (' ', EmptyPl)), (('J', 'X'), (' ', EmptyPl)), (('J', 'Y'), (' ', EmptyPl)), (('J', 'Z'), (' ', EmptyPl)), 
                                    (('K', '0'), ('p', Player1)), (('K', '1'), ('p', Player1)), (('K', '2'), ('p', Player1)), (('K', '3'), ('p', Player1)), (('K', '4'), ('p', Player1)), (('K', '5'), ('p', Player1)), (('K', '6'), ('p', Player1)), (('K', '7'), ('p', Player1)), (('K', '8'), ('p', Player1)), (('K', '9'), ('p', Player1)), (('K', 'X'), ('p', Player1)), (('K', 'Y'), ('p', Player1)), (('K', 'Z'), ('p', Player1)), 
                                    (('L', '0'), ('f', Player1)), (('L', '1'), ('d', Player1)), (('L', '2'), (' ', EmptyPl)), (('L', '3'), (' ', EmptyPl)), (('L', '4'), ('t', Player1)), (('L', '5'), (' ', EmptyPl)), (('L', '6'), ('m', Player1)), (('L', '7'), (' ', EmptyPl)), (('L', '8'), ('t', Player1)), (('L', '9'), (' ', EmptyPl)), (('L', 'X'), (' ', EmptyPl)), (('L', 'Y'), ('d', Player1)), (('L', 'Z'), ('f', Player1)), 
                                    (('M', '0'), ('l', Player1)), (('M', '1'), ('n', Player1)), (('M', '2'), ('i', Player1)), (('M', '3'), ('c', Player1)), (('M', '4'), ('s', Player1)), (('M', '5'), ('G', Player1)), (('M', '6'), ('K', Player1)), (('M', '7'), ('G', Player1)), (('M', '8'), ('s', Player1)), (('M', '9'), ('c', Player1)), (('M', 'X'), ('i', Player1)), (('M', 'Y'), ('n', Player1)), (('M', 'Z'), ('l', Player1))]

header :: String
header = "                                                    d8b                          d8,\n" ++ 
         "                                                    ?88                         `8P \n" ++
         "                                                     88b                            \n" ++
         "                                                     88b                            \n" ++
         "  88bd88b  d888b8b    88bd88b d888b8b        d888b,  888888b  d8888b  d888b8b    88b\n" ++
         "  88P' ?8bd8P' ?88    88P'  `d8P' ?88       ?8b,     88P `?8bd8P' ?88d8P' ?88    88P\n" ++
         " d88   88P88b  ,88b  d88     88b  ,88b        `?8b  d88   88P88b  d8888b  ,88b  d88 \n" ++
         "d88'   88b`?88P'`88bd88'     `?88P'`88b    `?888P' d88'   88b`?8888P'`?88P'`88bd88' \n" ++
         "                                                                            )88     \n" ++
         "                                                                           ,88P     \n" ++
         "                                                                       `?8888P      \n"

-- Board printing:
printBoard :: Board -> Difficulty -> IO()
printBoard board Medium = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn "      0     1     2     3     4     5     6     7     8   "
    setSGR [Reset]
    putStrLn "   #######################################################"
    printLines board ['A'..'I'] Medium
printBoard board Easy = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn "      0     1     2"
    setSGR [Reset]
    putStrLn "   ###################"
    printLines board ['A'..'D'] Easy
printBoard board Hard = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn "      0     1     2     3     4     5     6     7     8     9     X     Y     Z"
    setSGR [Reset]
    putStrLn "   ###############################################################################"
    printLines board ['A'..'M'] Hard

printLines :: Board -> [Char] -> Difficulty -> IO()
printLines _ [] Medium = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn "      0     1     2     3     4     5     6     7     8   "
    setSGR [Reset]
printLines _ [] Easy = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn "      0     1     2"
    setSGR [Reset]
printLines _ [] Hard = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn "      0     1     2     3     4     5     6     7     8     9     X     Y     Z"
    setSGR [Reset]

printLines board (x:xs) Medium = do
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    setSGR [SetColor Foreground Vivid Magenta]
    putStr (" " ++ [x])
    setSGR [Reset]
    putStr " #"
    displayLine (linePieces board x Medium) (linePlayers board x Medium)
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    putStrLn "   #######################################################"
    printLines board xs Medium

printLines board (x:xs) Easy = do
    putStrLn "   #     #     #     #"
    setSGR [SetColor Foreground Vivid Magenta]
    putStr (" " ++ [x])
    setSGR [Reset]
    putStr " #"
    displayLine (linePieces board x Easy) (linePlayers board x Easy)
    putStrLn "   #     #     #     #"
    putStrLn "   ###################"
    printLines board xs Easy

printLines board (x:xs) Hard = do
    putStrLn "   #     #     #     #     #     #     #     #     #     #     #     #     #     #"
    setSGR [SetColor Foreground Vivid Magenta]
    putStr (" " ++ [x])
    setSGR [Reset]
    putStr " #"
    displayLine (linePieces board x Hard) (linePlayers board x Hard)
    putStrLn "   #     #     #     #     #     #     #     #     #     #     #     #     #     #"
    putStrLn "   ###############################################################################"
    printLines board xs Hard
    

linePieces :: Board -> Char -> Difficulty -> [Char]
linePieces board l Medium = [pieceAtPos (board) ((l, b)) | b <- ['0'..'8']]
linePieces board l Easy = [pieceAtPos (board) ((l, b)) | b <- ['0'..'2']]
linePieces board l Hard = [pieceAtPos (board) ((l, b)) | b <- ['0'..'9'] ++ ['X', 'Y', 'Z']]

linePlayers :: Board -> Char -> Difficulty -> [Player]
linePlayers board l Medium = [playerAtPos (board) ((l, b)) | b <- ['0'..'8']]
linePlayers board l Easy = [playerAtPos (board) ((l, b)) | b <- ['0'..'2']] 
linePlayers board l Hard = [playerAtPos (board) ((l, b)) | b <- ['0'..'9'] ++ ['X', 'Y', 'Z']]


displayLine :: [Char] -> [Player] -> IO()
displayLine [] [] = putStr "\n"
displayLine (x:xs) (y:ys)
    | y == Player1 = do
        putStr "  "
        setSGR [SetColor Foreground Vivid Cyan] 
        putStr [x]
        setSGR [Reset]
        putStr "  #"
        displayLine xs ys
    | y == Player2 = do
        putStr "  "
        setSGR [SetColor Foreground Vivid Yellow] 
        putStr [x]
        setSGR [Reset]
        putStr "  #"
        displayLine xs ys
    | y == Selected = do
        setSGR [SetColor Foreground Vivid Green] 
        putStr (" <" ++ [x] ++ ">")
        setSGR [Reset]
        putStr " #"
        displayLine xs ys
    | otherwise = do
        putStr ("     #") 
        displayLine xs ys
displayLine _ _ = print "Error on printing the Line"

printPlayerName :: Player -> MatchData -> IO()
printPlayerName Player1 matchData = do
    putStr " "
    setSGR [SetColor Foreground Vivid Cyan]    
    putStr (getPlayer1Name  matchData)
    setSGR [Reset]
printPlayerName Player2 matchData = do
    putStr " "
    setSGR [SetColor Foreground Vivid Yellow]
    putStr (getPlayer2Name matchData)
    setSGR [Reset]
printPlayerName _ _ = printWarning "Error on handling the current Player."

printWarning :: String -> IO()
printWarning message = do
    setSGR [SetColor Foreground Vivid Red]
    putStrLn message
    setSGR [Reset]

difficultyCode :: String -> Difficulty
difficultyCode "3" = Hard
difficultyCode "2" = Medium
difficultyCode "1" = Easy
difficultyCode _ = Medium -- default difficulty


printHeader :: IO()
printHeader = do
    setSGR [SetColor Foreground Vivid Magenta] 
    putStrLn (header)
    setSGR [Reset]

-- Handling inputs:
getCellLine :: String -> Char
getCellLine "" = '*'
getCellLine (x:xs) | xs == "" = '*'
               | length xs > 1 = '*'
               | otherwise = Data.Char.toUpper x


getCellColumn :: String -> Char
getCellColumn [] = '*'
getCellColumn (_:y:ys) | (length(y:ys)) == 0 = '*'
                       | (length ys) /= 0 = '*'
                       | otherwise = Data.Char.toUpper y
getCellColumn x | length(x) /= 2 = '*'
                | otherwise = getCellColumn x

isValidInputPosition :: String -> Board -> Bool
isValidInputPosition input board
    | length(input) /= 2 = False
    | Data.Map.member (l, c) board = True
    | otherwise = False
    where l = getCellLine input
          c = getCellColumn input

-- Gets:
getPlayer1Name :: MatchData -> String
getPlayer1Name (_, p1, _) = p1

getPlayer2Name :: MatchData -> String
getPlayer2Name (_, _, p2) = p2

getDifficulty :: MatchData -> Difficulty
getDifficulty (dif, _, _) = dif

--Game mechanics:
move :: Board -> Position -> Position -> Board
move board origin target = Data.Map.insert origin (' ', EmptyPl) (Data.Map.insert target (pieceAtPos board origin, playerAtPos board origin) board)

promotedCell :: Cell -> Cell
promotedCell (piece, player) = ((Data.Char.toUpper (piece)), player)

checkPromotion :: Board -> Position -> Player -> Difficulty -> Board

checkPromotion board target Player1 Easy | (pieceAtPos board target) /= 'p' = board
                                         | line(posIndexes(target)) == 0 = Data.Map.insert target (promotedCell $ cellAtPos board target) board
                                         | otherwise = board
checkPromotion board target Player2 Easy | (pieceAtPos board target) /= 'p' = board
                                         | line(posIndexes(target)) == 3 = Data.Map.insert target (promotedCell $ cellAtPos board target) board
                                         | otherwise = board  

checkPromotion board target Player1 _ | line(posIndexes(target)) < 3 = Data.Map.insert target (promotedCell $ cellAtPos board target) board
                                      | otherwise = board
checkPromotion board target Player2 Medium | line(posIndexes(target)) > 5 = Data.Map.insert target (promotedCell $ cellAtPos board target) board
                                      | otherwise = board
checkPromotion board target Player2 Hard | line(posIndexes(target)) > 9 = Data.Map.insert target (promotedCell $ cellAtPos board target) board
                                      | otherwise = board  
checkPromotion board _ _ _ = board                


isValidMove :: Position -> Position -> Player -> Board -> Difficulty -> Bool
isValidMove origin target player board Easy = (isKingMove (posIndexes(origin)) (posIndexes(target))) && (isPieceMove (posIndexes(origin)) (posIndexes(target)) board player (pieceAtPos board origin)) && (player == (playerAtPos board origin)) && (player /= (playerAtPos board target))
isValidMove origin target player board _ = (isPieceMove (posIndexes(origin)) (posIndexes(target)) board player (pieceAtPos board origin)) && (player == (playerAtPos board origin)) && (player /= (playerAtPos board target))

-- External commands:
checkCommand :: String -> Player -> MatchData -> Board -> CapturedPieces -> IO()
checkCommand "R" _ matchData _ _ = do
    clearScreen
    startMatch matchData
checkCommand "E" _ _ _ _ = main
checkCommand "H" player match board captured = do
    clearScreen
    help
    startTurn player match board captured
checkCommand _ player match board captured = do
    clearScreen
    printWarning "Invalid origin entry. Try again: "
    startTurn player match board captured 

checkCommand2 :: String -> Player -> MatchData -> Board -> CapturedPieces -> IO()
checkCommand2 "R" _ matchData _ _ = do
    clearScreen
    startMatch matchData
checkCommand2 "E" _ _ _ _ = main
checkCommand2 "H" player match board captured = do
    clearScreen
    help
    startTurn player match board captured
checkCommand2 "B" player match board captured = do
    clearScreen
    printWarning "Coordinates selection undone."
    originInput player match board captured
checkCommand2 _ player match board captured = do
    clearScreen
    printWarning "Invalid move entry. Try again: "
    originInput player match board captured

help :: IO()
help = do
    putStrLn "1 - English"
    putStrLn "2 - Portugues"
    k <- getLine
    helpLanguageSel k

helpLanguageSel :: String -> IO()
helpLanguageSel "1" = helpEng
helpLanguageSel "2" = helpPor
helpLanguageSel _ = do
    clearScreen
    printWarning "Invalid entry"
    help

helpEng :: IO()
helpEng = do
    clearScreen
    putStrLn "(K) The king moves one square in any direction, orthogonal or diagonal;"
    putStrLn "(r) A rook moves any numeer of squares in an orthogonal direction;"
    putStrLn "(b) A bishop moves any number of squares in a diagonal direction;"
    putStrLn "(G) A gold general moves one square orthogonally, or one square diagonally forward. It cannot move diagonally backwards;"
    putStrLn "(s) A silver general moves one square diagonally, one square straight forward, or one square diaggonally bacwards;"
    putStrLn "(n) A knight jumps at an angle intermediate to orthogonal and diagonal in a single move;"
    putStrLn "(L) A lancer moves only straight ahead, it cannot jump other pieces;"
    putStrLn "(p) A pawm moves one square straight forward. It cannot retreat."
    putStrLn ""
    putStrLn "When the game starts you will see the board on screen. So, the player in turn can choose his piece to move typing its coordinates. Sample:"
    putStrLn "   1. Player one's turn;"
    putStrLn "   2. First type: G4 <--> this coordinate points the piece that the player wants to move"
    putStrLn "   3. The selected piece will be colored to make it easy to show what piece the player choose"
    putStrLn "   4. Second type: F4 <--> this coordinate points where the chosen piece goes"
    putStrLn "   5. If it is a valid move, the piece will be placed. Else, the player will be asked to type the coordinates again"
    putStrLn "   6. Turns the player"
    putStrLn ""
    putStrLn "Other commands:\n"
    putStrLn "(B) Undo piece selection --> Type B if you want to select another piece"
    putStrLn "(R) Reset Game --> Type R if you want to reset the game. You can reset the game after the game starts"
    putStrLn "(H) Help with commands --> Type H if you want to get help with the game commands. You can get help after the game starts"
    putStrLn "(E) Exit game --> Type E if you want to close the game and return to the main menu. You can close the game anytime you type this command"
    putStrLn "\nOther mechanics:\n"
    putStrLn "1. Promotion: When a piece reaches the enemy board it gets promoted and gains a new set of moves. Most of the promoted pieces gain Golden General moves."
    putStrLn "   Promoted Bishop and Promoted Rook can move as their common counterparts and also 1 square to any direction. On easy mode only the Pawn is promoted."
    putStrLn "2. Piece dropping: Captured enemy pieces can be dropped on empty positions, now owned by the new player. Select on your turn an empty space and the"
    putStrLn "   piece you wish to drop. Pieces dropped on promotion zone will only promote after moving inside it. The Pawn and the Lancer cannot be dropped on the"
    putStrLn "   last enemy row, and the Knight cannot be dropped on the last 2 rows. Promoted pieces return to their common counterparts when captured."
    printWarning "\nPress enter to return!"
    _ <- getLine
    clearScreen

helpPor :: IO()
helpPor = do
    clearScreen
    putStrLn "(K) O rei pode se mover uma casa em qualquer direção, ortogonal ou diagonal;"
    putStrLn "(r) Uma torre move-se qualquer numero de casas em uma direção ortogonal;"
    putStrLn "(b) Um bispo se move qualquer número de casa em uma direção diagonal;"
    putStrLn "(G) Um general de ouro move uma casa ortogonalmente, ou uma casa diagonalmente para a frente. Não pode se mover diagonalmente para trás;"
    putStrLn "(s) Um general de prata move-se uma casa na diagonal, uma casa diretamente para frente ou uma casa diagonalmente para trás;"
    putStrLn "(n) Um cavaleiro salta em um ângulo intermediário a ortogonal e diagonal em um único movimento;"
    putStrLn "(l) Um lanceiro move-se apenas para frente, não pode pular outras peças;"
    putStrLn "(p) Um peão move-se uma casa para a frente. Não pode recuar."
    putStrLn ""
    putStrLn "Quando o jogo começar, você verá a placa na tela. Assim, o jogador, por sua vez, pode escolher sua peça para se mover digitando suas coordenadas. Amostra:"
    putStrLn "   1. Vez do jogador um;"
    putStrLn "   2. Primeira entrada: G4 <-> esta coordenada aponta a peça que o jogador quer mover."
    putStrLn "   3. A peça selecionada será colorida para facilitar a exibição da peça escolhida pelo jogador."
    putStrLn "   4. Segunda entrada: F4 <-> esta coordenada aponta para onde a peça escolhida vai."
    putStrLn "   5. Se for um lance válido, a peça será colocada. Senão, o jogador será requerido a digitar as coordenadas novamente."
    putStrLn "   6. Muda o jogador da vez."
    putStrLn ""
    putStrLn "Outros comandos:\n"
    putStrLn "(B) Desfazer seleção de peças -> Digite B se você quiser selecionar outra peça"
    putStrLn "(R) Resetar jogo -> Digite R se você quiser redefinir o jogo. Você pode reiniciar o jogo depois que o jogo começar"
    putStrLn "(H) Ajuda com comandos -> Digite H se você quiser obter ajuda com os comandos do jogo. Você pode obter ajuda depois que o jogo começar"
    putStrLn "(E) Fechar jogo -> Digite E se quiser fechar o jogo e voltar pro menu inicial. Você pode fechar o jogo sempre que digitar este comando"
    putStrLn "\nOutras mecânicas: \n"
    putStrLn "1. Promoção: Quando uma peça atinge o tabuleiro inimigo, ela é promovida e ganha um novo conjunto de lances. A maioria das peças promovidas ganham movimentos do Golden General."
    putStrLn "   O Bispo Promovido e a Torre Promovida podem se mover como suas contrapartes comuns e também 1 quadrado para qualquer direção. No modo fácil, apenas o Peão é promovido."
    putStrLn "2. Drop de peças: As peças inimigas capturadas podem ser colocadas em posições vazias, agora de propriedade do novo jogador. Selecione no seu turno um espaço vazio e a"
    putStrLn "   posição em que você deseja colcar. As peças postas na zona de promoção só serão promovidas depois de serem movidas dentro da zona. O Peão e o Lanceiro não podem ser postos na"
    putStrLn "   última linha inimiga, e o Cavaleiro não pode ser posto nas últimas 2 linhas. Peças promovidas retornam às suas contrapartes comuns quando capturadas."
    printWarning "\nPress enter to return!"
    _ <- getLine
    clearScreen

-- Turn phases and types of input:
targetInput :: Position -> Player -> MatchData -> Board -> CapturedPieces -> IO()
targetInput origin currentPlayer matchData boardData capturedPcs = do
    printBoard (Data.Map.insert origin ((pieceAtPos boardData origin), Selected) boardData) (getDifficulty matchData)

    setSGR [SetColor Foreground Vivid Green]
    putStrLn " <Commands: R -  match; E - Exit to menu; H - Help; B - Undo selection>"
    setSGR [Reset]
    
    printPlayerName currentPlayer matchData
    putStr "'s turn. Enter the coordinates of where you want to move to with your piece: "

    inputTarget <- getLine          -- get TARGET
    let targetPos = (getCellLine(inputTarget), getCellColumn(inputTarget))

    if isValidInputPosition inputTarget boardData && isValidMove origin targetPos currentPlayer boardData (getDifficulty matchData)
        then do
            clearScreen 
            let newMove = move boardData origin targetPos
            let checkedBoard = checkPromotion newMove targetPos currentPlayer (getDifficulty matchData)
            let newCaptured = capture (pieceAtPos boardData targetPos) currentPlayer capturedPcs
            startTurn (opponent(currentPlayer)) matchData checkedBoard newCaptured -- SUCESSFUL MOVE switches players

        else checkCommand2 (uppercase (inputTarget)) currentPlayer matchData boardData capturedPcs

originInput :: Player -> MatchData -> Board -> CapturedPieces -> IO()
originInput currentPlayer matchData boardData capturedPcs = do
    printBoard boardData (getDifficulty matchData)

    setSGR [SetColor Foreground Vivid Green]
    putStrLn " <Commands: R - Reset match; E - Exit to menu; H - Help>"
    setSGR [Reset]

    putStr " Enemy pieces captured: ["
    putStrLn $ showCapturedPcs $ getCapturedPcs currentPlayer capturedPcs

    printPlayerName currentPlayer matchData
    putStr "'s turn. Enter the coordinates of the piece you want to move (ex.: G2): "
    
    inputOrigin <- getLine                  -- get ORIGIN
    if isValidInputPosition inputOrigin boardData
        then
            handleOrigin (getCellLine(inputOrigin), getCellColumn(inputOrigin)) currentPlayer matchData boardData capturedPcs
        else checkCommand (uppercase (inputOrigin)) currentPlayer matchData boardData capturedPcs

handleOrigin :: Position -> Player -> MatchData -> Board -> CapturedPieces -> IO()
handleOrigin origin currentPlayer matchData boardData capturedPcs = do
    let cellPlayer = playerAtPos boardData origin
    if cellPlayer == (opponent(currentPlayer)) -- Origin pos chosen has opponent piece = INVALID CHOICE
        then do
            clearScreen
            printWarning "Invalid move. The chosen position contains opponent's piece. Try again: "
            originInput currentPlayer matchData boardData capturedPcs
        else do
            if cellPlayer == EmptyPl -- && getCapturedPcs currentPlayer capturedPcs /= []
                then do
                    clearScreen
                    dropPiece origin currentPlayer matchData boardData capturedPcs
                else do
                    clearScreen
                    targetInput origin currentPlayer matchData boardData capturedPcs
                    

dropPiece :: Position -> Player -> MatchData -> Board -> CapturedPieces -> IO()
dropPiece pos player matchData boardData capturedPcs = do
    printBoard (Data.Map.insert pos (' ', Selected) boardData) (getDifficulty matchData)

    setSGR [SetColor Foreground Vivid Green]
    putStrLn " <Commands: R - Reset match; E - Exit to menu; H - Help; B - Undo selection>"
    setSGR [Reset]
    putStr " Enemy pieces captured: ["
    putStrLn $ showCapturedPcs $ getCapturedPcs player capturedPcs

    printPlayerName player matchData
    putStr "'s turn. Empty cell selected. Enter the piece you want to dropPiece on this position: "

    (piece:rest) <- getLine
    if hasCaptured piece (getCapturedPcs player capturedPcs) && rest == ""
        then do
            let newCaptured = useCaptured piece player capturedPcs
            let newBoard = Data.Map.insert pos (piece, player) boardData
            clearScreen
            startTurn (opponent(player)) matchData newBoard newCaptured -- SUCESSFUL MOVE switches players
        else do
            clearScreen
            printWarning "Player doesn't own the piece selected. Try again: "
            originInput player matchData boardData capturedPcs
            
-- Match and turn management:
startMatch :: MatchData -> IO()
startMatch (Medium, p1name, p2name) = startTurn Player1 (Medium, p1name, p2name) newMediumBoard ([], [])
startMatch (Easy, p1name, p2name) = startTurn Player1 (Easy, p1name, p2name) newEasyBoard ([], []) -- TO DO substituir por easyboard
startMatch (Hard, p1name, p2name) = startTurn Player1 (Hard, p1name, p2name) newHardBoard ([], []) -- TO DO substituir por easyboard

startTurn :: Player -> MatchData -> Board -> CapturedPieces -> IO()
startTurn currentPlayer matchData boardData capturedPcs= do
    let gameOver = isKingCaptured capturedPcs
    if gameOver
        then
            do
                printBoard boardData (getDifficulty matchData)
                printWarning " Game Over!\n"
                -- print the winner
                putStr " The winner is "
                printPlayerName (opponent currentPlayer) matchData
                putStrLn "!\n Press enter to go back to the menu."
                _ <- getLine
                clearScreen
                mainMenu
        else
            originInput currentPlayer matchData boardData capturedPcs

-- Pieces' mechanics:
isPieceMove :: Coordinates -> Coordinates -> Board -> Player -> Char -> Bool
-- EASY and MEDIUM
isPieceMove origin target _ player 'p'  = isPawnMove origin target player
isPieceMove origin target _ _ 'K'       = isKingMove origin target
isPieceMove origin target _ player 'G'  = isGoldenMove origin target player
isPieceMove origin target _ player 's'  = isSilverMove origin target player
isPieceMove origin target _ player 'n'  = isKnightMove origin target player
isPieceMove origin target board player 'l'  = isLancerMove origin target board player
isPieceMove origin target board _ 'r'       = isRookMove origin target board
isPieceMove origin target board _ 'b'       = isBishopMove origin target board
-- promoted easy + medium
isPieceMove origin target _ player 'P'  = isGoldenMove origin target player
isPieceMove origin target _ player 'S'  = isGoldenMove origin target player
isPieceMove origin target _ player 'N'  = isGoldenMove origin target player
isPieceMove origin target _ player 'L'  = isGoldenMove origin target player
isPieceMove origin target board _ 'R'       = (isRookMove origin target board || isKingMove origin target)
isPieceMove origin target board _ 'B'       = (isBishopMove origin target board || isKingMove origin target)
-- HARD
isPieceMove origin target _ player 'c'  = isCopperMove origin target player
isPieceMove origin target _ player 'i'  = isIronMove origin target player
isPieceMove origin target board _ 'd'   = isDragonMove origin target board
isPieceMove origin target board _ 'f'   = isChariotMove origin target board
isPieceMove origin target _ _ 'w'       = isGoBetweenMove origin target
isPieceMove origin target board _ 'm'   = isSideMove origin target board
isPieceMove origin target _ _ 't'       = isTigerMove origin target
-- promoted hard
isPieceMove origin target _ player 'C'  = isGoldenMove origin target player
isPieceMove origin target _ player 'I'  = isGoldenMove origin target player
isPieceMove origin target board _ 'D'   = (isDragonMove origin target board || isKingMove origin target) 
isPieceMove origin target _ player 'F'  = isGoldenMove origin target player
isPieceMove origin target _ player 'W'  = isGoldenMove origin target player
isPieceMove origin target _ player 'M'  = isGoldenMove origin target player
isPieceMove origin target _ player 'T'  = isGoldenMove origin target player
--
isPieceMove _ _ _ _ _ = False


capture :: Char -> Player -> CapturedPieces -> CapturedPieces
capture ' ' _ captured = captured
capture 'G' Player1 (cap1, cap2) = (('G':cap1), cap2)
capture 'G' Player2 (cap1, cap2) = (cap1, ('G': cap2))
capture piece Player1 (cap1, cap2) = (((Data.Char.toLower(piece)):cap1), cap2)
capture piece Player2 (cap1, cap2) = (cap1, ((Data.Char.toLower(piece)):cap2))
capture _ _ captured = captured

removePiece :: Char -> [Char] -> [Char]
removePiece _ []                 = []
removePiece x (y:ys) | x == y    = removePiece x ys
                    | otherwise = y : removePiece x ys
                    
useCaptured :: Char -> Player -> CapturedPieces -> CapturedPieces
useCaptured piece Player1 (cap1, cap2) = ((removePiece piece cap1), cap2)
useCaptured piece Player2 (cap1, cap2) = (cap1, (removePiece piece cap2))
useCaptured _ _ cap = cap

getCapturedPcs :: Player -> CapturedPieces -> [Char]
getCapturedPcs Player1 (cap1, _) = cap1
getCapturedPcs Player2 (_, cap2) = cap2
getCapturedPcs _ _ = []

hasCaptured :: Char -> [Char]  -> Bool
hasCaptured _ [] = False
hasCaptured p (x:xs) | x == p = True
                     | otherwise = hasCaptured p xs

showCapturedPcs :: [Char] -> [Char]
showCapturedPcs [] = "]"
showCapturedPcs (x:xs) = ([x] ++ ", " ++ showCapturedPcs xs)

isKingCaptured :: CapturedPieces -> Bool
isKingCaptured ([], []) = False
isKingCaptured ((x:xs), []) | x == 'k' = True
                            | otherwise = isKingCaptured (xs, [])
isKingCaptured ([], (y:ys)) | y == 'k' = True
                            | otherwise = isKingCaptured ([], ys)
isKingCaptured ((x:xs), (y:ys)) | x == 'k' || y == 'k'= True
                                | xs == [] = isKingCaptured ([], ys)
                                | ys == [] = isKingCaptured (xs, [])
                                | otherwise = isKingCaptured (xs, ys)

-- Pieces' mechanics (for each type):
isPawnMove :: Coordinates -> Coordinates -> Player -> Bool
isPawnMove origin target Player1 = column(origin) == column(target) && line(origin) == (line(target) + 1)
isPawnMove origin target Player2 = column(origin) == column(target) && line(origin) == (line(target) - 1)
isPawnMove _ _ _ = False 

isKingMove:: Coordinates -> Coordinates -> Bool
isKingMove origin target = (abs(column(origin) - column(target)) <= 1) && (abs (line(origin) - line(target)) <= 1)

isGoldenMove :: Coordinates -> Coordinates -> Player -> Bool
isGoldenMove origin target Player1 = ( isKingMove origin target ) && not(line(target) == (line(origin) + 1)  && (column(target) /= column(origin) ) )
isGoldenMove origin target Player2 = ( isKingMove origin target ) && not(line(target) == (line(origin) - 1)  && (column(target) /= column(origin) ) )
isGoldenMove _ _ _ = False 

isSilverMove :: Coordinates -> Coordinates -> Player -> Bool
isSilverMove origin target Player1 = ( isKingMove origin target ) && not(line(target) == (line(origin)) || (line(target) == line(origin)+1 ) && column(target) == column(origin) )
isSilverMove origin target Player2 = ( isKingMove origin target ) && not(line(target) == (line(origin)) || (line(target) == line(origin)-1 ) && column(target) == column(origin) )
isSilverMove _ _ _ = False 

isKnightMove :: Coordinates -> Coordinates -> Player -> Bool
isKnightMove origin target Player1 = ( (line(origin)-2) == line(target) ) && (column(origin) == (column(target)-1) || column(origin) == (column(target)+1))
isKnightMove origin target Player2 = ( (line(origin)+2) == line(target) ) && (column(origin) == (column(target)-1) || column(origin) == (column(target)+1))
isKnightMove _ _ _ = False

isLancerMove :: Coordinates -> Coordinates -> Board -> Player -> Bool
isLancerMove origin target board Player1 = freeWay (line (origin)-1) target board UpD && column(origin) == column(target) && (line (origin) > line (target))
isLancerMove origin target board Player2 = freeWay (line (origin)+1) target board DownD && column(origin) == column(target) && (line (origin) < line (target))
isLancerMove _ _ _ _ = False

isRookMove :: Coordinates -> Coordinates -> Board -> Bool
isRookMove origin target board      | (line(origin) < line(target)) && column(origin) == column(target) = freeWay (line (origin)+1) target board DownD
                                    | (line(origin) > line(target)) && column(origin) == column(target) = freeWay (line (origin)-1) target board UpD
                                    | line(origin) == line(target) && (column(origin) < column(target)) = freeWay (column (origin)+1) target board RightD
                                    | line(origin) == line(target) && (column(origin) > column(target)) = freeWay (column (origin)-1) target board LeftD
                                    | otherwise = False

isBishopMove :: Coordinates -> Coordinates -> Board -> Bool
isBishopMove origin target board    | (line(origin) > line(target)) && (column(origin) < column(target)) = freeWayDiagonal (line (origin)-1) (column (origin)+1) target board FirstQuad
                                    | (line(origin) > line(target)) && (column(origin) > column(target)) = freeWayDiagonal (line (origin)-1) (column (origin)-1) target board SecondQuad
                                    | (line(origin) < line(target)) && (column(origin) > column(target)) = freeWayDiagonal (line (origin)+1) (column (origin)-1) target board ThirdQuad
                                    | (line(origin) < line(target)) && (column(origin) < column(target)) = freeWayDiagonal (line (origin)+1) (column (origin)+1) target board FourthQuad
                                    | otherwise = False
          
freeWay :: Int -> Coordinates -> Board -> Direction -> Bool
freeWay index target board UpD      | index == line(target) = True
                                    | playerAtPos board (coordinateToPosition((index, column(target)))) /= EmptyPl = False
                                    | otherwise = freeWay (index-1) target board UpD
freeWay index target board DownD    | index == line(target) = True
                                    | playerAtPos board (coordinateToPosition((index, column(target)))) /= EmptyPl = False
                                    | otherwise = freeWay (index+1) target board DownD
freeWay index target board RightD   | index == column(target) = True
                                    | playerAtPos board (coordinateToPosition((line(target), index))) /= EmptyPl = False
                                    | otherwise = freeWay (index+1) target board RightD
freeWay index target board LeftD    | index == column(target) = True
                                    | playerAtPos board (coordinateToPosition((line(target), index))) /= EmptyPl = False
                                    | otherwise = freeWay (index-1) target board LeftD

freeWayDiagonal :: Int -> Int -> Coordinates -> Board -> Quadrant -> Bool
freeWayDiagonal l c target board FirstQuad | l == line(target) && c == column(target) = True
                                    | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                    | otherwise = freeWayDiagonal (l-1) (c+1) target board FirstQuad
freeWayDiagonal l c target board SecondQuad | l == line(target) && c == column(target) = True
                                     | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                     | otherwise = freeWayDiagonal (l-1) (c-1) target board SecondQuad
freeWayDiagonal l c target board ThirdQuad | l == line(target) && c == column(target) = True
                                    | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                    | otherwise = freeWayDiagonal (l+1) (c-1) target board ThirdQuad
freeWayDiagonal l c target board FourthQuad | l == line(target) && c == column(target) = True
                                     | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                     | otherwise = freeWayDiagonal (l+1) (c+1) target board FourthQuad

-- HARD MODE pieces's mechanics:
isCopperMove :: Coordinates -> Coordinates -> Player -> Bool
isCopperMove origin target Player1 = ( isKingMove origin target ) && not( column(target) /= (column(origin)) && (line(target) == line(origin)-1) )
isCopperMove origin target Player2 = ( isKingMove origin target ) && not( column(target) /= (column(origin)) && (line(target) == line(origin)+1) )
isCopperMove _ _ _ = False

isTigerMove :: Coordinates -> Coordinates -> Bool
isTigerMove origin target = ( isKingMove origin target ) && ( column(target) /= (column(origin)) && (line(target) /= line(origin)) )

isDragonMove :: Coordinates -> Coordinates -> Board -> Bool
isDragonMove origin target board = isBishopMove origin target board
 
isChariotMove :: Coordinates -> Coordinates -> Board -> Bool
isChariotMove origin target board = (isRookMove origin target board) && (column(target) == column(origin))

isGoBetweenMove :: Coordinates -> Coordinates -> Bool
isGoBetweenMove origin target = ( isKingMove origin target ) && ( column(target) == column(origin) )

isIronMove :: Coordinates -> Coordinates -> Player -> Bool
isIronMove origin target Player1 = ( isKingMove origin target ) && ( line(target) == (line(origin)-1) )
isIronMove origin target Player2 = ( isKingMove origin target ) && ( line(target) == (line(origin)+1) )
isIronMove _ _ _ = False

isSideMove :: Coordinates -> Coordinates -> Board -> Bool
isSideMove origin target board = (isRookMove origin target board) && (line(target) == line(origin))

-- Navigation menus:
gameMenu :: IO()
gameMenu = do
    printHeader

    putStrLn "  1 - Easy"
    putStrLn "  2 - Medium "
    putStrLn "  3 - Hard"
    putStrLn "\n  B - Return to main menu\n"

    putStr " Select the difficulty: "
    input <- getLine
    if input /= "1" && input /= "2" && input /= "3" && (uppercase input) /= "B"
        then do
            clearScreen
            printWarning "Invalid entry. Try again: "
            gameMenu
        else do
            clearScreen

            if (uppercase input) == "B"
                then mainMenu
                else do
            printHeader

            putStr "Difficulty chosen: "
            setSGR [SetColor Foreground Vivid Magenta] 
            putStrLn $ show $ difficultyCode(input)
            setSGR [Reset]

            putStr "\nPlayer 1 name: "
            setSGR [SetColor Foreground Vivid Cyan] 
            player1 <- getLine
            setSGR [Reset]

            putStr "Player 2 name: "
            setSGR [SetColor Foreground Vivid Yellow] 
            player2 <- getLine
            setSGR [Reset]

            clearScreen
            startMatch (difficultyCode(input), player1, player2)

mainMenuOptions :: String -> IO()
mainMenuOptions "1" = do
    clearScreen
    gameMenu
mainMenuOptions "2" = do
    clearScreen
    help
    mainMenu
mainMenuOptions "3" = printWarning "Closing game." 
mainMenuOptions x = do
    clearScreen
    putStr x
    printWarning " is not a valid command. try again"
    mainMenu

mainMenu :: IO()
mainMenu = do
    printHeader

    putStrLn "1 - Start Game"
    putStrLn "2 - Instructions"
    putStrLn "3 - Close Game"
    putStrLn "\n"
    putStr "Select your Option: "
    option <- getLine 
    mainMenuOptions(option)

main :: IO()
main = do 
    clearScreen
    mainMenu