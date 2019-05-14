module Main
  (
    main
  ) where
    
import qualified Data.Map
import Data.Char
import System.Console.ANSI

-- types and data
data Player = Player1 | Player2 | Empty deriving (Eq, Show)
type Position = (Char, Char)
type Cell = (Char, Char)
type Board = Data.Map.Map Position Cell
type MatchData = (String, String, String)
type Coordinates = (Int, Int)

oponent :: Char -> Char
oponent player | player == '1' = '2'
               | otherwise = '1'

-- Mapeamento de posicoes BEGIN
invalidCell :: Cell
invalidCell = ('*', '*')

getPiece :: Cell -> Char
getPiece (piece, player) = piece

getPlayer :: Cell -> Char
getPlayer (piece, player) = player

playerAtPos :: Board ->  Position -> Char
playerAtPos board position = getPlayer $ Data.Map.findWithDefault invalidCell position board 

pieceAtPos :: Board -> Position -> Char
pieceAtPos board position = getPiece $ Data.Map.findWithDefault invalidCell position board

posIndexes :: Position -> Coordinates
posIndexes (l, c) = (fromEnum(l) - fromEnum('A'), fromEnum(c) - fromEnum('0'))

line :: Coordinates -> Int
line (l, c) = l

column :: Coordinates -> Int
column (l, c) = c
-- Mapeamento de posicoes END


-- Estruturas de amrazenamento BEGIN
newMediumBoard :: Board
newMediumBoard = Data.Map.fromList[(('A', '0'), ('l', '2')), (('A', '1'), ('n', '2')), (('A', '2'), ('s', '2')),  (('A', '3'), ('G', '2')), (('A', '4'), ('K', '2')), (('A', '5'), ('G', '2')), (('A', '6'), ('s', '2')), (('A', '7'), ('n', '2')), (('A', '8'), ('l', '2')),
                                   (('B', '0'), (' ', '0')), (('B', '1'), ('r', '2')), (('B', '2'), (' ', '0')),  (('B', '3'), (' ', '0')), (('B', '4'), (' ', '0')), (('B', '5'), (' ', '0')), (('B', '6'), (' ', '0')), (('B', '7'), ('b', '2')), (('B', '8'), (' ', '0')),
                                   (('C', '0'), ('p', '2')), (('C', '1'), ('p', '2')), (('C', '2'), ('p', '2')),  (('C', '3'), ('p', '2')), (('C', '4'), ('p', '2')), (('C', '5'), ('p', '2')), (('C', '6'), ('p', '2')), (('C', '7'), ('p', '2')), (('C', '8'), ('p', '2')),
                                   (('D', '0'), (' ', '0')), (('D', '1'), (' ', '0')), (('D', '2'), (' ', '0')),  (('D', '3'), (' ', '0')), (('D', '4'), (' ', '0')), (('D', '5'), (' ', '0')), (('D', '6'), (' ', '0')), (('D', '7'), (' ', '0')), (('D', '8'), (' ', '0')),
                                   (('E', '0'), (' ', '0')), (('E', '1'), (' ', '0')), (('E', '2'), (' ', '0')),  (('E', '3'), (' ', '0')), (('E', '4'), (' ', '0')), (('E', '5'), (' ', '0')), (('E', '6'), (' ', '0')), (('E', '7'), (' ', '0')), (('E', '8'), (' ', '0')),
                                   (('F', '0'), (' ', '0')), (('F', '1'), (' ', '0')), (('F', '2'), (' ', '0')),  (('F', '3'), (' ', '0')), (('F', '4'), (' ', '0')), (('F', '5'), (' ', '0')), (('F', '6'), (' ', '0')), (('F', '7'), (' ', '0')), (('F', '8'), (' ', '0')),
                                   (('G', '0'), ('p', '1')), (('G', '1'), ('p', '1')), (('G', '2'), ('p', '1')),  (('G', '3'), ('p', '1')), (('G', '4'), ('p', '1')), (('G', '5'), ('p', '1')), (('G', '6'), ('p', '1')), (('G', '7'), ('p', '1')), (('G', '8'), ('p', '1')),
                                   (('H', '0'), (' ', '0')), (('H', '1'), ('b', '1')), (('H', '2'), (' ', '0')),  (('H', '3'), (' ', '0')), (('H', '4'), (' ', '0')), (('H', '5'), (' ', '0')), (('H', '6'), (' ', '0')), (('H', '7'), ('r', '1')), (('H', '8'), (' ', '0')),
                                   (('I', '0'), ('l', '1')), (('I', '1'), ('n', '1')), (('I', '2'), ('s', '1')),  (('I', '3'), ('G', '1')), (('I', '4'), ('K', '1')), (('I', '5'), ('G', '1')), (('I', '6'), ('s', '1')), (('I', '7'), ('n', '1')), (('I', '8'), ('l', '1'))]

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

-- Estruturas de amrazenamento END


