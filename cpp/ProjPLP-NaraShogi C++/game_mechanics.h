#include <iostream>
#include <string>
#include <list>
#include <cstdio>
#include "pch.h"
#include "boards.h"

using namespace std;

#ifndef GAME_MECHANICS_H

bool player_turn;				//    true -> turn player1     false -> player2
int dif;

int get_board_linesize(int dif){
	switch(dif){
		case EASY:
			return BOARDLINES_E;
		case MEDIUM:
			return BOARDSIZE_M;
		case HARD:
			return BOARDSIZE_H;
	}
}

int get_board_columnsize(int dif){
	switch (dif) {
	case EASY:
		return BOARDCOLUMNS_E;
	case MEDIUM:
		return BOARDSIZE_M;
	case HARD:
		return BOARDSIZE_H;
	}
}


list<char> p1_captured_pcs;
list<char> p2_captured_pcs;

char display_board[DISPLAY_LINES_H][DISPLAY_COLUMNS_H];
char pieces_map[BOARDSIZE_H][BOARDSIZE_H];
char players_map[BOARDSIZE_H][BOARDSIZE_H];
board_pos transf_matrix[BOARDSIZE_H][BOARDSIZE_H]; 


template <typename T>
bool contains(std::list<T> & listOfElements, const T & element)
{
	auto it = std::find(listOfElements.begin(), listOfElements.end(), element);
	return it != listOfElements.end();
}

void switch_turn() {
	player_turn = !player_turn;
}

bool is_player1_turn() {
	return player_turn;
}

bool is_player2_turn() {
	return !player_turn;
}

void wait_confirmation() {
	string wait;
	cin >> wait;
}

void resetMaps() {
	int display_lines, display_columns;
	if (dif == EASY) {
		display_lines = DISPLAY_LINES_E;
		display_columns = DISPLAY_COLUMNS_E;
	}
	else if (dif == MEDIUM) {
		display_lines = DISPLAY_LINES_M;
		display_columns = DISPLAY_COLUMNS_M;
	}
	else {
		display_lines = DISPLAY_LINES_H;
		display_columns = DISPLAY_COLUMNS_H;
	}

	for (int i = 0; i < display_lines; i++) {
		for (int j = 0; j < display_columns; j++) {
			switch (dif) {
			case EASY:
				display_board[i][j] = display_board_EASY[i][j];
				break;
			case MEDIUM:
				display_board[i][j] = display_board_MEDIUM[i][j];
				break;
			case HARD:
				display_board[i][j] = display_board_HARD[i][j];
				break;
			}
		}

		for (int i = 0; i < get_board_linesize(dif); i++) {
			for (int j = 0; j < get_board_columnsize(dif); j++) {
				switch (dif) {
				case EASY:
					players_map[i][j] = players_map_EASY[i][j];
					pieces_map[i][j] = pieces_map_EASY[i][j];
					transf_matrix[i][j] = transf_matrix_EASY[i][j];
					break;
				case MEDIUM:
					players_map[i][j] = players_map_MEDIUM[i][j];
					pieces_map[i][j] = pieces_map_MEDIUM[i][j];
					transf_matrix[i][j] = transf_matrix_MEDIUM[i][j];
					break;
				case HARD:
					players_map[i][j] = players_map_HARD[i][j];
					pieces_map[i][j] = pieces_map_HARD[i][j];
					transf_matrix[i][j] = transf_matrix_HARD[i][j];
					break;
				}
			}
		}

	}
}

bool coordinate_isvalid(string input) {
	if (input.length() != 2) return false; // input must follow the model LetterNumber, ex: A0, G2, B5
	int line = int(toupper(input[0]));
	int column = int(input[1]);

	char limit;
	switch (dif) {
	case EASY:
		limit = 'D';
		break;
	case MEDIUM:
		limit = 'I';
		break;
	case HARD:
		limit = 'M';
		break;
	}

	if (line < int('A') || line > int('M')) return false;
	if (column < int('0') || column > int('13')) return false;

	return true;
}

bool is_from_player(board_pos pos, bool checking_player1) {
	int line = pos.line_pos;
	int column = pos.column_pos;

	return (players_map[line][column] == P1_IDENTIFER && checking_player1) || (players_map[line][column] == P2_IDENTIFER && !checking_player1);
}

