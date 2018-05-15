#ifndef __CLOP_H__
#define __CLOP_H__

#include <string>
#include <vector>
#include <set>
#include <iostream>

using namespace std;

class CLop
{
private:
	string msl; // ma_so_lop
	string ten_mon_hoc;
	set<string> set_mssv;
	set<string> set_msgv;
	
public:
	CLop(string ma_lop, string mon_hoc);
	string get_ma_lop() const;
	string get_ten_mon_hoc() const;
	void set_ma_lop_mon_hoc(const string& ml, const string& mon_hoc);
	
	
	void add_sinh_vien(const string& msv);
	void remove_sinh_vien(const string& msv);
	
	friend ostream& operator <<(ostream& os, const CLop& lop); 
};

struct find_by_ma_lop
{
	explicit find_by_ma_lop(const std::string& ma_lop) : ma_lop(ma_lop) {}
	
	inline bool operator()(const CLop& lop) const
	{
		return lop.get_ma_lop() == ma_lop;
	}
	
private:
	string ma_lop;
};

struct lop_compare
{
	bool operator() (const CLop& lhs, const CLop& rhs) const {
        return lhs.get_ma_lop() < rhs.get_ma_lop();
    }
};

#endif