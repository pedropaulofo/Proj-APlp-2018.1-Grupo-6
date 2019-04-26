#include "pch.h"

bool is_fchariot_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]) {

	int or_l = origin.line_pos;
	int or_c = origin.column_pos;
	int tar_l = target.line_pos;
	int tar_c = target.column_pos;

	if (tar_c != or_c) {
		return false;
	}
	if (tar_l < or_l) {
		for (int i = or_l - 1; i > tar_l; i--) {
			if (players_map[i][or_c] != NOPLAYER) {
				return false;
			}
		}
	}
	else {
		for (int i = or_l + 1; i > tar_l; i++) {
			if (players_map[i][or_c] != NOPLAYER) {
				return false;
			}
		}
	}

	return true;
}

bool is_prom_fchariot_move(board_pos origin, board_pos target, bool is_player1) {
	return is_goldeng_move(origin, target, is_player1);
}
