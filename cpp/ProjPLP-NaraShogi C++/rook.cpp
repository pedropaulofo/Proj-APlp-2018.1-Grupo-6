#include "pch.h"

bool is_rook_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]) {

	if (origin.line_pos != target.line_pos && origin.column_pos != target.column_pos) {
		return false; // Rook cannot go to positions on both different line or column from origin
	}

	int line_iterator = origin.line_pos;
	int column_iterator = origin.column_pos;
	int tar_l = target.line_pos;
	int tar_c = target.column_pos;

	// FALTA TRATAR AQUI SE HA PECAS NO CAMINHO  

	return false;
}

bool is_prom_rook_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]) {
	return is_king_move(origin, target) || is_rook_move(origin, target, players_map);
}