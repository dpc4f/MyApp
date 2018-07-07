#include <iostream>
#include <vector>
#include <array>
#include <algorithm>
#include <fstream>
#include <iterator>
#include <sstream>
using namespace std;

const int N = 7;
const int NOT_AVAILABLE = -1;
vector<int> arrA{ {0, 1, 1, 2, 3, 4, 5} };
vector<int> arrB{ {0, 2, 5, 6, 6, 7, 8} };
vector<int> vec_result;

vector<vector<int>> vv_input; // read the numbers from file
vector<vector<int>> vv_output;

void read_file();
void write_file();
void merge_arr();
void merge_arr_02();

void read_file()
{
    std::ifstream input("./input.txt");
    std::string t;

    while (std::getline(input, t)) {
        std::istringstream in(t);
        std::vector<int> temp;
        temp.assign( std::istream_iterator<int>(in), std::istream_iterator<int>() );

        vv_input.push_back(temp);
    }

    cout << "Total numbers of vector read: " << vv_input.size() << endl;
}

void write_file(const string& fname)
{
    std::ofstream output_file(fname);
    std::ostream_iterator<int> output_iterator(output_file, " ");

    for (auto& vt: vv_output)
    {
        std::copy(vt.begin(), vt.end(), output_iterator);
        output_file << endl;
    }
    output_file.close();
}

void merge_arr()
{
    cout << endl << " ------- MERGE ARRAY ------- " << endl;
    unsigned int i = 0, j = 0;
    vec_result.clear();

    do
    {
        if (arrA[i] < arrB[j])
        {
            vec_result.push_back(arrA[i++]);
        }
        else if (arrA[i] > arrB[j])
        {
            vec_result.push_back(arrB[j++]);
        }
        else
        {
            int tmp = arrA[i];
            while (i < arrA.size() && tmp == arrA[i]) ++i;
            while (j < arrB.size() && tmp == arrB[j]) ++j;
        }
    }
    while (i < arrA.size() && j < arrB.size());

    while (i < arrA.size())
    {
        vec_result.push_back(arrA[i++]);
    }

    while (j < arrB.size())
    {
        vec_result.push_back(arrB[j++]);
    }

    for (auto& i : vec_result)
        cout << i << ' ';
    cout << endl << endl;

    vv_output.push_back(vec_result);
}

void merge_arr_02()
{
    cout << endl << " ------- MERGE ARRAY THE SECOND WAY ------- " << endl;

    unsigned int i = 0;
    unsigned int j = 0;
    vec_result.clear();

    do
    {
        while (arrA[i] < arrB[j]) ++i;
        while (arrB[j] < arrA[i]) ++j;

        if (arrA[i] == arrB[j])
        {
            int tmp = arrA[i];
            for (; i<N && arrA[i] == tmp; ++i)
                arrA[i] = NOT_AVAILABLE;
            for (; j<N && arrB[j] == tmp; ++j)
                arrB[j] = NOT_AVAILABLE;

        }

    }
    while (i < N && j < N);

    i = j = 0;
    do
    {
        while (arrA[i] == NOT_AVAILABLE) ++i;
        while (arrB[j] == NOT_AVAILABLE) ++j;
        if (arrA[i] < arrB[j])
        {
            vec_result.push_back(arrA[i++]);
        }
        else
        {
            vec_result.push_back(arrB[j++]);
        }
    }
    while (i < N && j < N);

    while (i < arrA.size())
    {
        if (arrA[i] != NOT_AVAILABLE)
            vec_result.push_back(arrA[i]);
        ++i;
    }

    while (j < arrB.size())
    {
        if (arrB[j] != NOT_AVAILABLE)
            vec_result.push_back(arrB[j]);
        ++j;
    }

    for (auto& i : vec_result)
        cout << i << ' ';
    cout << endl << endl;

    vv_output.push_back(vec_result);
}

void merging()
{
    vv_output.clear();
    for (auto it = vv_input.cbegin(); it < vv_input.cend(); it+=2)
    {
        std::copy(std::begin(*it), std::end(*it), std::begin(arrA));
        std::copy(std::begin(*(it+1)), std::end(*(it+1)), std::begin(arrB));
        merge_arr();
    }

    write_file("output.txt");
}

void merging_02()
{
    vv_output.clear();
    for (auto it = vv_input.cbegin(); it < vv_input.cend(); it+=2)
    {
        std::copy(std::begin(*it), std::end(*it), std::begin(arrA));
        std::copy(std::begin(*(it+1)), std::end(*(it+1)), std::begin(arrB));
        merge_arr_02();
    }

    write_file("output_02.txt");
}

int main()
{
    read_file();
    merging();
    merging_02();

    return 0;
}

void print_result()
{
    cout << endl << "The merged array will be: " << endl;
    for (auto & i : vec_result)
    {
        cout << i << ' ';
    }

    cout.flush();
}
