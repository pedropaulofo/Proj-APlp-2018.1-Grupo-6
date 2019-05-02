#include "pch.h"

bool is_rook_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_H][BOARDSIZE_H]) {

	if (origin.line_pos != target.line_pos && origin.column_pos != target.column_pos) {
		return false; // Rook cannot go to positions on both different line or column from origin
	}

	int line_iterator = origin.line_pos;
	int column_iterator = origin.column_pos;
	int tar_l = target.line_pos;
	int tar_c = target.column_pos;
	if(target.line_pos!=origin.line_pos && target.column_pos!=origin.column_pos){
		return false;
	}
		if(target.line_pos!=origin.line_pos){
			if(target.line_pos<origin.line_pos){
			for(int i = origin.line_pos-1; i > target.line_pos; i--){
				if(players_map[i][origin.column_pos] != NOPLAYER){
					return false;
				}
			}
			}else{
				for(int i = origin.line_pos+1; i < target.line_pos; i++){
					if(players_map[i][origin.column_pos] != NOPLAYER){
						return false;
					}
				}
			}
			return true;
			}
			if(target.column_pos!=origin.column_pos){
			if(target.column_pos<origin.column_pos){
			for(int i = origin.column_pos-1; i > target.column_pos; i--){
				if(players_map[origin.line_pos][i] != NOPLAYER){
					return false;
				}
			}
			}else{
				for(int i = origin.column_pos+1; i < target.column_pos; i++){
					if(players_map[origin.line_pos][i] != NOPLAYER){
						return false;
					}
				}
			}
			}
		return true;
	// FALTA TRATAR AQUI SE HA PECAS NO CAMINHO  
	return false;
}

bool is_prom_rook_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_H][BOARDSIZE_H]) {
	return is_king_move(origin, target) || is_rook_move(origin, target, players_map);
}