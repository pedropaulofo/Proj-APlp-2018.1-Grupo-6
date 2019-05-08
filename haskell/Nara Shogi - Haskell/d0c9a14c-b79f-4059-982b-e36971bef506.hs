import qualified Data.Map
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

newMediumPiecesMap :: Data.Map.Map (Char, Char) (Char, Char)
newMediumPiecesMap = Data.Map.fromList[(('A', '0'), ('l', '2')), (('A', '1'), ('2', 'n')), (('A', '2'), ('s', '2')),  (('A', '3'), ('G', '2')), (('A', '4'), ('K', '2')), (('A', '5'), ('G', '2')), (('A', '6'), ('s', '2')), (('A', '7'), ('n', '2')), (('A', '8'), ('l', '2')),
                                       (('B', '0'), (' ', '2')), (('B', '1'), ('r', '2')), (('B', '2'), (' ', '2')),  (('B', '3'), (' ', '2')), (('B', '4'), (' ', '2')), (('B', '5'), (' ', '2')), (('B', '6'), (' ', '2')), (('B', '7'), ('b', '2')), (('B', '8'), (' ', '2')),
                                       (('C', '0'), ('p', '2')), (('C', '1'), ('p', '2')), (('C', '2'), ('p', '2')),  (('C', '3'), ('p', '2')), (('C', '4'), ('p', '2')), (('C', '5'), ('p', '2')), (('C', '6'), ('p', '2')), (('D', '7'), ('p', '2')), (('D', '8'), ('p', '2')),
                                       (('D', '0'), (' ', '0')), (('D', '1'), (' ', '0')), (('D', '2'), (' ', '0')),  (('D', '3'), (' ', '0')), (('D', '4'), (' ', '0')), (('D', '5'), (' ', '0')), (('D', '6'), (' ', '0')), (('D', '7'), (' ', '0')), (('D', '8'), (' ', '0')),
                                       (('E', '0'), (' ', '0')), (('E', '1'), (' ', '0')), (('E', '2'), (' ', '0')),  (('E', '3'), (' ', '0')), (('E', '4'), (' ', '0')), (('E', '5'), (' ', '0')), (('E', '6'), (' ', '0')), (('E', '7'), (' ', '0')), (('E', '8'), (' ', '0')),
                                       (('F', '0'), (' ', '0')), (('F', '1'), (' ', '0')), (('F', '2'), (' ', '0')),  (('F', '3'), (' ', '0')), (('F', '4'), (' ', '0')), (('F', '5'), (' ', '0')), (('F', '6'), (' ', '0')), (('F', '7'), (' ', '0')), (('F', '8'), (' ', '0')),
                                       (('G', '0'), ('p', '1')), (('G', '1'), ('p', '1')), (('G', '2'), ('p', '1')),  (('G', '3'), ('p', '1')), (('G', '4'), ('p', '1')), (('G', '5'), ('p', '1')), (('G', '6'), ('p', '1')), (('G', '7'), ('p', '1')), (('G', '8'), ('p', '1')),
                                       (('H', '0'), (' ', '1')), (('H', '1'), ('b', '1')), (('H', '2'), (' ', '1')),  (('H', '3'), (' ', '1')), (('H', '4'), (' ', '1')), (('H', '5'), (' ', '1')), (('H', '6'), (' ', '1')), (('H', '7'), ('r', '1')), (('H', '8'), (' ', '1')),
                                       (('I', '0'), ('l', '1')), (('I', '1'), ('n', '1')), (('I', '2'), ('s', '1')),  (('I', '3'), ('G', '1')), (('I', '4'), ('K', '1')), (('I', '5'), ('G', '1')), (('I', '6'), ('s', '1')), (('I', '7'), ('n', '1')), (('I', '8'), ('l', '1'))]



getCellLine :: String -> Char
getCellLine "" = '*'
getCellLine (x:xs) | xs == "" = '*'
               | length xs > 1 = '*'
               | otherwise = x


getCellColumn :: String -> Char
getCellColumn "" = '*'
getCellColumn (x:y:ys) | (length(y:ys)) == 0 = '*'
                       | (length ys) /= 0 = '*'
                       | otherwise = y


isValidInputPosition :: String -> Bool
isValidInputPosition input
    | length(input) /= 2 = False
    | Data.Map.member (line, column) newMediumPiecesMap = True
    | otherwise = False
    where line = getCellLine input
          column = getCellColumn input

startTurn :: String -> Char -> String -> String -> IO()
startTurn difficulty currentPlayer player1name player2name = do
    let gameOver = False
    if gameOver
        then
            do
                putStr "Game Over\n"
                -- print the winner
                putStr "The winner is "
                if currentPlayer == '1'
                    then
                        putStr player1name
                    else
                        putStr player2name
                putStr "\n"

        else -- Game not over
            do
                -- to do: Print board 

                if currentPlayer == '1'
                    then do
                        setSGR [SetColor Foreground Vivid Red]    
                        putStrLn ("\n" ++ player1name ++ "'s turn.")
                    else do
                        setSGR [SetColor Foreground Vivid Blue]
                        putStrLn ("\n" ++ player2name ++ "'s turn.")
                setSGR [Reset]  -- Reset to default colour scheme
                putStrLn "Digite a posicao da peca que voce deseja mover (LETRA MAUISCULA) (ex.: G2): "
                
                input <- getLine
                if isValidInputPosition input
                    then do
                        putStrLn ("Jogador na posicao " ++ input ++ " = " ++ [playerAtPos newMediumPiecesMap (getCellLine(input), getCellColumn(input))])
                        putStrLn ("Peca na posicao " ++ input ++ " = " ++ [pieceAtPos newMediumPiecesMap (getCellLine(input), getCellColumn(input))])
                        startTurn difficulty (oponent(currentPlayer)) player1name player2name -- switches players
                    else do
                        putStrLn "Invalid entry. Try again: "
                        startTurn difficulty currentPlayer player1name player2name -- switches players

                
                
main :: IO()
main = do 
        putStrLn ""
        putStrLn "1- Start Game"
        putStrLn "2- Instructions"
        putStrLn "\n"
        putStrLn "Select your Option :"
        option <- getLine  
        if option == "1" then startTurn "2" '1' "Fulano" "Sicrano" else putStrLn "Nao disponivel ainda." -- to do