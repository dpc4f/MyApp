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
string ex_two = "{ } { [ ( ) ] } { { { ( ( ( [ ( ) ] ) ) ) } [ ( ) [ { } ] } }";
string ex_three = "{ (  ) } ( ) ( [ { } ] )";
string ex_four = "{";
string ex_five = "{ } { [ ( ) ] } { { { ( ( ( [ ( ) ] ) ) ) } ( ) [ { } ] } }";


/*
    0. if the string is empty it is valid
    1. select the first opening bracket, which is also the first character of the string
    2. find next closet closing bracket at position pos
    3. split the two strings & validate each string
        3.1. if they are invalid, repeat step 2 with another next closest closing bracket
        3.2. if they are valid, return true
    4. return false (all cases are invalid)
*/

bool is_opening(const char &);
bool is_closing(const char &);
bool check_validity(const std::string&);

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


bool is_opening(const char& b)
{
    return set_opening.count(b) > 0;
}

bool is_closing(const char& b)
{
    return set_closing.count(b) > 0;
}

bool check_validity(const std::string& str)
{
    if ( str.length() == 0 || (str.length() == 2 && str[1] == map_braces[str[0]]) )
            return true;

    if (is_closing(str.front()) || is_opening(str.back()))
        return false;

    const auto& b = str.front();
    unsigned int len = str.length();
    vector<size_t> v_pos;
    size_t pos = std::string::npos;
    do
    {
        pos = str.find(map_braces[b], pos+1);
        if (pos == string::npos)
            break;
        v_pos.push_back(pos);
    }
    while (true);

    for (auto& pos : v_pos)
    {
        string str_one{""}, str_two{""};

        if (pos >= 2)
            str_one = str.substr(1, pos - 1);
        if (pos < len - 1)
            str_two = str.substr(pos + 1);
        if ( (check_validity(str_one) && check_validity(str_two)) == true )
            return true;
    }

    return false;
}
