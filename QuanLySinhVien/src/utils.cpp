#include "utils.h"

vector<string> split(string str)
{
	std::stringstream ss(str);
	std::istream_iterator<std::string> begin(ss);
	std::istream_iterator<std::string> end;
	std::vector<std::string> vstrings(begin, end);
	std::copy(vstrings.begin(), vstrings.end(), std::ostream_iterator<std::string>(std::cout, "\n"));
	
	return vstrings;
}

string create_ma_sv()
{
	static int slsv{1};
	std::ostringstream oss;
	oss << "MS" << std::setfill('0') << std::setw(4) << slsv++;
	
	return oss.str();
}


/*
	This function will read the existing classes in the file data/dsl_master.txt into set of CLop
*/
void doc_danh_sach_lop_master(std::set<CLop, lop_compare>& set_lop)
{
	cout << "Tao danh sach lop master." << std::endl;
	set_lop.clear();
	
	string f_name("data/dsl_master.txt");
	ifstream fin(f_name, ios::binary);
	string msl;
	string ten_lop;
	
	while (std::getline(fin, msl))
	{
		std::getline(fin, ten_lop);
		CLop lop(msl, ten_lop);
		set_lop.insert(lop);
	}
}

/*
	This function will add a sinh_vien with mssv into a lop with msl
	CLop will add_sinh_vien() into its list
	sinh_vien in vt_sv will update foreign key of sinh_vien's set of lop 
*/
void them_sinh_vien_vao_lop(std::vector<CLop>& vt_lop, std::vector<CSinhVien>& vt_sv, const string& msl, const string& mon_hoc, const string& mssv)
{
	std::vector<CLop>::iterator result2 = 	std::find_if(vt_lop.begin(), vt_lop.end(),
															[msl](const CLop& lop) -> bool {
																return lop.get_ma_lop() == msl;
															});
	if (result2 != vt_lop.end())
	{
		(*result2).add_sinh_vien(mssv);
	}
	else
	{
		CLop lop(msl, mon_hoc);
		lop.add_sinh_vien(mssv);
		vt_lop.push_back(lop);
	}
	
	for (auto& sv : vt_sv)
	{
		if (sv.get_mssv() == mssv)
		{
			sv.update_khoa_ngoai(msl);
		}
	}
}

