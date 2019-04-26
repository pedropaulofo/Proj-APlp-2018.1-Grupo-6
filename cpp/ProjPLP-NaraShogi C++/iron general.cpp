#include "pch.h"

bool is_ironrg_move(board_pos origin, board_pos target, bool is_player1) {

	bool is_player2 = !is_player1;

	int or_l = origin.line_pos;
	int or_c = origin.column_pos;
	int tar_l = target.line_pos;
	int tar_c = target.column_pos;

	if (!is_king_move(origin, target)) {
		return false;
	}

	if (is_player1) {
		if (tar_l != or_l - 1) {
			return false;
		}
		else return true;
	}

	if (is_player2) {
		if (tar_l != or_l + 1) {
			return false;
		}
		else return true;
	}

	return false; //unreacheable case
}

bool is_prom_irong_move(board_pos origin, board_pos target, bool is_player1) {
	return is_goldeng_move(origin, target, is_player1);
}
