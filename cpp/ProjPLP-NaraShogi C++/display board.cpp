#include <iostream>
#include <string>
#include <cstdio>
#include <algorithm>
#include <fstream>

#include "pch.h"
#include "colors.h"
#include "game_mechanics.h"

using namespace std;

/// DECLARACOES GLOBAIS COMECAM ABAIXO

int check_command(string input, board_pos current_cell);

board_pos origin_cell, target_cell;

string current_player_name;

char overrid_cell_content;

bool piece_selected = false;


string newInput;
char newChoice;
bool bol;


// FUNCOES COMECAM ABAIXO:


void print_file2(string filename){
	string line;
	ifstream myfile(filename);
	if (myfile.is_open()){
		while (getline(myfile, line)){
			cout << line << endl;
		}
		myfile.close();
	}else{
		cout << "Unable to open " << filename;
	}
}

void game_turn();

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

	printf(CLEAR_SCREEN);

	int display_lines, display_columns;
	if (dif == EASY) {
		display_lines = DISPLAY_LINES_E;
		display_columns = DISPLAY_COLUMNS_E;
	}
	else if(dif == MEDIUM){
		display_lines = DISPLAY_LINES_M;
		display_columns = DISPLAY_COLUMNS_M;
	}
	else {
		display_lines = DISPLAY_LINES_H;
		display_columns = DISPLAY_COLUMNS_H;
	}

	background(BLACK);
	int pcs_col = 0;
	int pcs_line = 0;

	for (int i = 0; i < display_lines; i++) {
		for (int j = 0; j < display_columns; j++) {
			
			char out = display_board[i][j];

			foreground(WHITE);
			if (i == transf_matrix[pcs_line][pcs_col].line_pos && j == transf_matrix[pcs_line][pcs_col].column_pos) { // if the char displays one of the cells
				if (players_map[pcs_line][pcs_col] == P2_IDENTIFER) {
					set_player_textxcolor(false); // if the piece is from player 2, displays in YELLOW
				}
				else if (players_map[pcs_line][pcs_col] == P1_IDENTIFER) {
					set_player_textxcolor(true); // if the piece is from player 1, displays in CYAN
				}
				pcs_col++;

				if (pcs_col >= get_board_columnsize(dif)) {
					pcs_col = 0;
					pcs_line++;
				}

			}
			if (out == BLANK_CELL) {
				foreground(BLACK); // hides the empty cell by setting it to black
			}
			else if (out == HIGHLIGHT_CHAR) {
				foreground(GREEN); // higlights the selected cell with green slashes around it
			}
			else if (i == 0 || i == display_lines-1 || j == 2) {
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
	print_board();
	foreground(RED);
	std::cout << "\n" << message << "\n";
	style(RESETALL);
}

bool input_target() {
	string input_text;
	board_pos cell;

	while (true) { // LOOP WAITING FOR A VALID TARGET POSITION

		foreground(GREEN);
		std::cout << "GAME COMMANDS: B - UNDO SELECTION; R - RESET GAME; H - HELP; C - CLOSE GAME\n";
		style(RESETALL);

		print_player_name(current_player_name);
		std::cout << ", choose the where to you want to move with your selected piece.\n" << "Target coordinates: ";
		std::cin >> input_text;


		int command = check_command(input_text, origin_cell); // Check if input is a game command
		if (command == EXIT) {
			break;
		}
		else if (command == RETRY) {
			continue;
		}

		if (coordinate_isvalid(input_text)) {								// CHECK IF THE INPUT IS A VALID POSITION ON THE BOARD
			cell = text_to_pos(input_text);

			if (!is_from_player(cell, player_turn)) {						// CHECK IF THE POSITION GIVEN DOES NOT CONTAIN ONE OF THE OWN PLAYER'S PIECES
				char piece = pieces_map[origin_cell.line_pos][origin_cell.column_pos];

				if (is_legal_move(piece, origin_cell, cell)) {				// CHECK IF THE MOVE IS LEGAL FOR THE PIECE CHOSEN

					highlight_cell(origin_cell, true);						// Undoes the selected highlight, as the move will be completed

					if (is_from_player(cell, !player_turn)) {
						foreground(BLUE);
						std::cout << "Oponent's piece captured: '" << pieces_map[cell.line_pos][cell.column_pos] << "'!";
					}
					target_cell = cell;
					return true;
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
	}
	return false;
}

void input_origin() {
	string input_text;
	board_pos  cell;

	if(piece_selected) return;

	while (true) { // LOOP WAITING FOR A VALID ORIGIN POSITION
		piece_selected = false;
		foreground(GREEN);
		std::cout << "GAME COMMANDS: R - RESET GAME; H - HELP; C - CLOSE GAME\n";
		style(RESETALL);

		print_player_name(current_player_name);
		std::cout << "'s turn. Choose the piece you want to make a move with by typing its coordinates. (Example: G2)\n" << "Piece of choice: ";
		std::cin >> input_text;

		int command = check_command(input_text, cell); // Check if input is a game command
		if (command == EXIT) {
			break;
		}
		else if (command == RETRY) continue;

		list<char> captured = is_player1_turn() ? p1_captured_pcs : p2_captured_pcs;

		if (coordinate_isvalid(input_text)) {					// CHECK IF THE INPUT REFER TO VALID COORDINATES ON THE BOARD
			cell = text_to_pos(input_text);

			if (is_from_player(cell, player_turn)) {		// CHECK IF THE CHOSEN COORDINATES CONTAIN ONE OF THE PLAYER'S PIECES

				highlight_cell(cell, false);			// Highlights the selected piece
				piece_selected = true;
				break;
			}
			else if (players_map[cell.line_pos][cell.column_pos] == NOPLAYER) {
				highlight_cell(cell, false);
				print_board();
				
				foreground(BLUE);
				std::cout << current_player_name << "'s captured pieces: ";
				for (auto const& i: captured) {
					std::cout << i << ", ";
				}
				style(RESETALL);

				std:cout << endl;
				highlight_cell(cell, true);
				drop(captured, cell);
				cin;
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
	if (piece_selected) origin_cell = cell;
}

int check_command(string input, board_pos current_cell) {

	if (input.length() == 1) {
		char command = toupper(input[0]);

		switch (command) {
			case BACK:
				if (piece_selected) {
					piece_selected = false;
					highlight_cell(current_cell, true);
				}
				return EXIT;
			case HELP:
					bol = true;
				while (bol) {
					cout << "1-Help. \n";
					cout << "2-Ajuda. \n";
					cout << "B-back to main menu. \n";
					cin >> newInput;
					newChoice = newInput[0];
					switch (newChoice)
					{
						case '1':
							print_file2("help.txt");
							bol=false;							
							break;
						case '2':
							print_file2("ajuda.txt");
							bol=false;
							break;
						case 'B':
							bol=false;
							break;
						case 'b':
							bol=false;
							break;
						default:
							cout << "Invalid option. Try again: \n";
							continue;
					}
				}
				return RETRY;
			case RESET:
				main();
				return EXIT;
			case CLOSE:
				exit(0);
			default:
				return NO_COMMAND;
		}
	}
	return NO_COMMAND;
}

void game_turn() {

	input_origin();			// Get the ORIGIN position of the move
	if (piece_selected) {
		update_display_board();
		print_board();			
		
		bool move_complete = input_target();			// Get the TARGETED position of the move

		if (move_complete){
			overrid_cell_content = move(origin_cell, target_cell);			// MAKES THE MOVE
			check_and_promote(target_cell);			// PROMOTES IF THE PIECE REACHES PROMOTION AREA
		}
	}
	piece_selected = false;

	update_display_board(); 
	print_board();		
}

// MATCH STARTS WITH THE FOLLOWING FUNCTION:

void start_match(int difficulty, string player1_name, string player2_name) {
	
	dif = difficulty;
	resetMaps();
	player_turn = true; // Starts with PLAYER1

	update_display_board(); // updates the current board configuration on the graphic board representation
	print_board();			// prints the graphic board on display with colors according to the players pieces

	while (true) { // GAME LOOP

		current_player_name = is_player1_turn() ? player1_name : player2_name;  // Get the current turn Player's Name

		game_turn();

		if (overrid_cell_content == KING) break; // Checks if enemy king was captured
			
	}

	//PARTE DE TELA FINAL DO JOGO PENDENTE...
	cout << "Player " << current_player_name << " wins!\n";
	cout << "Enter any key to continue: \n";
	wait_confirmation();
	main();
	return;
}


