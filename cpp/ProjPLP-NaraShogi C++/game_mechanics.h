#include <iostream>
#include <string>
#include <list>
#include <cstdio>
#include "pch.h"
#include "boards.h"

using namespace std;

#ifndef GAME_MECHANICS_H

bool player_turn;				//    true -> turn player1     false -> player2
int dif= 2;

int get_board_linesize(int dif){
	switch(dif){
		case 1:
			return 3;
		case 2:
			return 9;
		case 3:
			return 13;
		default:
			return 9;
	}
}

int get_board_columnsize(int dif){
	switch(dif){
		case 1:
			return 4;
		case 2:
			return 9;
		case 3:
			return 13;
		default:
			return 9;
	}
}


list<char> p1_captured_pcs;
list<char> p2_captured_pcs;

char display_board[39][59];
char pieces_map[BOARDSIZE][BOARDSIZE];
char players_map[BOARDSIZE][BOARDSIZE];
board_pos transf_matrix[BOARDSIZE][BOARDSIZE]; 

void resetMaps(){
	int lines, columns;
	if(dif == 1){
		lines = 18;
		columns = 23;
	}
	else{
		lines = 39;
		columns = 59;
	}

	for(int i = 0; i< lines; i++){
		for(int j = 0; j< columns; j++){
			switch(dif){
				case 1:
				display_board[i][j] = display_board_EASY[i][j];
				break;
				case 2:
				display_board[i][j] = display_board_medium[i][j];
				break;
				default:
				display_board[i][j] = display_board_medium[i][j];
				break;
			}
		}
	}

	for(int i = 0; i< get_board_linesize(dif); i++){
		for(int j = 0; j< get_board_columnsize(dif); j++){
			switch(dif){
				case 1:
					players_map[i][j] = players_map_EASY[i][j];
					pieces_map[i][j] = pieces_map_EASY[i][j];
					transf_matrix[i][j] = transf_matrix_EASY[i][j];
					break;
				case 2:
					players_map[i][j] = players_map_medium[i][j];
					pieces_map[i][j] = pieces_map_medium[i][j];
					transf_matrix[i][j] = transf_matrix_MEDIUM[i][j];
					break;
				default:
					players_map[i][j] = players_map_medium[i][j];
					pieces_map[i][j] = pieces_map_medium[i][j];
					transf_matrix[i][j] = transf_matrix_MEDIUM[i][j];
					break;
			}
		}
	}
	
}

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

bool coordinate_isvalid(string input) {
	if (input.length() != 2) return false; // input must follow the model LetterNumber, ex: A0, G2, B5
	int line = int(toupper(input[0]));
	int column = int(input[1]);
	if (line < int('A') || line > int('I')) return false;
	if (column < int('0') || column > int('8')) return false;

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
		return is_bishop_move(origin, target, players_map);
	case ROOK:
		return is_rook_move(origin, target, players_map);
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

	if (player == P1_IDENTIFER) {
		if (destino.line_pos <= PROMOTION_AREA1) {
			pieces_map[destino.line_pos][destino.column_pos] = toupper(pieces_map[destino.line_pos][destino.column_pos]);
		}
	}
	else if (player == P2_IDENTIFER) {
		if (destino.line_pos >= PROMOTION_AREA2) {
			pieces_map[destino.line_pos][destino.column_pos] = toupper(pieces_map[destino.line_pos][destino.column_pos]);
		}
	}

}

bool try_dropping(list<char> captured, board_pos cell) {

	if (!captured.empty()) {

		char answer;
		std::cout << "Blank cell selected. Do you wish to drop a captured Piece? (Y/N): ";
		std::cin >> answer;

		if (toupper(answer) == 'Y') {
			char piece;
			std::cout << "What piece do you wish to DROP on the selected postion? (Ex: p): ";
			std::cin >> piece;
			

			if (contains(captured, piece)) { // If has the captured piece
				char player = is_player1_turn() ? P1_IDENTIFER : P2_IDENTIFER;

				pieces_map[cell.line_pos][cell.column_pos] = piece;
				players_map[cell.line_pos][cell.column_pos] = player;
				
				is_player1_turn() ? p1_captured_pcs.remove(piece) : p2_captured_pcs.remove(piece);
				switch_turn();
				return false;
			}
			else{
				foreground(RED);
				printf("The player doesn't have this piece captured.\n");
			}
		}
	}
	else {
		foreground(RED);
		printf("The player doesn't have any piece captured. Enter any key to continue: \n");
		string wait;
		cin >> wait;
	}

	style(RESETALL);
	return false;
}

#endif
