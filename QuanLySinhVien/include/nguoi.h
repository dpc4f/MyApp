#ifndef __CNGUOI_H__
#define __CNGUOI_H__

#include <string>

using namespace std;


/*
	This is the base class for CSinhVien & CLecturer
*/
class CNguoi
{
protected:
	string first_name, last_name;
	string dob;
	
public:
	CNguoi(const string& fname, const string& lname, const string& dob) ;
	
	string get_first_name() const;
	void set_first_name(const string& fname);
	
	string get_last_name() const;
	void set_last_name(const string& lname);
	
	string get_dob() const; // getter/setter date of birth
	void set_dob(const string& dob);
	
};

#endif