#include "pch.h"
#include <stdio.h>

//Peão : Move-se apenas uma casa para frente.

bool is_pawn_move(board_pos origin, board_pos target, char playerboard[BOARDSIZE][BOARDSIZE]) {
	//player true = player2
	if (playerboard[target.line_pos][target.column_pos] == playerboard[origin.line_pos][origin.column_pos]) {
		printf("Nao pode comer peca propria");
		return false;
	}
	if (playerboard[origin.line_pos][origin.column_pos] == '1') {
		if (origin.column_pos != target.column_pos || origin.line_pos - 1 != target.line_pos) {
			printf("invalido jog 1");
			return false;
		}
	}

	if (playerboard[origin.line_pos][origin.column_pos] == '2') {
		if (origin.column_pos != target.column_pos || origin.line_pos + 1 != target.line_pos) {
			printf("invalido jog 2");
			return false;
		}
	}
	return true;
}


