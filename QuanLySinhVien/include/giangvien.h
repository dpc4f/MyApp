#ifndef __CGIANGVIEN_H__
#define __CGIANGVIEN_H__

#include <string>
#include <vector>
using namespace std;

/*
	CLecturer class declaration
*/
class CGiangVien : public CNguoi
{
protected:
	string msgv;				// ma so giang vien
	vector<string> vt_msl;		// vector of ma_so_lop

public:
	string get_ma_giang_vien();
	void set_ma_giang_vien(const string& mgv);
};



#endif
