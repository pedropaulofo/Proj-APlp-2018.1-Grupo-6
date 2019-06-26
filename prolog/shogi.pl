:- initialization main.

%% codes and auxiliary 
cls :- write('\e[2J').
lowerLimitColumn(Code) :- char_code('a', Code).
upperLimitColumn(Code) :- char_code('i', Code).
print_playerturn(player1) :- write("Player1, enter your move: "), !.
print_playerturn(player2) :- write("Player2, enter your move: "), !.
line_letter_toNum('a', 0).
line_letter_toNum('b', 1).
line_letter_toNum('c', 2).
line_letter_toNum('d', 3).
line_letter_toNum('e', 4).
line_letter_toNum('f', 5).
line_letter_toNum('g', 6).
line_letter_toNum('h', 7).
line_letter_toNum('i', 8).
is_valid_index(Index) :-
	Index >= 0,
	Index < 9.

%% game data
pieces_map([['l', 'n', 's', 'G', 'K', 'G', 's', 'n', 'l'],
            ['_', 'r', '_', '_', '_', '_', '_', 'b', '_'],
            ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
            ['_', '_', '_', '_', '_', '_', '_', '_', '_'], 
            ['_', '_', '_', '_', '_', '_', '_', '_', '_'], 
            ['_', '_', '_', '_', '_', '_', '_', '_', '_'], 
            ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'], 
            ['_', 'b', '_', '_', '_', '_', '_', 'r', '_'], 
            ['l', 'n', 's', 'G', 'K', 'G', 's', 'n', 'l']]).

players_map([['2', '2', '2', '2', '2', '2', '2', '2', '2'],
             ['0', '2', '0', '0', '0', '0', '0', '2', '0'],
             ['2', '2', '2', '2', '2', '2', '2', '2', '2'],
             ['0', '0', '0', '0', '0', '0', '0', '0', '0'],
             ['0', '0', '0', '0', '0', '0', '0', '0', '0'],
             ['0', '0', '0', '0', '0', '0', '0', '0', '0'],
             ['1', '1', '1', '1', '1', '1', '1', '1', '1'],
             ['0', '1', '0', '0', '0', '0', '0', '1', '0'],
             ['1', '1', '1', '1', '1', '1', '1', '1', '1']]).

/*positions([('A', '0'), ('A', '1'), ('A', '2'), ('A', '3'), ('A', '4'), ('A', '5'), ('A', '6'), ('A', '7'), ('A', '8'),
           ('B', '0'), ('B', '1'), ('B', '2'), ('B', '3'), ('B', '4'), ('B', '5'), ('B', '6'), ('B', '7'), ('B', '8'),
           ('C', '0'), ('C', '1'), ('C', '2'), ('C', '3'), ('C', '4'), ('C', '5'), ('C', '6'), ('C', '7'), ('C', '8'),
           ('D', '0'), ('D', '1'), ('D', '2'), ('D', '3'), ('D', '4'), ('D', '5'), ('D', '6'), ('D', '7'), ('D', '8'),
           ('E', '0'), ('E', '1'), ('E', '2'), ('E', '3'), ('E', '4'), ('E', '5'), ('E', '6'), ('E', '7'), ('E', '8'),
           ('F', '0'), ('F', '1'), ('F', '2'), ('F', '3'), ('F', '4'), ('F', '5'), ('F', '6'), ('F', '7'), ('F', '8'),
           ('G', '0'), ('G', '1'), ('G', '2'), ('G', '3'), ('G', '4'), ('G', '5'), ('G', '6'), ('G', '7'), ('G', '8'),
           ('H', '0'), ('H', '1'), ('H', '2'), ('H', '3'), ('H', '4'), ('H', '5'), ('H', '6'), ('H', '7'), ('H', '8'),
           ('I', '0'), ('I', '1'), ('I', '2'), ('I', '3'), ('I', '4'), ('I', '5'), ('I', '6'), ('I', '7'), ('I', '8')]).*/

/* print board relations */
print_board(Board) :-   
	writeln('\n  0 1 2 3 4 5 6 7 8 '),
	print_board(Board, 0, 0).

print_board(Board, 8, 9) :-
	writeln('|8'),
	writeln('  0 1 2 3 4 5 6 7 8 \n'),!.

print_board(Board, Row, 0) :-
	write(Row),
	write('|'),
	piece(Board, Row, 0, Piece),
	write(Piece), 
	print_board(Board, Row, 1).

print_board(Board, Row, 9) :-
	Row \= 8,
	NextRow is Row + 1,
	write('|'),
	writeln(Row),
	print_board(Board, NextRow, 0).

print_board(Board, Row, Column) :-
	Column \= 0,
	write('.'),
	piece(Board, Row, Column, Piece),
	write(Piece),
	NextColumn is Column + 1,
	print_board(Board, Row, NextColumn).

piece(Board, RowIndex, ColumnIndex, Piece) :-
	is_valid_index(RowIndex),
	is_valid_index(ColumnIndex),
	nth0(RowIndex, Board, Row),
	nth0(ColumnIndex, Row, Piece).

/* Validation of input */
valid_line(Index) :- integer(Index),
               Index >= 0, Index < 9.

valid_column(Index) :-
                char_type(Index, alpha),
                char_code(Index, CodeI),
                lowerLimitColumn(CodeL),
                upperLimitColumn(CodeU),
                CodeI >= CodeL,
                CodeI =< CodeU.

read_column :-
                write_ln("Enter the COLUMN coordinate of the piece you want to move: "),
                read_line_to_string(user_input, Column),
                valid_column(Column),
                write_ln("Valid column, OK").
            
read_column :-  write_ln("Invalid column. Try again."),
                read_column.

read_number(Number) :- read_line_to_codes(user_input, Codes),string_to_atom(Codes, Atom),atom_number(Atom, Number).

read_lineIndex :-
                write_ln("Enter the LINE coordinate of the piece you want to move: "),
                read_number(Line),
                valid_line(Line),
                write_ln("Valid line, OK.").

read_lineIndex :-
                write_ln("Invalid line. Try again."),
                read_lineIndex.


game_loop(Board) :-
    repeat,
    cls,
    print_board(Board),
    read_column,
    read_lineIndex,
    game_loop(Board).


%% Menu Navigation
main_menu :- write("\nEnter the selected option:\n\t1) Start game\n\t2) Rules\n\t3) Exit").

input_main_menu('1') :- pieces_map(Board),
                        game_loop(Board).
input_main_menu('2') :- print_help().
input_main_menu('3') :- write("Leaving game..."), halt(0).
input_main_menu(_) :- write("Invalid input! Try again: ").

start :-
    repeat,
    main_menu(),
    nl,
    get_single_char(X),
    char_code(Y,X),
    cls,
    input_main_menu(Y),
    start.

main :- 
    cls,
    start,
    halt(0).

%% Help

print_help():-
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