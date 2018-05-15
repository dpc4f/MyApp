#ifndef __CSINHVIEN_H__
#define __CSINHVIEN_H__

#include <string>
#include <vector>
#include <set>
#include <fstream>
#include "nguoi.h"

using namespace std;

class CSinhVien : public CNguoi
{
protected:
	string mssv;
	set<string> set_msl;
	
public:
	CSinhVien(const string& ms, const string& fname = "", const string& lname = "", const string& dob = "");
	void dang_ky_lop(const string& ma_lop);
	void deregister_class(const string& ma_lop);
	friend ostream& operator <<(ostream& os, const CSinhVien&);
	string get_mssv() const;
	void update_khoa_ngoai(const string& ma_lop);
};

struct find_by_mssv
{
	explicit find_by_mssv(const std::string& ms) : mssv(ms) {}
	
	inline bool operator()(const CSinhVien& sv) const
	{
		return sv.get_mssv() == mssv;
	}
	
private:
	string mssv;
};

#endif