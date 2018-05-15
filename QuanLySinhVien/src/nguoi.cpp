#include <iostream>
#include "nguoi.h"


using namespace std;

/*
	ctor of class CNguoi
*/
CNguoi::CNguoi(const string& fname, const string& lname, const string& dob) : first_name(fname), last_name(lname), dob(dob)
{
	
}

/*
	getter - return the person's first name
*/
string CNguoi::get_first_name() const
{
	return first_name;
}

/*
	getter - return the person's last name
*/
string CNguoi::get_last_name() const
{
	return last_name;
}

/*
	getter - return the person's date of birth
*/
string CNguoi::get_dob() const
{
	return dob;
}

/*
	setter of first name
*/
void CNguoi::set_first_name(const string& fname)
{
	first_name = fname;
	cout << "Da cap nhat ten sinh vien. Ten moi la: " << first_name;
}

/*
	setter of last name
*/
void CNguoi::set_last_name(const string& lname)
{
	last_name = lname;
	cout << "Da cap nhat ho sinh vien. Ho moi la: " << lname;
}

/*
	setter of dob
*/
void CNguoi::set_dob(const string& dob)
{
	this->dob = dob;
	cout << "Da cap nhat ngay sinh sinh vien. Ngay sinh moi la: " << this->dob;
}