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

type Position = (Char, Char)
type Cell = (Char, Player)
type Board = Data.Map.Map Position Cell
type MatchData = (String, String, String)
type Coordinates = (Int, Int)
type CapturedPieces = ([Char], [Char])



oponent :: Player -> Player
oponent player | player == Player1 = Player2
               | otherwise = Player1

-- Mapeamento de posicoes BEGIN
invalidCell :: Cell
invalidCell = ('*', EmptyPl)

getPiece :: Cell -> Char
getPiece (piece, _) = piece

getPlayer :: Cell -> Player
getPlayer (_, player) = player

playerAtPos :: Board ->  Position -> Player
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
-- Mapeamento de posicoes END


-- Estruturas de amrazenamento BEGIN
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
printLines _ [] = do
    setSGR [SetColor Foreground Vivid Magenta]
    putStrLn  "      0     1     2     3     4     5     6     7     8   "
    setSGR [Reset]
printLines board (x:xs) = do
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    setSGR [SetColor Foreground Vivid Magenta]
    putStr (" " ++ [x])
    setSGR [Reset]
    putStr " #"
    displayLine (linePieces board x) (linePlayers board x)
    putStrLn "   #     #     #     #     #     #     #     #     #     #"
    putStrLn "   #######################################################"
    printLines board xs
    

linePieces :: Board -> Char -> [Char]
linePieces board l = [pieceAtPos (board) ((l, b)) | b <- ['0'..'8']] 

linePlayers :: Board -> Char -> [Player]
linePlayers board l = [playerAtPos (board) ((l, b)) | b <- ['0'..'8']] 


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

difficultyCode :: String -> String
-- difficultyCode "1" = "Easy"
difficultyCode "2" = "Medium"
difficultyCode _ = "*"

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
getCellColumn [] = '*'
getCellColumn (_:y:ys) | (length(y:ys)) == 0 = '*'
                       | (length ys) /= 0 = '*'
                       | otherwise = y

isValidInputPosition :: String -> Bool
isValidInputPosition input
    | length(input) /= 2 = False
    | Data.Map.member (l, c) newMediumBoard = True
    | otherwise = False
    where l = getCellLine input
          c = getCellColumn input

-- Tratamento da entrada END


-- Gets BEGIN
getPlayer1Name :: MatchData -> String
getPlayer1Name (_, p1, _) = p1

getPlayer2Name :: MatchData -> String
getPlayer2Name (_, _, p2) = p2

getDifficulty :: MatchData -> String
getDifficulty (dif, _, _) = dif
-- Gets END


-- Mecanicas de jogo BEGINisValidInputPosition
move :: Board -> Position -> Position -> Board
move board origin target = Data.Map.insert origin (' ', EmptyPl) (Data.Map.insert target (pieceAtPos board origin, playerAtPos board origin) board)

promotedCell :: Cell -> Cell
promotedCell (piece, player) = ((Data.Char.toUpper (piece)), player)

checkPromotion :: Board -> Position -> Player -> Board
checkPromotion board target Player1 | line(posIndexes(target)) < 3 = Data.Map.insert target (promotedCell $ cellAtPos board target) board
                                    | otherwise = board
checkPromotion board target Player2 | line(posIndexes(target)) > 5 = Data.Map.insert target (promotedCell $ cellAtPos board target) board
                                    | otherwise = board  
checkPromotion board _ _ = board                


isValidMove :: Position -> Position -> Player -> Board -> Bool
isValidMove origin target player board = (isPieceMove (posIndexes(origin)) (posIndexes(target)) board player (pieceAtPos board origin)) && (player == (playerAtPos board origin)) && (player /= (playerAtPos board target))

checkCommand :: String -> Player -> MatchData -> Board -> CapturedPieces -> IO()
checkCommand "R" _ _ _ _ = main
checkCommand "E" _ _ _ _ = printWarning "Leaving game."
checkCommand "H" _ _ _ _ = putStrLn "TO DO Help aqui"
checkCommand _ player match board captured = do
    clearScreen
    printWarning "Invalid origin entry. Try again: "            -- INVALID ORIGIN
    startTurn player match board captured 

