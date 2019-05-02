#include "pch.h"

bool is_silverg_move(board_pos origin, board_pos target, bool is_player1) {

	bool is_player2 = !is_player1;

	int or_l = origin.line_pos;
	int or_c = origin.column_pos;
	int tar_l = target.line_pos;
	int tar_c = target.column_pos;

	if (!is_king_move) { // The Silver General can move to all directions that the King can
		return false;
	}

	//Now, knowing that the move is 1 cell distant from origin:

	if (is_player1) {
		if (tar_l == or_l  || (tar_l == or_l + 1 && tar_c == or_c)) { // Silver General can't move to the sides nor behind it (line + 1 for Player 1)
			return false;
		}
		else return true;
	}

	if (is_player2) {
		if (tar_l == or_l || (tar_l == or_l - 1 && tar_c == or_c)) { // Silver General can't move to the sides nor behind it (line - 1 for Player 2)
			return false;
		}
		else return true;
	}

	return false; //unreacheable case
}

bool is_prom_silverg_move(board_pos origin, board_pos target, bool is_player1) {
	return is_goldeng_move(origin, target, is_player1);
}
