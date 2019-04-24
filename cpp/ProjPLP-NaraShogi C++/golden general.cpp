#include "pch.h"

bool is_goldeng_move(board_pos origin, board_pos target, bool is_player1) {

	bool is_player2 = !is_player1;

	if (!is_king_move) { // The Golden General can move to all directions that the King can
		return false;
	}

	//Now, knowing that the move is 1 cell distant from origin:

	if(is_player1){
		if (target.line_pos == origin.line_pos + 1 && target.column_pos != origin.column_pos) { // Golden General can't move to the diagonal cells behind it (line + 1 for Player 1)
			return false;
		}
		return true;
	}

	if(is_player2){
		if (target.line_pos == origin.line_pos - 1 && target.column_pos != origin.column_pos) { // Golden General can't move to the diagonal cells behind it (line - 1 for Player 2)
			return false;
		}
		return true;
	}

	return false; //unreacheanble case
}
