//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StudentManagement.v0._02.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Student
    {
        public int idStudent { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public Nullable<int> idGender { get; set; }
        public Nullable<int> idDept { get; set; }
        public Nullable<int> idTitle { get; set; }
    
        public virtual Department Department { get; set; }
        public virtual Gender Gender { get; set; }
        public virtual StdTitle StdTitle { get; set; }
    }
}