-- Impressao do tabuleiro BEGIN
printBoard :: Board -> IO()
printBoard board = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn "      0     1     2     3     4     5     6     7     8   "
    setSGR [Reset]
    putStrLn "   #######################################################"
    printLines board ['A'..'I']


printLines :: Board -> [Char] -> IO()
printLines board [] = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn  "      0     1     2     3     4     5     6     7     8   "
    setSGR [Reset]
printLines board (x:xs) = do
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    setSGR [SetColor Foreground Vivid Magenta]
    putStr (" " ++ [x])
    setSGR [Reset]
    putStr " #  "
    displayLine (lineItems board x) (linePlayers board x)
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    putStrLn "   #######################################################"
    printLines board xs
    

lineItems :: Board -> Char -> [Char]
lineItems board line = [pieceAtPos (board) ((line, b)) | b <- ['0'..'8']] 

linePlayers :: Board -> Char -> [Char]
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

printPlayerName :: Char -> MatchData -> IO()
printPlayerName '1' matchData = do
    setSGR [SetColor Foreground Vivid Cyan]    
    putStr (getPlayer1Name  matchData)
    setSGR [Reset]
printPlayerName '2' matchData = do
    setSGR [SetColor Foreground Vivid Yellow]
    putStr (getPlayer2Name matchData)
    setSGR [Reset]

printWarning :: String -> IO()
printWarning message = do
    setSGR [SetColor Foreground Vivid Red]
    putStrLn message
    setSGR [Reset]

difficultyCode :: String -> String
-- difficultyCode "1" = "Easy"
difficultyCode "2" = "Medium"
difficultyCode x = "*"

printHeader :: IO()
printHeader = do
    setSGR [SetColor Foreground Vivid Magenta] 
    putStrLn (header)
    setSGR [Reset]
-- Impressao do tabuleiro END


-- Tratamento da entrada BEGIN
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
-- Tratamento da entrada END


-- Gets BEGIN
getPlayer1Name :: MatchData -> String
getPlayer1Name (dif, p1, p2) = p1

getPlayer2Name :: MatchData -> String
getPlayer2Name (dif, p1, p2) = p2

getDifficulty :: MatchData -> String
getDifficulty (dif, p1, p2) = dif
-- Gets END


-- Mecanicas de jogo BEGIN
move :: Board -> Position -> Position -> Board
move board origin target = Data.Map.insert origin (' ', '0') (Data.Map.insert target (pieceAtPos board origin, playerAtPos board origin) board)

isValidMove :: Position -> Position -> Char -> Board -> Bool
isValidMove origin target player board = (isPieceMove (posIndexes(origin)) (posIndexes(target)) player (pieceAtPos board origin)) && (player == (playerAtPos board origin)) && (player /= (playerAtPos board target))

playerInput :: Char -> MatchData -> Board -> IO()
playerInput currentPlayer matchData boardData = do
    
    printBoard boardData

    printPlayerName currentPlayer matchData
    putStr "'s turn. Enter the coordinates of the piece you want to move (ex.: G2): "
    
    inputOrigin <- getLine                  -- get ORIGIN
    if isValidInputPosition inputOrigin
        then do
            clearScreen
            printBoard boardData

            printPlayerName currentPlayer matchData
            putStr "'s turn. Enter the coordinates of where you want to move to with your piece: "

            inputTarget <- getLine          -- get TARGET

            let originPos = (getCellLine(inputOrigin), getCellColumn(inputOrigin))
            let targetPos = (getCellLine(inputTarget), getCellColumn(inputTarget))

            if isValidInputPosition inputTarget && isValidMove originPos targetPos currentPlayer boardData
                then do
                    clearScreen 
                    startTurn (oponent(currentPlayer)) matchData (move boardData originPos targetPos) -- SUCESSFUL MOVE switches players
                else do
                    clearScreen
                    printWarning "Invalid move entry. Try again: "    -- INVALID TARGET
                    startTurn currentPlayer matchData boardData
        else do
            clearScreen
            printWarning "Invalid origin entry. Try again: "            -- INVALID ORIGIN
            startTurn currentPlayer matchData boardData

startMatch :: MatchData -> IO()
startMatch matchData = startTurn '1' matchData newMediumBoard

startTurn :: Char -> MatchData -> Board -> IO()
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
            playerInput currentPlayer matchData boardData

            


isPieceMove :: Coordinates -> Coordinates -> Char -> Char -> Bool
isPieceMove origin target player 'p' = isPawnMove origin target player
isPieceMove origin target player piece = False
-- Mecanicas de jogo END


-- Mecanicas de cada peca BEGIN
isPawnMove :: Coordinates -> Coordinates -> Char -> Bool
isPawnMove origin target '1' = column(origin) == column(target) && line(origin) == (line(target) + 1)
isPawnMove origin target '2' = column(origin) == column(target) && line(origin) == (line(target) - 1)
isPawnMove origin target x = False 
-- Mecanicas de cada peca END


-- Menus de navegacao BEGIN
gameMenu :: IO()
gameMenu = do
    printHeader

    --putStrLn "1 - Easy"
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
--  Menus de navegacao END

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