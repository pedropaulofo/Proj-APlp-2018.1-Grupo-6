:- initialization main.

%% codes and auxiliary 
cls :- write('\e[2J').

lowerLimitColumn(Code) :- char_code('a', Code).
upperLimitColumn(Code) :- char_code('i', Code).

print_playerturn(player1) :-
    ansi_format([bold, fg(cyan)], '~w', ['Player1']),
    writeln(", enter your move: "), !.
print_playerturn(player2) :-
    ansi_format([bold, fg(yellow)], '~w', ['Player2']),
    writeln(", enter your move: "), !.

line_letter_toNum('A', 0).
line_letter_toNum('B', 1).
line_letter_toNum('C', 2).
line_letter_toNum('D', 3).
line_letter_toNum('E', 4).
line_letter_toNum('F', 5).
line_letter_toNum('G', 6).
line_letter_toNum('H', 7).
line_letter_toNum('I', 8).

is_valid_index(Index) :-
	Index >= 0,
	Index < 9.

adversary(player1, player2).
adversary(player2, player1).

player_code(player1, '1').
player_code(player2, '2').

replace( [L|Ls] , 0 , Y , Z , [R|Ls] ) :- % once we find the desired row,
  replace_column(L,Y,Z,R)                 % - we replace specified column, and we're done.
  .                                       %
replace( [L|Ls] , X , Y , Z , [L|Rs] ) :- % if we haven't found the desired row yet
  X > 0 ,                                 % - and the row offset is positive,
  X1 is X-1 ,                             % - we decrement the row offset
  replace( Ls , X1 , Y , Z , Rs )         % - and recurse down
  .                                       %

replace_column( [_|Cs] , 0 , Z , [Z|Cs] ) .  % once we find the specified offset, just make the substitution and finish up.
replace_column( [C|Cs] , Y , Z , [C|Rs] ) :- % otherwise,
  Y > 0 ,                                    % - assuming that the column offset is positive,
  Y1 is Y-1 ,                                % - we decrement it
  replace_column( Cs , Y1 , Z , Rs )         % - and recurse down.
  .      

