#include "pch.h"
#include <iostream>
#include <string>

using namespace std;

#define CLEAR_SCREEN "\033[2J\033[1;1H"

void print_header() {
	cout << "---------------------------\n" << endl;
	cout << "   Welcome to Nara Shogi!  \n" << endl;
	cout << "---------------------------\n" << endl;
}

int main()
{
	//PARA AGILIZAR TESTES DURANTE O DESENVOLVIMENTO:
	start_match(2, "Fulano", "Sicrano");
	//___________________________________


	string difficulty, player1, player2;
	string difficulties[3] = { "Easy", "Medium", "Hard" };

	print_header();
	cout << "Choose the difficulty below:\n" << endl;
	cout << "1 - Easy (4 x 3 table)\n";
	cout << "2 - Medium (9 x 9 table)\n";
	cout << "3 - Hard (13 x 13 table)\n" << endl;

	while (true) {
		cin >> difficulty;
		if (difficulty == "2") break;
		else if (difficulty == "1" || difficulty == "3") cout << "\nUnimplemented yet. Try medium.\n";
		else cout << "\nInvalid entry, try again:\n";
	}

	int dif = stoi(difficulty);
	printf(CLEAR_SCREEN);
	print_header();
	cout << "Difficulty: " << difficulties[dif - 1] << endl;
	cout << "\nPlayer 1 name: ";
	cin >> player1;
	cout << "Player 2 name: ";
	cin >> player2;

	
	start_match(dif, player1, player2);

}

