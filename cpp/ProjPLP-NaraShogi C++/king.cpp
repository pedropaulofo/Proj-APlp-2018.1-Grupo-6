#include "pch.h"

bool is_king_move(board_pos origin, board_pos target) {
	int ori_line, ori_col, tar_line, tar_col;
	ori_line = origin.line_pos;
	ori_col = origin.column_pos;
	tar_line = target.line_pos;
	tar_col = target.column_pos;

	return abs(ori_line - tar_line) <= 1 && abs(ori_col - tar_col) <= 1;
}