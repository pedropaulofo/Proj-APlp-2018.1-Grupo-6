#include "pch.h"
#include <iostream>
#include <string>

using namespace std;

int main()
{
	int difficulty;
	string difficulties[3] = { "Facil", "Media", "Dificil" };
	string jogador1, jogador2;

	cout << "Bem-vindo ao jogo Nara Shogi!\n" << endl;
	cout << "Escolha a dificuldade desejada\n" << endl;
	cout << "1 - Facil (tabuleiro 4 x 3)\n";
	cout << "2 - Medio (tabuleiro 9 x 9)\n";
	cout << "3 - Dificil (tabuleiro 13 x 13)\n" << endl;
	cin >> difficulty;

	cout << "\nDificuldade: " << difficulties[difficulty - 1] << endl;
	cout << "Nome do jogador 1: ";
	cin >> jogador1;
	cout << "Nome do jogador 2: ";
	cin >> jogador2;

}