checkCommand2 :: String -> Player -> MatchData -> Board -> CapturedPieces -> IO()
checkCommand2 "R" _ _ _ _ = main
checkCommand2 "E" _ _ _ _ = printWarning "Leaving game."
checkCommand2 "H" _ _ _ _ = putStrLn "TO DO Help aqui"
checkCommand2 "B" player match board captured = do
    clearScreen
    printWarning "Coordinates selection undone."
    playerInput player match board captured

checkCommand2 _ player match board captured = do
    clearScreen
    printWarning "Invalid move entry. Try again: "    -- INVALID TARGET
    startTurn player match board captured

uppercase :: [Char] -> [Char]
uppercase [] = []
uppercase (h:t) = toUpper h : uppercase t

playerInput :: Player -> MatchData -> Board -> CapturedPieces -> IO()
playerInput currentPlayer matchData boardData capturedPcs = do
   
    printBoard boardData
    setSGR [SetColor Foreground Vivid Green]
    putStrLn " <Commands: R - Reset; E - Exit; H - Help>"
    setSGR [Reset]
    putStr " Enemy pieces captured: ["
    putStrLn $ printCapturedPcs $ getCapturedPcs currentPlayer capturedPcs

    printPlayerName currentPlayer matchData
    putStr "'s turn. Enter the coordinates of the piece you want to move (ex.: G2): "
    
    inputOrigin <- getLine                  -- get ORIGIN
    if isValidInputPosition inputOrigin
        then do
            let originPos = (getCellLine(inputOrigin), getCellColumn(inputOrigin))
            let selectedBoard = Data.Map.insert originPos ((pieceAtPos boardData originPos), Selected) boardData

            clearScreen
            printBoard selectedBoard
            setSGR [SetColor Foreground Vivid Green]
            putStrLn " <Commands: R - Reset; E - Exit; H - Help; B - Back>"
            setSGR [Reset]
            
            printPlayerName currentPlayer matchData
            putStr "'s turn. Enter the coordinates of where you want to move to with your piece: "

            inputTarget <- getLine          -- get TARGET
            let targetPos = (getCellLine(inputTarget), getCellColumn(inputTarget))

            if isValidInputPosition inputTarget && isValidMove originPos targetPos currentPlayer boardData
                then do
                    clearScreen 
                    let newMove = move boardData originPos targetPos
                    let checkedBoard = checkPromotion newMove targetPos currentPlayer
                    let newCaptured = capture (pieceAtPos boardData targetPos) currentPlayer capturedPcs
                    startTurn (oponent(currentPlayer)) matchData checkedBoard newCaptured -- SUCESSFUL MOVE switches players

                else checkCommand2 (uppercase (inputOrigin)) currentPlayer matchData boardData capturedPcs
                   
        else checkCommand (uppercase (inputOrigin)) currentPlayer matchData boardData capturedPcs

            

startMatch :: MatchData -> IO()
startMatch matchData = startTurn Player1 matchData newMediumBoard ([], [])

startTurn :: Player -> MatchData -> Board -> CapturedPieces -> IO()
startTurn currentPlayer matchData boardData capturedPcs= do
    let gameOver = isKingCaptured capturedPcs
    if gameOver
        then
            do
                printBoard boardData
                printWarning " Game Over!\n"
                -- print the winner
                putStr " The winner is "
                printPlayerName (oponent currentPlayer) matchData
                putStrLn "!\n Press enter to go back to the menu."
                _ <- getLine
                clearScreen
                main
        else
            playerInput currentPlayer matchData boardData capturedPcs

