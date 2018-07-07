#include <iostream>
#include <string>
#include <map>
#include <set>
#include <algorithm>
#include <cstddef>         // std::size_t
using namespace std;

const int N = 6;
std::map<char, char> map_braces = {
                                    {
                                        '(', ')'
                                    },
                                    {
                                        '[', ']'
                                    },
                                    {
                                        '{', '}'
                                    }
                                };
std::set<char> set_opening = { '(', '{', '[' };
std::set<char> set_closing = { ')', '}', ']' };

string ex_one = "{ } [ ] ( )";
string ex_two = "{ )";
string ex_three = "{ ( } ) )";
string ex_four = "{";
string ex_five = "{ } { [ ( ) ] }";


/*
    select the first opening bracket
    find next closing bracket
    split the two string & validate each string
*/



bool is_opening(char b)
{
    return set_opening.count(b) > 0;
}

bool is_closing(char b)
{
    return set_closing.count(b) > 0;
}

bool check_validity(std::string str)
{
    if (str.length() == 0)
        return true;
    if (is_closing(str.front()) || is_opening(str.back()))
        return false;

    char b = str.front();
    unsigned int len = str.length();
    vector<size_t> v_pos;
    size_t pos = 0;
    while (pos != string::npos)
    {
        pos = str.find(map_braces[b]);
        if (pos != string::npos)
            v_pos.push_back(pos);
    }

    for (auto& pos : v_pos)
    {
        string str_one{""}, str_two{""};

        if (pos >= 2)
            str_one = str.substr(1, pos - 1);
        if (pos < len - 1)
            str_two = str.substr(pos + 1);
        if (check_validity(str_one) && check_validity(str_two))
            return true;
    }

    return false;
}

int main()
{
    ex_one.erase(remove_if(ex_one.begin(), ex_one.end(), [](unsigned char x){return std::isspace(x);}),
                    ex_one.end());
    ex_two.erase(remove_if(ex_two.begin(), ex_two.end(), [](unsigned char x){return std::isspace(x);}),
                    ex_two.end());
    ex_three.erase(remove_if(ex_three.begin(), ex_three.end(), [](unsigned char x){return std::isspace(x);}),
                    ex_three.end());
    ex_four.erase(remove_if(ex_four.begin(), ex_four.end(), [](unsigned char x){return std::isspace(x);}),
                    ex_four.end());
    ex_five.erase(remove_if(ex_five.begin(), ex_five.end(), [](unsigned char x){return std::isspace(x);}),
                    ex_five.end());

    cout << check_validity(ex_one) << endl
            << check_validity(ex_two) << endl
            << check_validity(ex_three) << endl
            << check_validity(ex_four) << endl
            << check_validity(ex_five) << endl;

    return 0;
}
