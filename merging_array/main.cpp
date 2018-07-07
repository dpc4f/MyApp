#include <iostream>
#include <vector>
#include <array>
using namespace std;

/*
arrA = [0, 1, 1, 2, 3, 4, 5]
arrB = [0, 2, 5, 6, 6, 7, 8]

arrC = [1, 1, 3, 4, 6, 6, 7, 8]
*/

array<int, 7> arrA{ {0, 1, 1, 2, 3, 4, 5} };
array<int, 7> arrB{ {0, 2, 5, 6, 6, 7, 8} };
vector<int> vec_result;


void merge_arr()
{
    unsigned int i = 0, j = 0;
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
}

void print_result()
{
    cout << endl << "The merged array will be: " << endl;
    for (auto & i : vec_result)
    {
        cout << i << ' ';
    }
}

int main()
{
    merge_arr();
    print_result();

    return 0;
}
