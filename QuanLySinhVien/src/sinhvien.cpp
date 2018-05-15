#include <iostream>
#include "sinhvien.h"

using namespace std;

CSinhVien::CSinhVien(const string& ms, const string& fname, const string& lname, const string& dob) : CNguoi(fname, lname, dob), mssv(ms)
{
	
}

std::ostream& operator <<(std::ostream& os, const CSinhVien& sv)
{
	os << sv.mssv << std::endl;
	os << sv.first_name << " " << sv.last_name << std::endl;
	os << sv.get_dob() << std::endl;
	for (const auto& ma_lop : sv.set_msl)
	{
		os << ma_lop << " ";
	}
	os << std::endl;
	
	return os;
}

void CSinhVien::dang_ky_lop(const string& ma_lop)
{
	if (set_msl.find(ma_lop) == set_msl.end())
	{
		set_msl.insert(ma_lop);
		cout << "Sinh vien dang ky thanh cong lop hoc " << ma_lop << std::endl;
	}
	else
	{
		cout << ma_lop << " da duoc dang ky!" << std::endl;
	}
}

void CSinhVien::deregister_class(const string& ma_lop)
{
	if (set_msl.find(ma_lop) != set_msl.end())
	{
		set_msl.erase(ma_lop);
		cout << "Sinh vien deregister thanh cong lop hoc " << ma_lop << std::endl;
	}
	else
	{
		cout << ma_lop << " khong tim thay hoac da duoc deregister!" << std::endl;
	}
}

string CSinhVien::get_mssv() const
{
	return mssv;
}

void CSinhVien::update_khoa_ngoai(const string& ma_lop)
{
	if (set_msl.find(ma_lop) != set_msl.end())
	{
		cout << ma_lop << "da co trong CSDL.";
	}
	else
	{
		set_msl.insert(ma_lop);
	}
}