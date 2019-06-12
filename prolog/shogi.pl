:- initialization main.

cls :- write('\e[2J').

menu :- write("\nDigite a opção desejada:\n\t1)Jogar\n\t2)Regras\n\t3)Sair").

imprime_ajuda():-
    writeln("(K) The king moves one square in any direction, orthogonal or diagonal;"),
    writeln("(r) A rook moves any numeer of squares in an orthogonal direction;"),
    writeln("(b) A bishop moves any number of squares in a diagonal direction;"),
    writeln("(G) A gold general moves one square orthogonally, or one square diagonally forward. It cannot move diagonally backwards;"),
    writeln("(s) A silver general moves one square diagonally, one square straight forward, or one square diaggonally bacwards;"),
    writeln("(n) A knight jumps at an angle intermediate to orthogonal and diagonal in a single move;"),
    writeln("(L) A lancer moves only straight ahead, it cannot jump other pieces;"),
    writeln("(p) A pawm moves one square straight forward. It cannot retreat."),
    writeln(""),
    writeln("When the game starts you will see the board on screen. So, the player in turn can choose his piece to move typing its coordinates. Sample:"),
    writeln("   1. Player one's turn;"),
    writeln("   2. First type: G4 <--> this coordinate points the piece that the player wants to move"),
    writeln("   3. The selected piece will be colored to make it easy to show what piece the player choose"),
    writeln("   4. Second type: F4 <--> this coordinate points where the chosen piece goes"),
    writeln("   5. If it is a valid move, the piece will be placed. Else, the player will be asked to type the coordinates again"),
    writeln("   6. Turns the player"),
    writeln(""),
    writeln("Other commands:\n"),
    writeln("(B) Undo piece selection --> Type B if you want to select another piece"),
    writeln("(R) Reset Game --> Type R if you want to reset the game. You can reset the game after the game starts"),
    writeln("(H) Help with commands --> Type H if you want to get help with the game commands. You can get help after the game starts"),
    writeln("(E) Exit game --> Type E if you want to close the game and return to the main menu. You can close the game anytime you type this command"),
    writeln("\nOther mechanics:\n"),
    writeln("1. Promotion: When a piece reaches the enemy board it gets promoted and gains a new set of moves. Most of the promoted pieces gain Golden General moves."),
    writeln("   Promoted Bishop and Promoted Rook can move as their common counterparts and also 1 square to any direction. On easy mode only the Pawn is promoted."),
    writeln("2. Piece dropping: Captured enemy pieces can be dropped on empty positions, now owned by the new player. Select on your turn an empty space and the"),
    writeln("   piece you wish to drop. Pieces dropped on promotion zone will only promote after moving inside it. The Pawn and the Lancer cannot be dropped on the"),
    writeln("   last enemy row, and the Knight cannot be dropped on the last 2 rows. Promoted pieces return to their common counterparts when captured."),
    get_single_char(X).

entrada_menu('1') :- write("Digitei 1").
entrada_menu('2') :- imprime_ajuda().
entrada_menu('3') :- write("Saindo...").
entrada_menu(_) :- write("Entrada invalida!").

comeco :-
    repeat,
    menu(),
    nl,
    get_single_char(X),
    char_code(Y,X),
    cls,
    entrada_menu(Y),
    comeco.

main :- 
    cls,
    comeco,
    halt(0).