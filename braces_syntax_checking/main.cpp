#include <iostream>
#include <string>
#include <map>
#include <set>
#include <vector>
#include <algorithm>
#include <fstream>
#include <sstream>
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
std::set<char> set_opening = { '(', '{', '[' };
std::set<char> set_closing = { ')', '}', ']' };
std::vector<string> v_evaluate;
std::vector<bool> v_result;

/*
    0. if the string is empty it is valid
    1. select the first opening bracket, which is also the first character of the string
    2. find closet closing bracket
    3. split the two strings & validate each string
        3.1. if they are invalid, repeat step 2 with another next closest closing bracket
        3.2. if they are valid, return true
    4. return false (all cases are invalid)
*/


bool is_opening(const char &);
bool is_closing(const char &);
bool check_validity(const std::string&);
void read_file();
void write_file();

int main()
{
    read_file();
    for (auto& s : v_evaluate)
    {
        s.erase(remove_if(s.begin(), s.end(),
                          [](unsigned char x){return std::isspace(x);}),
                            s.end());
        v_result.push_back(check_validity(s));
    }
    write_file();

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
    if (str.length() == 0)
        return true;

    if (is_closing(str.front()) || is_opening(str.back()))
        return false;

    if (str.length() == 2 && str[1] == map_braces[str[0]])
        return true;

    const auto& b = str.front();
    vector<size_t> v_pos;
    size_t pos = str.find(map_braces[b]); // find closing bracket
    while (pos != std::string::npos)
    {
        v_pos.push_back(pos);
        pos = str.find(map_braces[b], ++pos); // find all occurrences of closing bracket
    }

    const auto len = str.length();
    for (const auto& pos : v_pos)
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

void read_file()
{
    std::ifstream input("./input.txt");
    std::string t;

    while (std::getline(input, t)) {
        v_evaluate.push_back(t);
    }

    cout << "Total numbers of string read: " << v_evaluate.size() << endl;
}

void write_file()
{
    std::ofstream output_file("./output.txt");
    for (const auto& b: v_result)
    {
        output_file << b << endl;
    }
    output_file.close();
}
