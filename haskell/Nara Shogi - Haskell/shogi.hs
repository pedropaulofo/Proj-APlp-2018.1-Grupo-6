currentPlayer :: Bool
currentPlayer = True -- to do
    

startGame :: String -> String -> String -> IO()
startGame difficulty player1name player2name = do
    let gameOver = False
    if gameOver
        then
            do
                putStr "Game Over\n"
                -- print the winner
                putStr "The winner is "
                if currentPlayer == True
                    then
                        putStr player1name
                    else
                        putStr player2name
                putStr "\n"

        else -- Game not over
            do
                putStr "Jogo" -- to do

main :: IO()
main = do 
        putStrLn ""
        putStrLn "1- Start Game"
        putStrLn "2- Instructions"
        putStrLn "\n"
        putStrLn "Select your Option :"
        option <- getLine  
        if option == "1" then startGame "2" "Fulano" "Sicrano" else putStrLn "Nao disponivel ainda." -- to do