char move(board_pos origin, board_pos target) {
	int ori_line = origin.line_pos; //origin line
	int ori_col = origin.column_pos;//origin column
	int tar_line = target.line_pos; //target line
	int tar_col = target.column_pos;//target colunn

	char overrid_cell_content = pieces_map[tar_line][tar_col];

	pieces_map[tar_line][tar_col] = pieces_map[ori_line][ori_col];	// sets the selected piece to the targeted cell
	pieces_map[ori_line][ori_col] = BLANK_CELL;							// clears the cell where the pieces was before moving
	players_map[tar_line][tar_col] = players_map[ori_line][ori_col];// sets the targeted cell as having one of the player's piece
	players_map[ori_line][ori_col] = NOPLAYER;							// sets the origin to have no player piece on it						// sets the origin to have no player piece on it

	if (is_player1_turn() && overrid_cell_content != BLANK_CELL) {
		p1_captured_pcs.push_back(overrid_cell_content);
	}
	else if (is_player2_turn() && overrid_cell_content != BLANK_CELL) {
		p2_captured_pcs.push_back(overrid_cell_content);
	}

	switch_turn();							// SWITCHES TURNS

	return overrid_cell_content;
}

bool is_legal_move(char piece_type, board_pos origin, board_pos target) {
	switch (piece_type)
	{
	case PAWN:
		return is_pawn_move(origin, target, player_turn);
	case BISHOP:
		return (dif != 1) ? is_bishop_move(origin, target, players_map) : is_bishop_move(origin, target, players_map) && is_king_move(origin, target);
	case ROOK:
		return (dif != 1) ? is_rook_move(origin, target, players_map) : is_rook_move(origin, target, players_map) && is_king_move(origin, target);
	case LANCER:
		return is_lancer_move(origin, target, players_map);
	case KNIGHT:
		return is_knight_move(origin, target, player_turn);
	case SILVERGENERAL:
		return is_silverg_move(origin, target, player_turn);
	case GOLDENGENERAL:
		return is_goldeng_move(origin, target, player_turn);
	case KING:
		return is_king_move(origin, target);
	case PROMOTEDPAWN:
		return is_prom_pawn_move(origin, target, player_turn);
	case PROMOTEDBISHOP:
		return is_prom_bishop_move(origin, target, players_map);
	case PROMOTEDROOK:
		return is_prom_rook_move(origin, target, players_map);
	case PROMOTEDKNIGHT:
		return is_prom_knight_move(origin, target, player_turn);
	case PROMOTEDSILVERGENERAL:
		return is_prom_silverg_move(origin, target, player_turn);
	default:
		return false;
	}
	return false;
}

void check_and_promote(board_pos destino) {
	
	char player = players_map[destino.line_pos][destino.column_pos];
	
	if (dif == EASY && pieces_map[destino.line_pos][destino.column_pos] != PAWN) return;

	if (player == P1_IDENTIFER) {
		if (destino.line_pos <= PROMOTION_AREA1_M) {
			pieces_map[destino.line_pos][destino.column_pos] = toupper(pieces_map[destino.line_pos][destino.column_pos]);
		}
	}
	else if (player == P2_IDENTIFER) {
		if (destino.line_pos >= PROMOTION_AREA2_M) {
			pieces_map[destino.line_pos][destino.column_pos] = toupper(pieces_map[destino.line_pos][destino.column_pos]);
		}
	}

}

bool drop(list<char> captured, board_pos cell) {

	if (!captured.empty()) {
		char answer;
		std::cout << "Blank cell selected. Do you wish to drop a captured Piece? (Y/N): ";
		std::cin >> answer;

		if (toupper(answer) == 'Y') {
			char piece;
			std::cout << "What piece do you wish to DROP on the selected postion? (Ex: p): ";
			std::cin >> piece;

			char player = is_player1_turn() ? P1_IDENTIFER : P2_IDENTIFER;
			
			int prohibited_line = is_player1_turn() ? 0 : get_board_linesize(dif)-1;
			if ((piece == PAWN || piece == LANCER || piece == KNIGHT) && cell.line_pos == prohibited_line) {  // Pieces that cannot be placed on the opponent first row
				foreground(RED);
				printf("This piece cannot be placed on the extreme opposite line.\n");
				wait_confirmation();
				return false;
			}
			else if (piece == PAWN) {
				for (int i = 0; i < get_board_linesize(dif); i++) {
					if (pieces_map[i][cell.column_pos] == PAWN && players_map[i][cell.column_pos] == player) {
						foreground(RED);
						printf("The Pawn cannot be dropped on the column that contains one of the same player's Pawn.\n");
						wait_confirmation();
						return false;
					}
				}
			}

			if (contains(captured, piece)) { // If has the captured piece
				pieces_map[cell.line_pos][cell.column_pos] = piece;
				players_map[cell.line_pos][cell.column_pos] = player;
				
				is_player1_turn() ? p1_captured_pcs.remove(piece) : p2_captured_pcs.remove(piece);
				switch_turn();
				return false;
			}
			else{
				foreground(RED);
				printf("The player doesn't have this piece captured.\n");
				wait_confirmation();
				return false;
			}
		}
	}
	else {
		foreground(RED);
		printf("The player doesn't have any piece captured. Enter any key to continue: \n");
		wait_confirmation();
	}

	style(RESETALL);
	return false;
}

#endif
