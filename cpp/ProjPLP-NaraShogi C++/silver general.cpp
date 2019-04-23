#include "pch.h"

bool is_silverg_move(board_pos origin, board_pos target, bool is_player1) {

	if(is_player1){
		if(origin.line_pos == target.line_pos)
			return false;
		if(origin.line_pos == target.line_pos+1 && 
		(origin.column_pos == target.column_pos || origin.column_pos == target.column_pos-1 || origin.column_pos == target.column_pos+1)){
			return true;
		}
		if(origin.line_pos == target.line_pos-1 && (origin.column_pos == target.column_pos-1 ||origin.column_pos == target.column_pos+1)){
			return true;
		}
		return false;
	}


	if(!is_player1){
		if(origin.line_pos == target.line_pos){
			return false;
		}
		if(origin.line_pos == target.line_pos-1 && 
		(origin.column_pos == target.column_pos || origin.column_pos == target.column_pos-1 || origin.column_pos == target.column_pos+1)){
			return true;
		}
		if(origin.line_pos == target.line_pos+1 && (origin.column_pos == target.column_pos-1 ||origin.column_pos == target.column_pos+1)){
			return true;
		}
		return false;
	}



}
