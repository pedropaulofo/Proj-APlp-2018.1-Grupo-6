#include <iostream>
#include <string>
#include <cstdio>

#include "pch.h"
#include "colors.h"
#include "boards.h"
#include "game_mechanics.h"

using namespace std;

/// DECLARACOES GLOBAIS COMECAM ABAIXO

int check_command(string input, board_pos current_cell, bool disable_back);

board_pos origin_cell, target_cell;

string current_player_name;

char overrid_cell_content;

// FUNCOES COMECAM ABAIXO:


void set_player_textxcolor(bool is_player1) {
	if (is_player1) foreground(CYAN);
	else foreground(YELLOW);
}

void print_player_name(string current_player_name) {
	set_player_textxcolor(is_player1_turn());
	cout << current_player_name;
	style(RESETALL);
}

board_pos text_to_pos(string input) {
	board_pos conversao;

	char linha = toupper(input[0]);
	char coluna = input[1];

	conversao.line_pos = (int)linha - BASE_ASCII_SUBT_LINE;
	conversao.column_pos = (int)coluna - BASE_ASCII_SUBT_COLUMN;

	return conversao;
}

void print_board() {
	background(BLACK);

	int coluna = 0;
	for (int i = 0; i < 39; i++) {
		int linha = 0;
		for (int j = 0; j < 59; j++) {
			char out = display_board[i][j];
			foreground(WHITE);
			if (i == transf_matrix[linha][coluna].line_pos && j == transf_matrix[linha][coluna].column_pos) { // if the char displays one of the cells

				if (players_map[linha][coluna] == '2') {
					set_player_textxcolor(false); // if the piece is from player 2, displays in RED
				}
				else if (players_map[linha][coluna] == '1') {
					set_player_textxcolor(true);; // if the piece is from player 1, displays in CYAN
				}
				coluna += 1;
				if (linha > BOARDSIZE) {
					coluna = 0;
					linha += 1;
				}

			}
			if (out == BLANK_CELL) {
				foreground(BLACK); // hides the empty cell by setting it to black
			}
			else if (out == HIGHLIGHT_CHAR) {
				foreground(GREEN); // higlights the selected cell with green slashes around it
			}
			else if (i == 0 || i == 38 || j == 2) {
				foreground(MARGENTA); // cells indexes
			}

			printf("%C", out); // PRINTS CHAR

		}
		printf("\n");

	}
	style(RESETALL);
}

void update_display_board() {
	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < 9; j++) {
			if (pieces_map[i][j] != char(32)) {
				display_board[transf_matrix[i][j].line_pos][transf_matrix[i][j].column_pos] = pieces_map[i][j];
			}
		}
	}
}

void highlight_cell(board_pos move_origin, bool undo) { /// If UNDO is TRUE, clears the highlight by switching for blank space. If UNDO is FALSE, inserts the Highligth Character arround the selected cell
	int line = move_origin.line_pos;
	int column = move_origin.column_pos;
	int display_line = transf_matrix[line][column].line_pos; //Corresponding LINE index on DISPLAY board
	int display_column = transf_matrix[line][column].column_pos; //Corresponding COLUMN index on DISPLAY board

	char overlay = undo ? BLANK_CELL : HIGHLIGHT_CHAR;

	display_board[display_line - 1][display_column - 1] = overlay; //diagonal sup esq
	display_board[display_line - 1][display_column] = overlay; //vertical sup
	display_board[display_line - 1][display_column + 1] = overlay; //diagonal sup dir
	display_board[display_line][display_column + 1] = overlay; //lateral dir
	display_board[display_line + 1][display_column + 1] = overlay; //diagonal inf dir
	display_board[display_line + 1][display_column] = overlay; //vertical inf
	display_board[display_line + 1][display_column - 1] = overlay; //diagonal inf esq
	display_board[display_line][display_column - 1] = overlay; 	//lateral esq
}

void print_warning(string message) {
	printf(CLEAR_SCREEN);
	print_board();
	foreground(RED);
	cout << "\n" << message << "\n";
	style(RESETALL);
}

