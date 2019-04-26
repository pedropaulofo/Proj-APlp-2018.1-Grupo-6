#include "pch.h"

bool is_smover_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_H][BOARDSIZE_H]) {

	int or_l = origin.line_pos;
	int or_c = origin.column_pos;
	int tar_l = target.line_pos;
	int tar_c = target.column_pos;

	if (!is_gobetween_move(origin, target) && tar_l != or_l) {
		return false;
	}

	if (tar_c < or_c) {
		for (int i = or_c - 1; i > tar_c; i--) {
			if (players_map[or_l][i] != NOPLAYER) {
				return false;
			}
		}
	}
	else {
		for (int i = or_c + 1; i > tar_c; i++) {
			if (players_map[or_l][i] != NOPLAYER) {
				return false;
			}
		}
	}

	return true;
}

bool is_prom_smover_move(board_pos origin, board_pos target, bool is_player1) {
	return is_goldeng_move(origin, target, is_player1);
}
