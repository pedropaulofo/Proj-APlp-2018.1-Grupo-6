#include "pch.h"
#include <iostream>
#include <string>

using namespace std;

int main()
{
	string difficulty, jogador1, jogador2;;
	string difficulties[3] = { "Easy", "Medium", "Hard" };

	cout << "---------------------------\n" << endl;
	cout << "   Welcome to Nara Shogi!  \n" << endl;
	cout << "---------------------------\n" << endl;
	cout << "Choose the difficulty below:\n" << endl;
	cout << "1 - Easy (4 x 3 table)\n";
	cout << "2 - Medium (9 x 9 table)\n";
	cout << "3 - Hard (13 x 13 table)\n" << endl;

	while (true) {
		cin >> difficulty;
		if (difficulty == "1" || difficulty == "2" || difficulty == "3") break;
		else cout << "\nInvalid entry, try again:\n";
	}


	cout << "\nDifficulty: " << difficulties[stoi(difficulty) - 1] << endl;
	cout << "\nPlayer 1 name: ";
	cin >> jogador1;
	cout << "Player 2 name: ";
	cin >> jogador2;

}