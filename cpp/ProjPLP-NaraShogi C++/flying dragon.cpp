#include "pch.h"

bool is_fdragon_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]) {
	return is_bishop_move(origin, target, players_map);
}

bool is_prom_fdragon_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]) {
	return is_prom_bishop_move(origin, target, players_map);
}