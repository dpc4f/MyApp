#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <set>
#include "nguoi.h"
#include "sinhvien.h"
#include "lop.h"
#include "utils.h"

using namespace std;

/*
	save students to text file. but text or binary file will be considered.
	when loading students from file, check if there is already a class, 
	add the student into that class. 
	If the class hasn't existed, create a new class with the new id.
	The same for lecturers.
	
	Todo:
		1. use binary files
		2. implement clecturer class
		3. foreign key relationship among students - classes - lecturers
		4. apply more oop features
		5. add/remove students/classes/lecturers to vector/set
		6. find a person/a class with provided information
*/

void in_tuy_chon()
{
	cout << std::endl << "================ Xin Chao Ban Den Voi Chuong Trinh Quan Ly Sinh Vien ===================" << std::endl;
	cout << "1. Nhap danh sach sinh vien." << std::endl;
	cout << "2. Nhap danh sach sinh vien tu file." << std::endl;
	cout << "3. Liet ke danh sach sinh vien." << std::endl;
	cout << "4. Liet ke danh sach lop san co." << std::endl;
	cout << "5. Liet ke danh sach lop cung danh sach sinh vien." << std::endl;
	cout << "6. Tim sinh vien theo ma so." << std::endl;
	cout << "7. Tim lop theo ma so." << std::endl;
	cout << "8. Cap nhat thong tin sinh vien." << std::endl;
	cout << "9. Cap nhat thong tin lop." << std::endl;
	cout << "10. Luu danh sach sinh vien xuong file." << std::endl;
	cout << "11. Luu danh sach lop xuong file." << std::endl;
	cout << "12. Dang ky lop cho sinh vien." << std::endl;
	cout << "19. Thoat chuong trinh." << std::endl;	
}

int cnt_sv{0};
int cnt_gv{0};

vector<CSinhVien> vt_sv;
set<CLop, lop_compare> set_lop;
vector<CLop> vt_lop;


/*
	1. Nhap danh sach sinh vien.
*/
void nhap_danh_sach_sv()
{
	vt_sv.clear();
	
	string first_name;
	string last_name{""};
	string dob;
	cout << "Nhap so luong sinh vien: ";
	cin >> cnt_sv;
	
	for (int i=0; i<cnt_sv; ++i)
	{
		cout << "Sinh vien [" << i << "]" << endl;
		cout << "Nhap vao ten: ";
		cin >> first_name;
		
		cout << "Nhap vao ho: ";
		cin >> last_name;
		
		cout << "Nhap vao ngay sinh: ";
		cin >> dob;
		
		string mssv = create_ma_sv();
		CSinhVien sv(mssv, first_name, last_name, dob);
		
		string msl{""};
		do
		{
			cout << "Nhap ma so lop ma sinh vien dang theo hoc (ket thuc bang 0): ";
			cin >> msl;
			std::set<CLop>::iterator result = std::find_if(set_lop.begin(), set_lop.end(), 
															[msl](const CLop& lop) -> bool { 
																return lop.get_ma_lop() == msl; 
															});
			if (result != set_lop.end())
			{
				//sv.dang_ky_lop(msl);
				string mon_hoc = ((CLop)(*result)).get_ten_mon_hoc();
				them_sinh_vien_vao_lop(vt_lop, vt_sv, msl, mon_hoc, mssv);
			}
			else if (msl != "0")
			{
				cout << "Ma lop khong hop le." << std::endl;
			}
		} while (msl != "0");
		
		
		
		vt_sv.push_back(sv);
	}
}

void doc_file_danh_sach_sinh_vien()
{
	vt_sv.clear();
	
	string f_name("data/dssv.txt");
	ifstream fin(f_name, ios::binary);
	
	string mssv;
	string ho_ten{""};
	string dob;
	string ml;
	while (std::getline(fin, mssv))
	{
		std::getline(fin, ho_ten);
		vector<string> vt_ht = split(ho_ten);
		std::getline(fin, dob);
		std::getline(fin, ml);
		vector<string> vt_msl = split(ml);
		
		CSinhVien sv(mssv, vt_ht[0], vt_ht[1], dob);
		for (auto& ml : vt_msl)
		{
			std::set<CLop>::iterator result = std::find_if(set_lop.begin(), set_lop.end(), 
												[ml](const CLop& lop) -> bool { 
													return lop.get_ma_lop() == ml; 
												});
			if (result != set_lop.end())
			{
				sv.dang_ky_lop(ml);
				string mon_hoc = ((CLop)(*result)).get_ten_mon_hoc();
				them_sinh_vien_vao_lop(vt_lop, vt_sv, ml, mon_hoc, mssv);	
			}

		}
		vt_sv.push_back(sv);
	}
}


void in_danh_sach_sinh_vien()
{
	for (auto& sv : vt_sv)
	{
		cout << sv;
	}
}


/*
	This function will print out the set of clop which is read from data/dsl_master.txt
*/
void in_danh_sach_lop_master()
{
	for (const auto& lop : set_lop)
	{
		cout << lop;
	}
}

