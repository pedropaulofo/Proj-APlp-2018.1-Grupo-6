#include <string>

#ifndef PCH_H

#define PCH_H
#define BOARDSIZE 9 // USANDO, POR ENQUANTO, SEMPRE A DIFUCULDADE MEDIA (TABULEIRO 9X9)
#define EMPTYCELL '0'


typedef struct board_pos {
	int line_pos;
	int column_pos;
} board_pos;

void start_match(int tablesize, std::string player1, std::string player2);
void print_header();
void print_board(char board[9][9]);
void update_display_board(char board[9][9]);
bool is_pawn_move(board_pos origin, board_pos target, bool is_player1);
bool is_bishop_move(board_pos origin, board_pos target, char players_map[BOARDSIZE][BOARDSIZE]);

#endif //PCH_H
