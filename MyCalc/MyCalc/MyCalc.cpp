// MyCalc.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <cstdio>
#include <iostream>
#include "Calc.h"

using namespace std;

int main()
{
	float operand1, operand2;
	int oper;
	
	cout << "Input the first operand: ";
	cin >> operand1;

	cout << "Input the second operand: ";
	cin >> operand2;

	cout << "Input the operator (0: ADD | 1: SUBTRACT | 2: MULTIPLY | 3: DIVIDE): ";
	cin >> oper;
	
	Calc<float, float, int, float> c(operand1, operand2, oper);
	cout << "Result: " << c.get_result() << std::endl;

	char ch;
	while (cin.readsome(&ch, 1) != 0)
		;

	cout << "Press any key to continue...\n";
	getchar();

    return 0;
}

