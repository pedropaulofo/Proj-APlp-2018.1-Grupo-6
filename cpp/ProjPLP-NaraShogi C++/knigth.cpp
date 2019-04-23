#include "pch.h"

bool is_knight_move(board_pos origin, board_pos target, bool is_player1) {

	if(is_player1){
		if(origin.line_pos-2 == target.line_pos && (origin.column_pos+1==target.column_pos || origin.column_pos-1==target.column_pos )){
			return true;
		}
	}
	if(!is_player1){
		if(origin.line_pos+2 == target.line_pos && (origin.column_pos+1==target.column_pos || origin.column_pos-1==target.column_pos )){
			return true;
		}
	}

	return false;
}
