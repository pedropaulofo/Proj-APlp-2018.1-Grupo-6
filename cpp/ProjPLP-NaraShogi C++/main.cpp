#include "pch.h"
#include "colors.h"
#include <iostream>
#include <string>

using namespace std;


void print_header() {
	printf(CLEAR_SCREEN);
	
	string header[11] = {
	"....................................................d8b..........................d8,",
	"....................................................?88.........................`8P.",
	".....................................................88b............................",
	".....................................................88b............................",
	"..88bd88b..d888b8b....88bd88b.d888b8b........d888b,..888888b..d8888b..d888b8b....88b",
	"  88P' ?8bd8P' ?88    88P'  `d8P' ?88       ?8b,     88P `?8bd8P' ?88d8P' ?88    88P",
	".d88...88P88b..,88b..d88.....88b..,88b........`?8b..d88...88P88b..d8888b..,88b..d88.",
	"d88'...88b`?88P'`88bd88'.....`?88P'`88b....`?888P'.d88'...88b`?8888P'`?88P'`88bd88'.",
	"............................................................................)88.....",
	"...........................................................................,88P.....",
	".......................................................................`?8888P......" };

	background(BLACK);
	printf("\n");
	for (int i = 0; i < 11; i++) {
		string line = header[i];
		for (int j = 0; j < line.length(); j++) {
			char c = header[i][j];
			if(c == '.') foreground(BLACK);
			else foreground(MARGENTA);
			printf("%c", header[i][j]);
		}
		printf("\n");
	}
	printf("\n");
	foreground(RED);
	printf("Type B for returning to main menu; C for closing the game.\n\n");
	style(RESETALL);
}

void check_command(string input);

void main_menu() {

	print_header();

	cout << "  > Welcome to shogi! Choose from the options below:\n\n" << endl;
	cout << "   1 - Start game\n";
	cout << "   2 - How to play\n";
	cout << "   3 - Shogi rules\n" << endl;

	string input;
	char choice;

	
	while (true) {
		cout << " > ";
		cin >> input;

		check_command(input);
		if (input.length() != 1) {
			cout << "Invalid option. Try again: \n";
			continue;
		}
		choice = input[0];
		switch (choice)
		{
		case '1':
			break;
		case '2':
			// FAZER AQUI A CHAMADA PRA VER COMO JOGAR
			continue;
		case '3':
			// FAZER AQUI A CHAMADA PRA VER AS REGRAS
			continue;
		default:
			cout << "Invalid option. Try again: \n";
			continue;
		}
		break;
	}
}

int get_difficulty() {

	print_header();

	string difficulty;

	cout << "  > Choose the difficulty below:\n\n" << endl;
	cout << "   1 - Easy (4 x 3 table)\n";
	cout << "   2 - Medium (9 x 9 table)\n";
	cout << "   3 - Hard (13 x 13 table)\n" << endl;

	while (true) {
		cout << " Difficulty: ";
		foreground(MARGENTA);
		cin >> difficulty;
		style(RESETALL);

		check_command(difficulty);

		if (difficulty == "2") break;
		else if (difficulty == "1" || difficulty == "3") cout << "\nUnimplemented yet. Try medium.\n";
		else cout << "\nInvalid entry, try again:\n";
	}
	return stoi(difficulty);
}

void get_players_names(int difficulty) {

	print_header();

	string player1, player2;
	string difficulties_text[3] = { "Easy", "Medium", "Hard" };

	cout << " Difficulty: ";
	foreground(MARGENTA);
	cout << difficulties_text[difficulty - 1] << "\n\n";
	style(RESETALL);
	cout << "  Player 1 name: ";
	foreground(CYAN);
	cin >> player1;
	check_command(player1);
	style(RESETALL);
	cout << "  Player 2 name: ";
	foreground(YELLOW);
	cin >> player2;
	check_command(player2);
	style(RESETALL);

	start_match(difficulty, player1, player2);
}

int main()
{
	//PARA AGILIZAR TESTES DURANTE O DESENVOLVIMENTO:
	//start_match(2, "Fulano", "Sicrano");
	//___________________________________



	main_menu();

	int difficulty = get_difficulty();
	
	get_players_names(difficulty);
}

void check_command(string input) {
	if (input.length() == 1) {
		char command = toupper(input[0]);

		switch (command) {
		case BACK:
			main();
		case CLOSE:
			exit(0);
		default:
			break;
		}
	}
}

