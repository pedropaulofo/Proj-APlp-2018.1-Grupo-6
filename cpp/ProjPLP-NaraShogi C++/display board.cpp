#include <iostream>
#include "pch.h"
#include "cores.h"
#include <iostream>
#include <string>
#include <cstdio>

#define CLEAR_SCREEN "\033[2J\033[1;1H"
#define BASE_ASCII_SUBT_LINE  65
#define BASE_ASCII_SUBT_COLUMN 48
#define HIGHLIGHT_CHAR '/'
#define BLANK_CELL '.'

using namespace std;

/// DECLARACOES GLOBAIS COMECAM ABAIXO

char display_board[42][59] = { //visual representation of the 9x9 board on screen
	{' ', ' ', ' ', ' ', ' ', ' ', ' ', '0', ' ', ' ', ' ', ' ', ' ', '1', ' ', ' ', ' ', ' ', ' ', '2', ' ', ' ', ' ', ' ', ' ', '3', ' ', ' ', ' ', ' ', ' ', '4', ' ', ' ', ' ', ' ', ' ', '5', ' ', ' ', ' ', ' ', ' ', '6', ' ', ' ', ' ', ' ', ' ', '7', ' ', ' ', ' ', ' ', ' ', '8', ' ', ' ', ' '},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'A', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'B', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'C', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'D', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'E', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'F', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'G', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'H', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', 'I', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'},
	{' ', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
};

board_pos transf_matrix[BOARDSIZE][BOARDSIZE] = { // correlates each board cell to the corresponding slot on the display board
	{ board_pos{  3, 7 }, board_pos{  3, 13 }, board_pos{  3, 19 }, board_pos{  3, 25 }, board_pos{  3, 31 }, board_pos{  3, 37 }, board_pos{  3, 43 }, board_pos{  3, 49 }, board_pos{  3, 55}},
	{ board_pos{  7, 7 }, board_pos{  7, 13 }, board_pos{  7, 19 }, board_pos{  7, 25 }, board_pos{  7, 31 }, board_pos{  7, 37 }, board_pos{  7, 43 }, board_pos{  7, 49 }, board_pos{  7, 55} },
	{ board_pos{ 11, 7 }, board_pos{ 11, 13 }, board_pos{ 11, 19 }, board_pos{ 11, 25 }, board_pos{ 11, 31 }, board_pos{ 11, 37 }, board_pos{ 11, 43 }, board_pos{ 11, 49 }, board_pos{  11, 55} },
	{ board_pos{ 15, 7 }, board_pos{ 15, 13 }, board_pos{ 15, 19 }, board_pos{ 15, 25 }, board_pos{ 15, 31 }, board_pos{ 15, 37 }, board_pos{ 15, 43 }, board_pos{ 15, 49 }, board_pos{  15, 55} },
	{ board_pos{ 19, 7 }, board_pos{ 19, 13 }, board_pos{ 19, 19 }, board_pos{ 19, 25 }, board_pos{ 19, 31 }, board_pos{ 19, 37 }, board_pos{ 19, 43 }, board_pos{ 19, 49 }, board_pos{  19, 55} },
	{ board_pos{ 23, 7 }, board_pos{ 23, 13 }, board_pos{ 23, 19 }, board_pos{ 23, 25 }, board_pos{ 23, 31 }, board_pos{ 23, 37 }, board_pos{ 23, 43 }, board_pos{ 23, 49 }, board_pos{  23, 55} },
	{ board_pos{ 27, 7 }, board_pos{ 27, 13 }, board_pos{ 27, 19 }, board_pos{ 27, 25 }, board_pos{ 27, 31 }, board_pos{ 27, 37 }, board_pos{ 27, 43 }, board_pos{ 27, 49 }, board_pos{  27, 55} },
	{ board_pos{ 31, 7 }, board_pos{ 31, 13 }, board_pos{ 31, 19 }, board_pos{ 31, 25 }, board_pos{ 31, 31 }, board_pos{ 31, 37 }, board_pos{ 31, 43 }, board_pos{ 31, 49 }, board_pos{  31, 55} },
	{ board_pos{ 35, 7 }, board_pos{ 35, 13 }, board_pos{ 35, 19 }, board_pos{ 35, 25 }, board_pos{ 35, 31 }, board_pos{ 35, 37 }, board_pos{ 35, 43 }, board_pos{ 35, 49 }, board_pos{  35, 55} },
};

