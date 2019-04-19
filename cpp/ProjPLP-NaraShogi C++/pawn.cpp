#include "pch.h"

//Peão : Move-se apenas uma casa para frente.

bool is_pawn_move(board_pos origin, board_pos target, bool is_player1) {

	if (is_player1 && (origin.column_pos != target.column_pos || origin.line_pos - 1 != target.line_pos)) {
		return false;
	}
	else if (!is_player1 && (origin.column_pos != target.column_pos || origin.line_pos + 1 != target.line_pos)) {
		return false;
	}
	return true;
}


