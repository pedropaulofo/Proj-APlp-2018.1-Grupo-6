// Dicas para Começar: 
//   1. Use a janela do Gerenciador de Soluções para adicionar/gerenciar arquivos
//   2. Use a janela do Team Explorer para conectar-se ao controle do código-fonte
//   3. Use a janela de Saída para ver mensagens de saída do build e outras mensagens
//   4. Use a janela Lista de Erros para exibir erros
//   5. Ir Para o Projeto > Adicionar Novo Item para criar novos arquivos de código, ou Projeto > Adicionar Item Existente para adicionar arquivos de código existentes ao projeto
//   6. No futuro, para abrir este projeto novamente, vá para Arquivo > Abrir > Projeto e selecione o arquivo. sln

#include <string>
#ifndef PCH_H
#define PCH_H
#define BOARDSIZE 9 // USANDO, POR ENQUANTO, SEMPRE A DIFUCULDADE MEDIA (TABULEIRO 9X9)


typedef struct board_pos {
	int line_pos;
	int column_pos;
} board_pos;

void start_match(int tablesize, std::string player1, std::string player2);
void print_header();
void print_board(char board[9][9]);
void update_display_board(char board[9][9]);
bool is_pawn_move(board_pos origin, board_pos target, char playerboard[BOARDSIZE][BOARDSIZE]);

#endif //PCH_H
