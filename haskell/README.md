# Proj-APlp-2019.1-Grupo-4

Run make scrpt to build and run the application.

Main menu will open showing Help, Instructions and Game Start options.

Enter the difficulty and the players names.

To run the project in ubuntu is necessary to install the 3 dependencies colour, mintty and ansi-terminal:

colour: cabal install colour
http://hackage.haskell.org/package/colour

mintty: cabal install mintty
http://hackage.haskell.org/package/mintty

ansi-terminal: cabal install ansi-terminal
http://hackage.haskell.org/package/ansi-terminal

To run the project in windows is necessary to download and install the haskell and cabal, download the 3 dependecies, extract them and open the terminal in the extracted folder, and then run the following commands:

runhaskell Setup configure
runhaskell Setup build
runhaskell Setup install