isPieceMove :: Coordinates -> Coordinates -> Board -> Player -> Char -> Bool
isPieceMove origin target _ player 'p'  = isPawnMove origin target player
isPieceMove origin target _ _ 'K'       = isKingMove origin target
isPieceMove origin target _ player 'G'  = isGoldenMove origin target player
isPieceMove origin target _ player 's'  = isSilverMove origin target player
isPieceMove origin target _ player 'n'  = isKnightMove origin target player
isPieceMove origin target b player 'l'  = isLancerMove origin target b player
isPieceMove origin target b _ 'r'       = isRookMove origin target b
isPieceMove origin target b _ 'b'       = isBishopMove origin target b
isPieceMove origin target _ player 'P'  = isGoldenMove origin target player
isPieceMove origin target _ player 'S'  = isGoldenMove origin target player
isPieceMove origin target _ player 'N'  = isGoldenMove origin target player
isPieceMove origin target _ player 'L'  = isGoldenMove origin target player
isPieceMove origin target b _ 'R'       = (isRookMove origin target b || isKingMove origin target)
isPieceMove origin target b _ 'B'       = (isBishopMove origin target b || isKingMove origin target)
isPieceMove _ _ _ _ _ = False

capture :: Char -> Player -> CapturedPieces -> CapturedPieces
capture ' ' _ captured = captured
capture piece Player1 (cap1, cap2) = ((piece:cap1), cap2)
capture piece Player2 (cap1, cap2) = (cap1, (piece:cap2))
capture _ _ cap = cap

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

printCapturedPcs :: [Char] -> [Char]
printCapturedPcs [] = "]"
printCapturedPcs (x:xs) = ([x] ++ ", " ++ printCapturedPcs xs)

isKingCaptured :: CapturedPieces -> Bool
isKingCaptured ([], []) = False
isKingCaptured ((x:xs), []) | x == 'K' = True
                            | otherwise = isKingCaptured (xs, [])
isKingCaptured ([], (y:ys)) | y == 'K' = True
                            | otherwise = isKingCaptured (ys, [])
isKingCaptured ((x:xs), (y:ys)) | x == 'K' || y == 'K'= True
                                | xs == [] = isKingCaptured ([], ys)
                                | ys == [] = isKingCaptured (xs, [])
                                | otherwise = isKingCaptured (xs, ys)
-- Mecanicas de jogo END


-- Mecanicas de cada peca BEGIN
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
isRookMove origin target board    | (line(origin) < line(target)) && column(origin) == column(target) = freeWay (line (origin)+1) target board DownD
                                    | (line(origin) > line(target)) && column(origin) == column(target) = freeWay (line (origin)-1) target board UpD
                                    | line(origin) == line(target) && (column(origin) < column(target)) = freeWay (column (origin)+1) target board RightD
                                    | line(origin) == line(target) && (column(origin) > column(target)) = freeWay (column (origin)-1) target board LeftD
                                    | otherwise = False

isBishopMove :: Coordinates -> Coordinates -> Board -> Bool
isBishopMove origin target board    | (line(origin) > line(target)) && (column(origin) < column(target)) = freeWay2 (line (origin)-1) (column (origin)+1) target board FirstQuad
                                    | (line(origin) > line(target)) && (column(origin) > column(target)) = freeWay2 (line (origin)-1) (column (origin)-1) target board SecondQuad
                                    | (line(origin) < line(target)) && (column(origin) > column(target)) = freeWay2 (line (origin)+1) (column (origin)-1) target board ThirdQuad
                                    | (line(origin) < line(target)) && (column(origin) < column(target)) = freeWay2 (line (origin)+1) (column (origin)+1) target board FourthQuad
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

freeWay2 :: Int -> Int -> Coordinates -> Board -> Quadrant -> Bool
freeWay2 l c target board FirstQuad | l == line(target) && c == column(target) = True
                                    | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                    | otherwise = freeWay2 (l-1) (c+1) target board FirstQuad
freeWay2 l c target board SecondQuad | l == line(target) && c == column(target) = True
                                     | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                     | otherwise = freeWay2 (l-1) (c-1) target board SecondQuad
freeWay2 l c target board ThirdQuad | l == line(target) && c == column(target) = True
                                    | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                    | otherwise = freeWay2 (l+1) (c-1) target board ThirdQuad
freeWay2 l c target board FourthQuad | l == line(target) && c == column(target) = True
                                     | playerAtPos board (coordinateToPosition((l, c))) /= EmptyPl = False
                                     | otherwise = freeWay2 (l+1) (c+1) target board FourthQuad

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