board_pos input_origin() {
	string input_text;
	board_pos  cell;

	while (true) { // LOOP WAITING FOR A VALID ORIGIN POSITION

		foreground(GREEN);
		cout << "GAME COMMANDS: R - RESET GAME; H - HELP; C - CLOSE GAME\n";
		style(RESETALL);

		print_player_name(current_player_name);
		cout << "'s turn. Choose the piece you want to make a move with by typing its coordinates. (Example: G2)\n" << "Piece of choice: ";
		cin >> input_text;

		int command = check_command(input_text, cell, false); // Check if input is a game command
		if (command == 2) break;
		else if (command == 1) continue;

		if (coordinate_isvalid(input_text)) {					// CHECK IF THE INPUT REFER TO VALID COORDINATES ON THE BOARD
			cell = text_to_pos(input_text);

			if (is_from_player(cell, player_turn)) {		// CHECK IF THE CHOSEN COORDINATES CONTAIN ONE OF THE PLAYER'S PIECES

				highlight_cell(cell, false);			// Highlights the selected piece
				printf(CLEAR_SCREEN);
				print_board();
				break;
			}
			else {
				print_warning("'" + input_text + "' does not contain the current player piece. Try again:");
			}
		}
		else {
			print_warning("'" + input_text + "' is an invalid input. Try again:");
		}
	}
	return cell;
}

board_pos input_target() {
	string input_text;
	board_pos cell;

	while (true) { // LOOP WAITING FOR A VALID TARGET POSITION

		foreground(GREEN);
		cout << "GAME COMMANDS: B - UNDO SELECTION; R - RESET GAME; H - HELP; C - CLOSE GAME\n";
		style(RESETALL);

		print_player_name(current_player_name);
		cout << ", choose the where to you want to move with your selected piece.\n" << "Target coordinates: ";
		cin >> input_text;

		int command = check_command(input_text, origin_cell, true); // Check if input is a game command
		if (command == 2) break;
		else if (command == 1) continue;

		if (coordinate_isvalid(input_text)) {								// CHECK IF THE INPUT IS A VALID POSITION ON THE BOARD
			cell = text_to_pos(input_text);

			if (!is_from_player(cell, player_turn)) {						// CHECK IF THE POSITION GIVEN DOES NOT CONTAIN ONE OF THE OWN PLAYER'S PIECES
				char piece = pieces_map[origin_cell.line_pos][origin_cell.column_pos];

				if (is_legal_move(piece, origin_cell, cell)) {				// CHECK IF THE MOVE IS LEGAL FOR THE PIECE CHOSEN

					highlight_cell(origin_cell, true);						// Undoes the selected highlight, as the move will be completed

					if (is_from_player(cell, !player_turn)) {
						foreground(BLUE);
						cout << "Oponent's piece captured: '" << pieces_map[cell.line_pos][cell.column_pos] << "'!";
					}
					break;
				}
				else {
					print_warning("Invalid move for this piece. Try again:");
				}
			}
			else {
				print_warning("'" + input_text + "' contain one of the current player pieces. Try again:");
			}
		}
		else {
			print_warning("Invalid input. Try again:");
		}
	} // END LOOP FOR TARGET POSITION

	return cell;
}

int check_command(string input, board_pos current_cell, bool enable_back) {
	if (input.length() == 1) {
		char command = toupper(input[0]);

		switch (command) {
		case BACK:
			if (enable_back) {
				highlight_cell(current_cell, true);
				cout << "selecao desfeita.\n";
				printf(CLEAR_SCREEN);
				print_board();
				origin_cell = input_origin();
			}
			printf(CLEAR_SCREEN);
			print_board();
			return RETRY;
		case HELP:
			printf("NOT YET IMPLEMENTED\n");
			return RETRY;
		case RESET:
			main();
			return EXIT;
		case CLOSE:
			exit(0);
			return EXIT;
		default:
			return NO_COMMAND;
		}
	}
	return NO_COMMAND;
}

void game_turn() {
	origin_cell = input_origin();			// Get the ORIGIN position of the move
	target_cell = input_target();			// Get the TARGETED position of the move

	overrid_cell_content = move(origin_cell, target_cell);			// MAKES THE MOVE
	
	check_and_promote(target_cell);			// PROMOTES IF THE PIECE REACHES PROMOTION AREA
	switch_turn();							// SWITCHES TURNS
}

// MATCH STARTS WITH THE FOLLOWING FUNCTION:

void start_match(int difficulty, string player1_name, string player2_name) {

	while (true) { // GAME LOOP

		printf(CLEAR_SCREEN);
		update_display_board(); // updates the current board configuration on the graphic board representation
		print_board();			// prints the graphic board on display with colors according to the palyers pieces

		current_player_name = is_player1_turn() ? player1_name : player2_name;  // Get the current turn Player's Name

		game_turn();

		if (overrid_cell_content == KING) break; //Checks if enemy king was captured after move

	}

	//PARTE DE TELA FINAL DO JOGO PENDENTE...
	cout << "Jogador " << current_player_name << " ganhou!";

}


