#include <string>

#ifndef PCH_H

#define PCH_H
#define BOARDSIZE 9 // USANDO, POR ENQUANTO, SEMPRE A DIFUCULDADE MEDIA (TABULEIRO 9X9)
#define PROMOTION_AREA1 2
#define PROMOTION_AREA2 6
#define EMPTYCELL '0'


typedef struct board_pos {
	int line_pos;
	int column_pos;
} board_pos;

void start_match(int tablesize, std::string player1, std::string player2);
bool is_pawn_move(board_pos origin, board_pos target, bool is_player1);
bool is_bishop_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]);
bool is_rook_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]);
bool is_lancer_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]);
bool is_knight_move(board_pos origin, board_pos target, bool is_player1);
bool is_silverg_move(board_pos origin, board_pos target, bool is_player1);
bool is_goldeng_move(board_pos origin, board_pos target, bool is_player1);
bool is_king_move(board_pos origin, board_pos target);

#endif //PCH_H
