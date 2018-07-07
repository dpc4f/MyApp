#include <iostream>
#include <string>
#include <map>
#include <algorithm>
#include <cstddef>         // std::size_t
using namespace std;

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


string ex_one = "{ } [ ] ( )";
string ex_two = "{ )";
string ex_three = "{ ( } ) )";
string ex_four = "{";
string ex_five = "{ [ ( ) ] }";


bool is_valid(std::string str)
{
    size_t len = str.length();

    if (len == 0)
        return true;
    if (len == 2)
        return str[1] == map_braces[str[0]];

    // len > 2
    size_t pos = str.find_last_of(map_braces[str[0]]);
    if (pos != string::npos)
    {
        // split the string into 2 parts
        // and check syntax validity on each part
        string str_one{""}, str_two{""};

        if (pos >= 2)
            str_one = str.substr(1, pos - 1);
        if (pos < len - 1)
            str_two = str.substr(pos + 1);

        return is_valid(str_one) && is_valid(str_two);
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

    cout << is_valid(ex_one) << endl
            << is_valid(ex_two) << endl
            << is_valid(ex_three) << endl
            << is_valid(ex_four) << endl
            << is_valid(ex_five) << endl;

    return 0;
}