char  players_map[BOARDSIZE][BOARDSIZE] = {
		{ '2', '2', '2', '2', '2', '2', '2', '2', '2'},
		{ '0', '2', '0', '0', '0', '0', '0', '2', '0' },
		{ '2', '2', '2', '2', '2', '2', '2', '2', '2' },
		{ '0', '0', '0', '0', '0', '0', '0', '0', '0' },
		{ '0', '0', '0', '0', '0', '0', '0', '0', '0' },
		{ '0', '0', '0', '0', '0', '0', '0', '0', '0' },
		{ '1', '1', '1', '1', '1', '1', '1', '1', '1' },
		{ '0', '1', '0', '0', '0', '0', '0', '1', '0' },
		{ '1', '1', '1', '1', '1', '1', '1', '1', '1' }
};

char pieces_map[BOARDSIZE][BOARDSIZE] = {  // K-King, G- Gold general, s-Silver general, n-Knight, L-Lance, b-Bishop, r-Rook, p-Pawn
	{'l', 'n', 's', 'G', 'K', 'G', 's', 'n', 'l'},
	{'.', 'r', '.', '.', '.', '.', '.', 'b', '.'},
	{'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'},
	{'.', '.', '.', '.', '.', '.', '.', '.', '.'},
	{'.', '.', '.', '.', '.', '.', '.', '.', '.'},
	{'.', '.', '.', '.', '.', '.', '.', '.', '.'},
	{'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'},
	{'.', 'b', '.', '.', '.', '.', '.', 'r', '.'},
	{'l', 'n', 's', 'G', 'K', 'G', 's', 'n', 'l'}
};

bool player_turn; //    true -> turn player2     false -> player1


/// FUNCOES COMECAM ABAIXO


void switch_turn() {
	player_turn = !player_turn;
}

bool player1_turn() {
	return player_turn;
}

bool player2_turn() {
	return !player_turn;
}

void print_player_name(string current_player_name) {
	player1_turn() ? foreground(CYAN) : foreground(RED);
	cout << current_player_name;
	style(RESETALL);
}

int get_line_pos(string pos) {
	char linha = toupper(pos[0]);
	int conversao = (int)linha - BASE_ASCII_SUBT_LINE;
	return conversao;
}

int get_column_pos(string pos) {
	char coluna = pos[1];
	int conversao = (int)coluna - BASE_ASCII_SUBT_COLUMN;
	return conversao;
}

bool coordinate_isvalid(string input) {
	if (input.length() != 2) return false; // input must follow the model LetterNumber, ex: A0, G2, B5
	int line = int(toupper(input[0]));
	int column = int(input[1]);
	if (line < int('A') || line > int('I')) return false;
	if (column < int('0') || column > int('8')) return false;

	return true;
}

bool has_player_piece(string pos, bool checking_player1) {
	int line = get_line_pos(pos);
	int column = get_column_pos(pos);

	return (players_map[line][column] == '1' && checking_player1) || (players_map[line][column] == '2' && !checking_player1);
}

