﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class StudentMgtDataEntities : DbContext
    {
        public StudentMgtDataEntities()
            : base("name=StudentMgtDataEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Class> Classes { get; set; }
        public virtual DbSet<Department> Departments { get; set; }
        public virtual DbSet<Enrolment> Enrolments { get; set; }
        public virtual DbSet<Gender> Genders { get; set; }
        public virtual DbSet<Lecturer> Lecturers { get; set; }
        public virtual DbSet<StdTitle> StdTitles { get; set; }
        public virtual DbSet<Student> Students { get; set; }
        public virtual DbSet<Subject> Subjects { get; set; }
        public virtual DbSet<TheSchool> TheSchools { get; set; }
    }
}
