module Main
  (
    main
  ) where
    
import qualified Data.Map
import Data.Char
import System.Console.ANSI


oponent :: Char -> Char
oponent player | player == '1' = '2'
               | otherwise = '1'

invalidCell :: (Char, Char)
invalidCell = ('*', '*')

getPiece :: (Char, Char) -> Char
getPiece (piece, player) = piece

getPlayer :: (Char, Char) -> Char
getPlayer (piece, player) = player

playerAtPos :: Data.Map.Map (Char, Char) (Char, Char) ->  (Char, Char) -> Char
playerAtPos board position = getPlayer $ Data.Map.findWithDefault invalidCell position board 

pieceAtPos :: Data.Map.Map (Char, Char) (Char, Char) ->  (Char, Char) -> Char
pieceAtPos board position = getPiece $ Data.Map.findWithDefault invalidCell position board 

newMediumBoard :: Data.Map.Map (Char, Char) (Char, Char)
newMediumBoard = Data.Map.fromList[(('A', '0'), ('l', '2')), (('A', '1'), ('n', '2')), (('A', '2'), ('s', '2')),  (('A', '3'), ('G', '2')), (('A', '4'), ('K', '2')), (('A', '5'), ('G', '2')), (('A', '6'), ('s', '2')), (('A', '7'), ('n', '2')), (('A', '8'), ('l', '2')),
                                   (('B', '0'), (' ', '0')), (('B', '1'), ('r', '2')), (('B', '2'), (' ', '0')),  (('B', '3'), (' ', '0')), (('B', '4'), (' ', '0')), (('B', '5'), (' ', '0')), (('B', '6'), (' ', '0')), (('B', '7'), ('b', '2')), (('B', '8'), (' ', '0')),
                                   (('C', '0'), ('p', '2')), (('C', '1'), ('p', '2')), (('C', '2'), ('p', '2')),  (('C', '3'), ('p', '2')), (('C', '4'), ('p', '2')), (('C', '5'), ('p', '2')), (('C', '6'), ('p', '2')), (('C', '7'), ('p', '2')), (('C', '8'), ('p', '2')),
                                   (('D', '0'), (' ', '0')), (('D', '1'), (' ', '0')), (('D', '2'), (' ', '0')),  (('D', '3'), (' ', '0')), (('D', '4'), (' ', '0')), (('D', '5'), (' ', '0')), (('D', '6'), (' ', '0')), (('D', '7'), (' ', '0')), (('D', '8'), (' ', '0')),
                                   (('E', '0'), (' ', '0')), (('E', '1'), (' ', '0')), (('E', '2'), (' ', '0')),  (('E', '3'), (' ', '0')), (('E', '4'), (' ', '0')), (('E', '5'), (' ', '0')), (('E', '6'), (' ', '0')), (('E', '7'), (' ', '0')), (('E', '8'), (' ', '0')),
                                   (('F', '0'), (' ', '0')), (('F', '1'), (' ', '0')), (('F', '2'), (' ', '0')),  (('F', '3'), (' ', '0')), (('F', '4'), (' ', '0')), (('F', '5'), (' ', '0')), (('F', '6'), (' ', '0')), (('F', '7'), (' ', '0')), (('F', '8'), (' ', '0')),
                                   (('G', '0'), ('p', '1')), (('G', '1'), ('p', '1')), (('G', '2'), ('p', '1')),  (('G', '3'), ('p', '1')), (('G', '4'), ('p', '1')), (('G', '5'), ('p', '1')), (('G', '6'), ('p', '1')), (('G', '7'), ('p', '1')), (('G', '8'), ('p', '1')),
                                  (('H', '0'), (' ', '0')), (('H', '1'), ('b', '1')), (('H', '2'), (' ', '0')),  (('H', '3'), (' ', '0')), (('H', '4'), (' ', '0')), (('H', '5'), (' ', '0')), (('H', '6'), (' ', '0')), (('H', '7'), ('r', '1')), (('H', '8'), (' ', '0')),
                                   (('I', '0'), ('l', '1')), (('I', '1'), ('n', '1')), (('I', '2'), ('s', '1')),  (('I', '3'), ('G', '1')), (('I', '4'), ('K', '1')), (('I', '5'), ('G', '1')), (('I', '6'), ('s', '1')), (('I', '7'), ('n', '1')), (('I', '8'), ('l', '1'))]


