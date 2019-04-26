#include "pch.h"

//Bispo : Move-se apenas para as diagonais.

bool is_bishop_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_H][BOARDSIZE_H]) {

	if (origin.line_pos == target.line_pos || origin.column_pos == target.column_pos) {
		return false; // Bishop cannot go to positions on the same line or column
	}

	int line_iterator = origin.line_pos;
	int column_iterator = origin.column_pos; 
	int tar_l = target.line_pos;
	int tar_c = target.column_pos; 

	while(column_iterator != tar_c){
		if (column_iterator < tar_c) column_iterator++;
		if (column_iterator > tar_c) column_iterator--;
		if (line_iterator < tar_l) line_iterator++;
		if (line_iterator > tar_l) line_iterator--;

		if (column_iterator != tar_c && players_map[line_iterator][column_iterator] != NOPLAYER) {
			return false; // PIECE FOUND HALFWAY, INVALID MOVE,
		}
	}
	return line_iterator == target.line_pos; // TRUE if for X moves towards targeted LINE, it has moved X COLUMNS in the same direction 
}

bool is_prom_bishop_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_H][BOARDSIZE_H]) {
	return is_king_move(origin, target) || is_bishop_move(origin, target, players_map); // Promoted Bishop can do both king moves and bishop moves
}