void print_board() {
	int coluna = 0;
	for (int i = 0; i < 38; i++) {
		int linha = 0;
		for (int j = 0; j < 59; j++) {
			char out = display_board[i][j];
			if (i == transf_matrix[linha][coluna].line_pos && j == transf_matrix[linha][coluna].column_pos && players_map[linha][coluna] == '2') {
				foreground(RED);
				printf("%c", out); // if the piece is from player 2, displays in RED
				coluna += 1;
				if (linha > BOARDSIZE) {
					coluna = 0;
					linha += 1;
				}
			}
			else if (i == transf_matrix[linha][coluna].line_pos && j == transf_matrix[linha][coluna].column_pos && players_map[linha][coluna] == '1') {
				foreground(CYAN);
				printf("%c", out); // if the piece is from player 1, displays in CYAN
				coluna += 1;
				if (linha > BOARDSIZE) {
					coluna = 0;
					linha += 1;
				}
			}
			else if (i == transf_matrix[linha][coluna].line_pos && j == transf_matrix[linha][coluna].column_pos) {
				printf("%c", out);
				coluna += 1;
				if (linha > BOARDSIZE) {
					coluna = 0;
					linha += 1;
				}
			}
			else if (out == BLANK_CELL){
				foreground(BLACK);
				FOREBLACK;
				printf("%C", out);
	   		}
			else if (out == HIGHLIGHT_CHAR) {
				foreground(GREEN);
				printf("%C", out);
				

			}
			else printf("%C", out);
			style(RESETALL);
		}
		printf("\n");

	}

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

void highlight_cell(string move_origin, bool undo) { /// if UNDO is TRUE, clears the highlight by switching for blank space. If UNDO is FALSE, inserts the Highligth Character arround the selected cell
	int line = get_line_pos(move_origin);
	int column = get_column_pos(move_origin);
	int display_line = transf_matrix[line][column].line_pos; //Corresponding LINE index on DISPLAY board
	int display_column = transf_matrix[line][column].column_pos; //Corresponding COLUMN index on DISPLAY board

	char overlay = undo ? '.' : HIGHLIGHT_CHAR;

	display_board[display_line - 1][display_column - 1] = overlay; //diagonal sup esq
	display_board[display_line - 1][display_column] = overlay; //vertical sup
	display_board[display_line - 1][display_column + 1] = overlay; //diagonal sup dir
	display_board[display_line][display_column + 1] = overlay; //lateral dir
	display_board[display_line + 1][display_column + 1] = overlay; //diagonal inf dir
	display_board[display_line + 1][display_column] = overlay; //vertical inf
	display_board[display_line + 1][display_column - 1] = overlay; //diagonal inf esq
	display_board[display_line][display_column - 1] = overlay; 	//lateral esq
}

void move(board_pos origin, board_pos target) {
	int ori_line = origin.line_pos; //origin line
	int ori_col = origin.column_pos;//origin column
	int tar_line = target.line_pos; //target line
	int tar_col = target.column_pos;//target colunn

	pieces_map[tar_line][tar_col] = pieces_map[ori_line][ori_col];	// sets the selected piece to the targeted cell
	pieces_map[ori_line][ori_col] = '.';							// clears the cell where the pieces was before moving
	players_map[tar_line][tar_col] = players_map[ori_line][ori_col];// sets the targeted cell as having one of the player's piece
	players_map[ori_line][ori_col] = '0';							// sets the origin to have no player piece on it

}


// MATCH STARTS WITH THE FOLLOWING FUNCTION:

void start_match(int difficulty, string player1_name, string player2_name)
{
	player_turn = true; // starts with player1

	while (true) { // GAME LOOP

		/// ATUALIZAR A TELA
		printf(CLEAR_SCREEN);
		update_display_board(); // updates the current board configuration on the graphic board representation
		print_board(); // prints the graphic board on display with colors according to the palyers pieces

		string current_player_name; // Get the current turn Player's Name

		current_player_name = player1_turn() ? player1_name : player2_name;

		string move_origin, move_target;
		board_pos origin_cell, target_cell;
		while (true) { // LOOP AGUARDANDO RECEBER UMA POSICAO DE ORIGEM VALIDA


			print_player_name(current_player_name);
			cout << "'s turn. Choose the piece you want to make a move with by typing its coordinates. (Example: G2)\n" << "Piece of choice: ";
			cin >> move_origin;

			if (coordinate_isvalid(move_origin) && has_player_piece(move_origin, player_turn)) { // The selected position must be valid and contain one of the current player's pieces
				highlight_cell(move_origin, false); // highlights the selected piece

				origin_cell.line_pos = get_line_pos(move_origin);
				origin_cell.column_pos = get_column_pos(move_origin);

				print_board();
				break;
			}
			else {
				print_board();
				cout << "\n'" << move_origin << "' is an invalid input. Try again:\n";
			}
		}

		while (true) { // LOOP AGUARDANDO POR UM DESTINO VALIDO

			print_player_name(current_player_name);
			cout << current_player_name << ", choose the where to you want to move with the Pawn(G2)\n" << "Target coordinates: ";
			cin >> move_target;

			if (coordinate_isvalid(move_target) && !has_player_piece(move_target, player_turn)) { // The targeted position must be valid and not contain the own player's piece
				//highlight_cell(move_origin, true); // Erases the selected highlight, as the move will be made.

				target_cell.line_pos = get_line_pos(move_target);
				target_cell.column_pos = get_column_pos(move_target);

				//if (pieces_map[origin_cell.line_pos][origin_cell.column_pos] == 'c' && is_move_valid(origin_cell, target_cell, players_map, pieces_map)) {
				move(origin_cell, target_cell);
				//}

				switch_turn();
				break;
			}
			else {
				print_board();
				printf("\nInvalid input. Try again:\n");
			}
		}

	}

}


