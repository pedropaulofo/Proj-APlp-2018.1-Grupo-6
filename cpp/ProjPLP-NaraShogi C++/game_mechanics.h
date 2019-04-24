#include <iostream>
#include <string>
#include <cstdio>
#include "pch.h"

using namespace std;

#ifndef GAME_MECHANICS_H

bool player_turn = true;				//    true -> turn player1     false -> player2

void switch_turn() {
	player_turn = !player_turn;
}

bool is_player1_turn() {
	return player_turn;
}

bool is_player2_turn() {
	return !player_turn;
}

bool coordinate_isvalid(string input) {
	if (input.length() != 2) return false; // input must follow the model LetterNumber, ex: A0, G2, B5
	int line = int(toupper(input[0]));
	int column = int(input[1]);
	if (line < int('A') || line > int('I')) return false;
	if (column < int('0') || column > int('8')) return false;

	return true;
}

bool is_from_player(board_pos pos, bool checking_player1) {
	int line = pos.line_pos;
	int column = pos.column_pos;

	return (players_map[line][column] == P1_IDENTIFER && checking_player1) || (players_map[line][column] == P2_IDENTIFER && !checking_player1);
}

char move(board_pos origin, board_pos target) {
	int ori_line = origin.line_pos; //origin line
	int ori_col = origin.column_pos;//origin column
	int tar_line = target.line_pos; //target line
	int tar_col = target.column_pos;//target colunn

	char overrid_cell_content = pieces_map[tar_line][tar_col];

	pieces_map[tar_line][tar_col] = pieces_map[ori_line][ori_col];	// sets the selected piece to the targeted cell
	pieces_map[ori_line][ori_col] = BLANK_CELL;							// clears the cell where the pieces was before moving
	players_map[tar_line][tar_col] = players_map[ori_line][ori_col];// sets the targeted cell as having one of the player's piece
	players_map[ori_line][ori_col] = NOPLAYER;							// sets the origin to have no player piece on it						// sets the origin to have no player piece on it

	return overrid_cell_content;
}

bool is_legal_move(char piece_type, board_pos origin, board_pos target) {
	switch (piece_type)
	{
	case PAWN:
		return is_pawn_move(origin, target, player_turn);
	case BISHOP:
		return is_bishop_move(origin, target, players_map);
	case ROOK:
		return is_rook_move(origin, target, players_map);
	case LANCER:
		return is_lancer_move(origin, target, players_map);
	case KNIGHT:
		return is_knight_move(origin, target, player_turn);
	case SILVERGENERAL:
		return is_silverg_move(origin, target, player_turn);
	case GOLDENGENERAL:
		return is_goldeng_move(origin, target, player_turn);
	case KING:
		return is_king_move(origin, target);
	case PROMOTEDPAWN:
		return false;
	case PROMOTEDBISHOP:
		return is_prom_bishop_move(origin, target, players_map);
	case PROMOTEDROOK:
		return false;
	case PROMOTEDKNIGHT:
		return false;
	case PROMOTEDSILVERGENERAL:
		return false;
	default:
		return false;
	}
	return false;
}

void check_and_promote(board_pos destino) {
	char player = players_map[destino.line_pos][destino.column_pos];

	if (player == P1_IDENTIFER) {
		if (destino.line_pos <= PROMOTION_AREA1) {
			pieces_map[destino.line_pos][destino.column_pos] = toupper(pieces_map[destino.line_pos][destino.column_pos]);
		}
	}
	else if (player == P2_IDENTIFER) {
		if (destino.line_pos >= PROMOTION_AREA2) {
			pieces_map[destino.line_pos][destino.column_pos] = toupper(pieces_map[destino.line_pos][destino.column_pos]);
		}
	}

}

#endif