printBoard :: Data.Map.Map (Char, Char) (Char, Char) -> IO()
printBoard board = do
    putStrLn "      0     1     2     3     4     5     6     7     8   "
    putStrLn "   #######################################################"
    printLines board ['A'..'I']


printLines :: Data.Map.Map (Char, Char) (Char, Char) -> [Char] -> IO()
printLines board [] = putStrLn  "      0     1     2     3     4     5     6     7     8   "
printLines board (x:xs) = do
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    putStr (" " ++ [x] ++ " #  ")
    displayLine (lineItems board x) (linePlayers board x)
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    putStrLn "   #######################################################"
    printLines board xs
    

lineItems :: Data.Map.Map (Char, Char) (Char, Char) -> Char -> [Char]
lineItems board line = [pieceAtPos (board) ((line, b)) | b <- ['0'..'8']] 

linePlayers :: Data.Map.Map (Char, Char) (Char, Char) -> Char -> [Char]
linePlayers board line = [playerAtPos (board) ((line, b)) | b <- ['0'..'8']] 


displayLine :: [Char] -> [Char] -> IO()
displayLine [] [] = putStr "\n"
displayLine (x:xs) (y:ys)
    | y == '1' = do
        setSGR [SetColor Foreground Vivid Cyan] 
        putStr [x]
        setSGR [Reset]
        putStr "  #  "
        displayLine xs ys
    | y == '2' = do
        setSGR [SetColor Foreground Vivid Yellow] 
        putStr [x]
        setSGR [Reset]
        putStr "  #  "
        displayLine xs ys
    | otherwise = do
        putStr ([x] ++ "  #  ")
        displayLine xs ys


getCellLine :: String -> Char
getCellLine "" = '*'
getCellLine (x:xs) | xs == "" = '*'
               | length xs > 1 = '*'
               | otherwise = Data.Char.toUpper x


getCellColumn :: String -> Char
getCellColumn "" = '*'
getCellColumn (x:y:ys) | (length(y:ys)) == 0 = '*'
                       | (length ys) /= 0 = '*'
                       | otherwise = y


isValidInputPosition :: String -> Bool
isValidInputPosition input
    | length(input) /= 2 = False
    | Data.Map.member (line, column) newMediumBoard = True
    | otherwise = False
    where line = getCellLine input
          column = getCellColumn input

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

printHeader :: IO()
printHeader = do
    setSGR [SetColor Foreground Vivid Magenta] 
    putStrLn (header)
    setSGR [Reset]

getPlayer1Name :: (String, String, String) -> String
getPlayer1Name (dif, p1, p2) = p1

getPlayer2Name :: (String, String, String) -> String
getPlayer2Name (dif, p1, p2) = p2

getDifficulty :: (String, String, String) -> String
getDifficulty (dif, p1, p2) = dif

move :: Data.Map.Map (Char, Char) (Char, Char) -> (Char, Char) -> (Char, Char) -> Data.Map.Map (Char, Char) (Char, Char)
move board origin target = Data.Map.insert origin (' ', '0') (Data.Map.insert target (pieceAtPos board origin, playerAtPos board origin) board)

posIndexes :: (Char, Char) -> (Int, Int)
posIndexes (l, c) = (fromEnum(l) - fromEnum('A'), fromEnum(c) - fromEnum('0'))

isValidMove :: (Char, Char) -> (Char, Char) -> Char -> Data.Map.Map (Char, Char) (Char, Char) -> Bool
isValidMove origin target player board = (isPieceMove (posIndexes(origin)) (posIndexes(target)) player (pieceAtPos board origin)) && (player == (playerAtPos board origin)) && (player /= (playerAtPos board target))

startMatch :: (String, String, String) -> IO()
startMatch matchData = startTurn '1' matchData newMediumBoard

