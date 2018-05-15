#include "lop.h"

using namespace std;

CLop::CLop(string ma_lop, string mon_hoc) : msl(ma_lop), ten_mon_hoc(mon_hoc)
{
	cout << "Tao lop voi ma so: " << msl << ", ten mon hoc: " << ten_mon_hoc << std::endl;
}

std::ostream& operator<<(std::ostream& os, const CLop& lop)
{
	os << lop.msl << " - " << lop.ten_mon_hoc << std::endl;
	
	if (lop.set_mssv.size() > 0)
	{
		for (auto& msv : lop.set_mssv)
		{
			os << msv << " "; 
		}
		os << std::endl;	
	}
	
	if (lop.set_msgv.size() > 0)
	{
		for (auto& mgv : lop.set_msgv)
		{
			os << mgv << " ";
		}
		os << std::endl;
	}
	
	return os;
} 

string CLop::get_ma_lop() const
{
	return msl;
}

string CLop::get_ten_mon_hoc() const
{
	return ten_mon_hoc;
}

/*
This function will,
	1. Add ma_so_sinh_vien into the class' set of ma_so_sinh_vien
	2. 
*/
void CLop::add_sinh_vien(const string& mssv)
{
	cout << "Them sinh vien: " << mssv << " vao lop." << std::endl;
	for (auto& ma_sv : set_mssv)
	{
		if (ma_sv == mssv)
		{
			cout << "Sinh vien da dang ky lop " << msl << " roi.";
			return;
		}
	}
	set_mssv.insert(mssv);
	
	cout << "Sinh vien " << mssv << " dang ky thanh cong lop " << msl;
}

void CLop::remove_sinh_vien(const string& mssv)
{
	for (auto& ma_sv : set_mssv)
	{
		if (ma_sv == mssv)
		{
			set_mssv.erase(mssv);
			cout << "Sinh vien da khong con dang ky lop (deregister succesfully from this class)" << msl;
			return;
		}
	}
	
	cout << "Khong tim thay sinh vien voi ma so: " << mssv;
}