%% game data
pieces_map([['l', 'n', 's', 'G', 'K', 'G', 's', 'n', 'l'],
            [' ', 'r', ' ', ' ', ' ', ' ', ' ', 'b', ' '],
            ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
            ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'], 
            [' ', 'b', ' ', ' ', ' ', ' ', ' ', 'r', ' '], 
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

/* print board relations */
print_board(Pieces, Players) :-   
	writeln('\n  0 1 2 3 4 5 6 7 8 '),
	print_board(Pieces, Players, 0, 0).

print_board(Pieces, Players, 8, 9) :-
	writeln('|I'),
	writeln('  0 1 2 3 4 5 6 7 8 \n'),!.

print_board(Pieces, Players, Row, 0) :-
    line_letter_toNum(RowL, Row),
    write(RowL),
	write('|'),
    piece(Pieces, Row, 0, Piece),
    print_piece(Players, Piece, Row, Column),
	print_board(Pieces, Players, Row, 1).

print_board(Pieces, Players, Row, 9) :-
	Row \= 8,
	NextRow is Row + 1,
	write('|'),
    line_letter_toNum(RowL, Row),
    writeln(RowL),
	print_board(Pieces, Players, NextRow, 0).
print_board(Pieces, Players, Row, Column) :-
	Column \= 0,
	write('.'),
    piece(Pieces, Row, Column, Piece),
    print_piece(Players, Piece, Row, Column),
	NextColumn is Column + 1,
	print_board(Pieces, Players, Row, NextColumn).

piece(Pieces, RowIndex, ColumnIndex, Piece) :-
	is_valid_index(RowIndex),
	is_valid_index(ColumnIndex),
	nth0(RowIndex, Pieces, Row),
	nth0(ColumnIndex, Row, Piece).

print_piece(PlayersMap, _, RowIndex, ColumnIndex) :-
    nth0(RowIndex, PlayersMap, Row),
    nth0(ColumnIndex, Row, '0'),
    write(' '),!.

print_piece(PlayersMap, Piece, RowIndex, ColumnIndex) :-
    nth0(RowIndex, PlayersMap, Row),
    nth0(ColumnIndex, Row, '1'),
    ansi_format([bold, fg(cyan)], '~w', [Piece]),!.

print_piece(PlayersMap, Piece, RowIndex, ColumnIndex) :-
    nth0(RowIndex, PlayersMap, Row),
    nth0(ColumnIndex, Row, '2'),
    ansi_format([bold, fg(yellow)], '~w', [Piece]),!.

/* Validation of input */
valid_column(Index) :-
               integer(Index),
               Index >= 0, Index < 9.


valid_line(Index) :-
                char_type(Index, alpha),
                char_type(IndexLower, to_lower(Index)),
                char_code(IndexLower, CodeI),
                lowerLimitColumn(CodeL),
                upperLimitColumn(CodeU),
                CodeI >= CodeL,
                CodeI =< CodeU.

read_column(Column) :-
                write_ln("Enter the COLUMN coordinate of the piece you want to move (0-8): "),
                read_number(Column),
                valid_column(Column).           
read_column(Column) :-
                write_ln("Invalid column. Try again."),
                read_column(Column).

read_number(Number) :- read_line_to_codes(user_input, Codes),string_to_atom(Codes, Atom),atom_number(Atom, Number).

read_lineIndex(Line):-
                write_ln("Enter the LINE coordinate of the piece you want to move (A-I): "),
                read_line_to_string(user_input, Line),
                NewLine is Line,
                valid_line(NewLine).
read_lineIndex(Line):-
                write_ln("Invalid line. Try again."),
                read_lineIndex(Line).

/* Positions handling */

insert_piece(Pieces, Players, Line, Column, Element, Owner, NewPieces, NewPlayers) :-
    char_type(LineUpper, to_upper(Line)),
    line_letter_toNum(LineUpper, Row),
    replace(Pieces, Row, Column, Element, NewPieces),
    replace(Players, Row, Column, Owner, NewPlayers).

clear_cell(Pieces, Players, Line, Column, NewPieces, NewPlayers) :-
    char_type(LineUpper, to_upper(Line)),
    line_letter_toNum(LineUpper, Row),    
    replace(Pieces, Row, Column, ' ', NewPieces),
    replace(Players, Row, Column, '0', NewPlayers).

move_piece(Pieces, Players, OriginLine, OriginColumn, TargetLine, TargetColumn, SelectedPiece, CurrentPlayer, FinalPieces, FinalPlayers) :-
    clear_cell(Pieces, Players, OriginLine, OriginColumn, Pieces2, Players2), % Apaga a celula onde estava a peca
    insert_piece(Pieces2, Players2, TargetLine, TargetColumn, SelectedPiece, CurrentPlayer, FinalPieces, FinalPlayers). % Insere a peca na nova posicao


selected_piece(Pieces, Line, Column, SelectedPiece) :-
    char_type(LineUpper, to_upper(Line)),
    line_letter_toNum(LineUpper, Row),
    piece(Pieces, Row, Column, SelectedPiece).

/* Game Loop */
game_loop(Pieces, Players, CurrentPlayer) :-
    repeat,
    cls,
    print_board(Pieces, Players),
    print_playerturn(CurrentPlayer),

    read_lineIndex(OriginLine), % Le a linha da peca de origem do movimento
    read_column(OriginColumn),  % Le a coluna da peca de origem do movimento

    selected_piece(Pieces, OriginLine, OriginColumn, SelectedPiece), % Peca selecionada
    writeln(SelectedPiece),
    
    read_lineIndex(TargetLine), % Le a linha de destino do movimento
    read_column(TargetColumn),  % Le a coluna de destino do movimento

    player_code(CurrentPlayer, PCode),

    move_piece(Pieces, Players, OriginLine, OriginColumn, TargetLine, TargetColumn, SelectedPiece, PCode, FinalPieces, FinalPlayers),
    
    adversary(CurrentPlayer, Oponent),    % Troca pro adversario
    game_loop(FinalPieces, FinalPlayers, Oponent).


%% Menu Navigation
main_menu :- write("\nEnter the selected option:\n\t1) Start game\n\t2) Rules\n\t3) Exit").

input_main_menu('1') :- pieces_map(Pieces),
                        players_map(Players),
                        game_loop(Pieces, Players, player1).
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