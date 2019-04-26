#include <string>

#ifndef PCH_H

#define PCH_H

#define EASY 1
#define MEDIUM 2
#define HARD 3

#define BOARDLINES_E	4		// EASY
#define BOARDCOLUMNS_E	3
#define BOARDSIZE_M		9		// MEDIUM
#define BOARDSIZE_H		13		// HARD

#define DISPLAY_LINES_E 19
#define DISPLAY_COLUMNS_E 23
#define DISPLAY_LINES_M 39
#define DISPLAY_COLUMNS_M 59
#define DISPLAY_LINES_H 67
#define DISPLAY_COLUMNS_H 85

#define PROMOTION_AREA1_M 2
#define PROMOTION_AREA2_M 6

#define CLEAR_SCREEN "\033[2J\033[1;1H"

#define BASE_ASCII_SUBT_LINE  65
#define BASE_ASCII_SUBT_COLUMN 48

#define HIGHLIGHT_CHAR '/'
#define BLANK_CELL '_'

#define NOPLAYER '0'
#define P1_IDENTIFER '1'
#define P2_IDENTIFER '2'

#define BACK 'B'
#define RESET 'R'
#define HELP 'H'
#define CLOSE 'C'
#define DROP 'D'

#define NO_COMMAND 0
#define RETRY 1
#define EXIT 2

// Pieces identifiers
#define PAWN 'p'
#define BISHOP 'b'
#define ROOK 'r'
#define LANCER 'l'
#define KNIGHT 'n'
#define SILVERGENERAL 's'
#define GOLDENGENERAL 'G'
#define KING 'K'
#define PROMOTEDPAWN 'P'
#define PROMOTEDBISHOP 'B'
#define PROMOTEDROOK 'R'
#define PROMOTEDLANCER 'N'
#define PROMOTEDKNIGHT 'N'
#define PROMOTEDSILVERGENERAL 'S'

// Pieces identifiers hai shogi
#define FLYINGDRAGON 'd'
#define FIERCETIGER 't'
#define FREECHARIOT 'f'
#define GOBETWEEN 'w'
#define IRONGENERAL 'i'
#define COPPERGENERAL 'c'
#define SIDEMOVER 'm'
#define PROMOTEDFLYINGDRAGON 'F'
#define PROMOTEDFIERCETIGER 'T'
#define PROMOTEDFREECHARIOT 'F'
#define PROMOTEDGOBETWEEN 'W'
#define PROMOTEDIRONGENERAL 'I'
#define PROMOTEDCOPPERGENERAL 'C'
#define PROMOTEDSIDEMOVER 'M'

using namespace std;

typedef struct board_pos {
	int line_pos = -1;
	int column_pos = -1;
} board_pos;

bool coordinate_isvalid(std::string input);
void start_match(int tablesize, std::string player1, std::string player2);
int main();


// STANDARD PIECES:

bool is_pawn_move(board_pos origin, board_pos target, bool is_player1);
bool is_bishop_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]);
bool is_rook_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]);
bool is_lancer_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]);
bool is_knight_move(board_pos origin, board_pos target, bool is_player1);
bool is_silverg_move(board_pos origin, board_pos target, bool is_player1);
bool is_goldeng_move(board_pos origin, board_pos target, bool is_player1);
bool is_king_move(board_pos origin, board_pos target);

// PROMOTED PIECES:

bool is_prom_pawn_move(board_pos origin, board_pos target, bool is_player1);
bool is_prom_bishop_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]);
bool is_prom_rook_move(board_pos origin, board_pos target, char players_map[BOARDSIZE_M][BOARDSIZE_M]);
bool is_prom_lancer_move(board_pos origin, board_pos target, bool is_player1);
bool is_prom_knight_move(board_pos origin, board_pos target, bool is_player1);
bool is_prom_silverg_move(board_pos origin, board_pos target, bool is_player1);


//heian dai shogi
bool is_gobetween_move(board_pos origin, board_pos target);


#endif //PCH_H
