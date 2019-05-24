# Proj-PLP-2019.1-Grupo-3 (haskell version)

To run the project on ubuntu it's necessary to install the 3 dependencies: **colour, mintty and ansi-terminal**

**colour: cabal install colour**
http://hackage.haskell.org/package/colour

**mintty: cabal install mintty**
http://hackage.haskell.org/package/mintty

**ansi-terminal: cabal install ansi-terminal**
http://hackage.haskell.org/package/ansi-terminal

runhaskell Setup configure
runhaskell Setup build
(sudo) runhaskell Setup install

or

**install via cabal by:**
cabal update
cabal install colour mintty ansi-terminal

**Running the game:**

main() menu will open showing **Help**, **Instructions** and **Game Start** options.

Start the game by using **option 1**, enter the **difficulty** chosen and the players' **names**.