/*
	This function will print out a lop with its associated students/lecturers information
*/
void in_ds_lop_ds_sv()
{
	cout << "Tong so luong cac lop duoc sinh vien dang ky: " << vt_lop.size() << std::endl;
	for (auto& lop : vt_lop)
	{
		cout << lop;
	}
}

void tim_sinh_vien_theo_ma()
{
	string ms{""};
	
	cout << "Nhap vao ma sv can tim: ";
	cin >> ms;
	
	std::vector<CSinhVien>::iterator result = std::find_if(vt_sv.begin(), vt_sv.end(), 
													[ms](const CSinhVien& sv) -> bool { 
														return sv.get_mssv() == ms; });
	
	if (result != vt_sv.end())
	{
		cout << *result;
	}
	
}


void tim_lop_theo_ma()
{
	// to be implemented
}


void cap_nhat_thong_tin_sv()
{
	string ms;
	cout << "Nhap ma so sinh vien can cap nhat thong tin: ";
	cin >> ms;

	//std::vector<CSinhVien>::iterator result = std::find_if(vt_sv.begin(), vt_sv.end(), 
	//												[ms](const CSinhVien& sv) -> bool { 
	//													return sv.get_mssv() == ms; });
	
	for (auto& ele : vt_sv)
	{
		if (ele.get_mssv() == ms)
		{
//			cout << *result;
			string ho, ten, dob; // class registration/deregistration will be at another method, 
			
			cout << "Nhap vao ten can cap nhat (hoac 0 neu khong muon thay doi): ";
			cin >> ten;
			if (ten != "0")
			{
				ele.set_first_name(ten);
			}
			
			cout << "Nhap vao ho can cap nhat (hoac 0 neu khong muon thay doi): ";
			cin >> ho;
			if (ho != "0")
			{
				ele.set_last_name(ho);
			}
			
			cout << "Nhap vao ngay sinh can cap nhat (hoac 0 neu khong muon thay doi): ";
			cin >> dob;
			if (dob != "0")
			{
				ele.set_dob(dob);
			}
			
			return;
		}
	}

	cout << "Khong tim thay sinh vien.";
}

void cap_nhat_thong_tin_lop_hoc()
{
	// to be implemented
}

void xuat_file_danh_sach_sv()
{
	ofstream fout("data/dssv.txt", ios::binary);
	for (auto& sv : vt_sv)
	{
		fout << sv;
	}
}


void xuat_file_danh_sach_lop_hoc()
{
	// to be implemented
}

void dang_ky_lop_cho_sv()
{
	string mssv;
	string ds_ma_lop;
	
	cout << "Nhap vao ma so sinh vien can dang ky lop: ";
	cin >> mssv;
	
	cout << "Nhap vao danh sach lop (cach nhau khoang trang) sinh vien muon dang ky: ";
	cin >> ds_ma_lop;
	
	vector<string> vt_ds_ma_lop = split(ds_ma_lop);
	for (auto& ma_lop : vt_ds_ma_lop)
	{
		std::set<CLop>::iterator result = std::find_if(set_lop.begin(), set_lop.end(), 
												[ma_lop](const CLop& lop) -> bool { 
													return lop.get_ma_lop() == ma_lop; 
												});
		if (result != set_lop.end())
		{
			them_sinh_vien_vao_lop(vt_lop, vt_sv, ma_lop, ((CLop)(*result)).get_ten_mon_hoc(), mssv);
		}
		
	}
}

int main()
{
	string f_name{"dssv.txt"};
	doc_danh_sach_lop_master(set_lop);
	
	int so_tt;
	bool thoat{false};
	do {
		in_tuy_chon();
		cout << "Nhap vao thao tac can thuc thi: ";
		cin >> so_tt;
		switch (so_tt)
		{
			case 1: // Nhap danh sach sinh vien
				nhap_danh_sach_sv();
				break;
			case 2: // Nhap danh sach sinh vien tu file
				doc_file_danh_sach_sinh_vien();
				break;
			case 3: // Liet ke danh sach sinh vien
				in_danh_sach_sinh_vien();
				break;
			case 4: // Liet ke danh sach lop san co
				in_danh_sach_lop_master();
				break;
			case 5: // Liet ke danh sach lop cung danh sach sinh vien
				in_ds_lop_ds_sv();
				break;
			case 6: // Tim sinh vien theo ma so
				tim_sinh_vien_theo_ma();
				break;
			case 7: // Tim lop theo ma so
				tim_lop_theo_ma();
				break;
			case 8: // Cap nhat thong tin sinh vien
				cap_nhat_thong_tin_sv();
				break;
			case 9: // Cap nhat thong tin lop
				break;
			case 10: // Luu danh sach sinh vien xuong file
				xuat_file_danh_sach_sv();
				break;
			case 11: // Luu danh sach lop xuong file
				break;
			case 12: // Dang ky lop cho sinh vien
				dang_ky_lop_cho_sv();
				break;
			case 19:
				thoat = true;
				break;
			default:
				break;
		}
	} while (thoat == false);
	
	

	
	return 0;
}