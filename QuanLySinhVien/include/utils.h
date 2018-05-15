#ifndef __UTILS_H__
#define __UTILS_H__

#include <string>
#include <vector>
#include <sstream>
#include <fstream>
#include <iostream>
#include <iterator>
#include <algorithm>
#include <iomanip>
#include "lop.h"
#include "sinhvien.h"

using namespace std;

vector<string> split(string str);
string create_ma_sv();
void doc_danh_sach_lop_master(std::set<CLop, lop_compare>&);
void them_sinh_vien_vao_lop(std::vector<CLop>& vt_lop, std::vector<CSinhVien>&, const string& msl, const string& ten_mon_hoc, const string& mssv);



#endif