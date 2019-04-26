#include "pch.h"

bool is_gobetween_move(board_pos origin, board_pos target) {

	int or_l = origin.line_pos;
	int or_c = origin.column_pos;
	int tar_l = target.line_pos;
	int tar_c = target.column_pos;

	if (!is_king_move(origin, target)) {
		return false;
	}

	if (tar_c != or_c) { //Moves 1 space only in the same column
		return false;
	}
	else return true;
}

bool is_prom_gobewtween_move(board_pos origin, board_pos target, bool is_player1) {
	return is_goldeng_move(origin, target, is_player1);
}
