#include "pch.h"

//Bispo : Move-se apenas para as diagonais.

bool is_bishop_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]) {

	char identifier = players_map[origin.line_pos][origin.column_pos];

	int i = origin.column_pos; 
	int j = origin.line_pos;   
	int k = target.column_pos; 
	int l = target.line_pos; 

	while(i != k){
		if (i < k) i++;
		if (i > k) i--;
		if (j < l) j++;
		if (j > l) j--;

		if (players_map[j][i] == identifier) {
			return false; // FOUND OWN PLAYER'S PIECE ON THE WAY
		}
		else if (i != k && players_map[j][i] != EMPTYCELL) {
			return false; // OPONENT PIECE FOUND HALFWAY, INVALID MOVE,
		}
	}
	return j == target.line_pos; // TRUE if for X moves towards targeted LINE, it has moved X COLUMNS in the same direction 
}

