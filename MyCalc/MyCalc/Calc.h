#pragma once
#include <exception>

enum Operators
{
	ADD,
	SUBTRACT,
	MULTIPLY,
	DIVIDE
};

template <typename T1, typename T2, typename T3, typename T4>
class Calc
{
public:
	Calc(T1 operand1, T2 operand2, T3 oper);
	~Calc();

	T4 get_result();

private:
	T1 _operand1;
	T2 _operand2;
	Operators _oper;
};




template <typename T1, typename T2, typename T3, typename T4>
Calc<typename T1, typename T2, typename T3, typename T4>::Calc(T1 operand1, T2 operand2, T3 oper) : _operand1(operand1), _operand2(operand2)
{
	if (oper == ADD)
		_oper = ADD;
	else if (oper == SUBTRACT)
		_oper = SUBTRACT;
	else if (oper == MULTIPLY)
		_oper = MULTIPLY;
	else if (oper == DIVIDE)
		_oper = DIVIDE;
}

template <typename T1, typename T2, typename T3, typename T4>
Calc<typename T1, typename T2, typename T3, typename T4>::~Calc()
{
}

template <typename T1, typename T2, typename T3, typename T4>
T4 Calc<typename T1, typename T2, typename T3, typename T4>::get_result()
{
	const float ERROR = -1000000000000.0F;
	T4 ret_val;

	switch (_oper)
	{
	case ADD:
		ret_val = _operand1 + _operand2;
		break;

	case SUBTRACT:
		ret_val = _operand1 - _operand2;
		break;

	case MULTIPLY:
		ret_val = _operand1 * _operand2;
		break;

	case DIVIDE:
		try
		{
			ret_val = _operand1 / _operand2;
		}
		catch (std::exception ex)
		{
			// logging exception in here

			return ERROR;
		}
		break;

	default:
		break;
	}

	return ret_val;
}
