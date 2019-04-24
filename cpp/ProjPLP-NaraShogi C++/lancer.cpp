#include "pch.h"

bool is_lancer_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]) {
	if (origin.column_pos != target.column_pos) {
		return false;
	}
	if(players_map[origin.line_pos][origin.column_pos] == P1_IDENTIFER){
		if(target.line_pos>origin.line_pos){
			return false;
		}
		for(int i = origin.line_pos-1; i > target.line_pos; i--){
			if(players_map[i][origin.column_pos] != NOPLAYER){
				return false;
			}
		}

		return true;
	}
	if(players_map[origin.line_pos][origin.column_pos] == P2_IDENTIFER){
		if(target.line_pos<origin.line_pos){
			return false;
		}
		for(int i = origin.line_pos+1; i < target.line_pos; i++){
			if(players_map[i][origin.column_pos] != NOPLAYER){
				return false;
			}
		}
		return true;
	}
	return true;
}

bool is_prom_lancer_move(board_pos origin, board_pos target, bool is_player1) {
	return is_goldeng_move(origin, target, is_player1);
}