startTurn :: Char -> (String, String, String) -> Data.Map.Map (Char, Char) (Char, Char) -> IO()
startTurn currentPlayer matchData boardData = do
    let gameOver = False
    if gameOver
        then
            do
                putStr "Game Over\n"
                -- print the winner
                putStr "The winner is "
                if currentPlayer == '1'
                    then
                        putStr $ getPlayer1Name(matchData)
                    else
                        putStr $ getPlayer2Name(matchData)
                putStr "\n"

        else -- Game not over
            do
                -- to do: Print board
                printBoard boardData

                if currentPlayer == '1'
                    then do
                        setSGR [SetColor Foreground Vivid Cyan]    
                        putStrLn (getPlayer1Name(matchData) ++ "'s turn.")
                    else do
                        setSGR [SetColor Foreground Vivid Yellow]
                        putStrLn (getPlayer2Name(matchData) ++ "'s turn.")
                setSGR [Reset]  -- Reset to default colour scheme
                putStrLn "Enter the coordinates of the piece you want to move (ex.: G2): "
                
                inputOrigin <- getLine                  -- get ORIGIN
                if isValidInputPosition inputOrigin
                    then do
                        clearScreen
                        printBoard boardData

                        if currentPlayer == '1'
                            then do
                                setSGR [SetColor Foreground Vivid Cyan]    
                                putStrLn (getPlayer1Name(matchData) ++ "'s turn.")
                            else do
                                setSGR [SetColor Foreground Vivid Yellow]
                                putStrLn (getPlayer2Name(matchData) ++ "'s turn.")
                        setSGR [Reset]
                        putStrLn "Enter the coordinates of where you want to move to with your piece: "
                        inputTarget <- getLine          -- get TARGET
                        if isValidInputPosition inputTarget && isValidMove (getCellLine(inputOrigin), getCellColumn(inputOrigin)) (getCellLine(inputTarget), getCellColumn(inputTarget)) currentPlayer boardData
                            then do
                                clearScreen 
                                startTurn (oponent(currentPlayer)) matchData (move boardData (getCellLine(inputOrigin), getCellColumn(inputOrigin)) (getCellLine(inputTarget), getCellColumn(inputTarget))) -- SUCESSFUL MOVE switches players
                            else do
                                clearScreen
                                printWarning "Invalid move entry. Try again: "    -- INVALID TARGET
                                startTurn currentPlayer matchData boardData
                    else do
                        clearScreen
                        printWarning "Invalid origin entry. Try again: "            -- INVALID ORIGIN
                        startTurn currentPlayer matchData boardData

printWarning :: String -> IO()
printWarning message = do
    setSGR [SetColor Foreground Vivid Red]
    putStrLn message
    setSGR [Reset]


difficultyCode :: String -> String
-- difficultyCode "1" = "Easy"
difficultyCode "2" = "Medium"
difficultyCode x = "*"

gameMenu :: IO()
gameMenu = do
    printHeader

    putStrLn "1 - Easy"
    putStrLn "2 - Medium "
    --putStrLn "3 - Hard"
    putStrLn "\n"

    putStr "Select the difficulty: "
    input <- getLine

    let dif = difficultyCode(input)
    if dif == "*"
        then do
            clearScreen
            printWarning "Invalid entry. Try again: "
            gameMenu
        else do
            clearScreen
            printHeader

            putStr "Difficulty chosen: "
            setSGR [SetColor Foreground Vivid Magenta] 
            putStrLn dif
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
            startMatch (dif, player1, player2)



mainMenuOptions :: String -> IO()
mainMenuOptions "1" = do
    clearScreen
    gameMenu
mainMenuOptions "2" = do
    clearScreen
    printWarning "Nao disponivel ainda."
    main
mainMenuOptions "3" = printWarning "Closing game." 
mainMenuOptions x = do
    clearScreen
    putStr x
    printWarning " is not a valid command. try again"
    main

line :: (Int, Int) -> Int
line (l, c) = l

column :: (Int, Int) -> Int
column (l, c) = c

isPieceMove :: (Int, Int) -> (Int, Int) -> Char -> Char -> Bool
isPieceMove origin target player 'p' = isPawnMove origin target player
isPieceMove origin target player piece = False

isPawnMove :: (Int, Int) -> (Int, Int) -> Char -> Bool
isPawnMove origin target '1' = column(origin) == column(target) && line(origin) == (line(target) + 1)
isPawnMove origin target '2' = column(origin) == column(target) && line(origin) == (line(target) - 1)
isPawnMove origin target x = False 

main :: IO()
main = do
    printHeader

    putStrLn "1 - Start Game"
    putStrLn "2 - Instructions"
    putStrLn "3 - Close Game"
    putStrLn "\n"
    putStr "Select your Option: "
    option <- getLine 
    mainMenuOptions(option)