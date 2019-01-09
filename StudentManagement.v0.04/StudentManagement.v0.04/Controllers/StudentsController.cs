using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CrystalDecisions.CrystalReports.Engine;
using StudentManagement.v0._04.Models;

namespace StudentManagement.v0._04.Controllers
{
    public class StudentsController : Controller
    {
        private stmgtdbEntities db = new stmgtdbEntities();

        // GET: Students
        public ActionResult Index()
        {
            var students = db.Students.Include(s => s.Department).Include(s => s.Gender).Include(s => s.StdTitle);
            return View(students.ToList());
        }

        // GET: Students/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            return View(student);
        }

        // GET: Students/Create
        public ActionResult Create()
        {
            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName");
            ViewBag.IdGender = new SelectList(db.Genders, "IdGender", "Gender1");
            ViewBag.IdStudTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle");
            return View();
        }

        // POST: Students/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdStudent,FirstN,LastN,IdGender,IdDept,IdStudTitle,StudNumber")] Student student)
        {
            if (ModelState.IsValid)
            {
                db.Students.Add(student);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName", student.IdDept);
            // ViewBag.DeptName = new SelectList(db.Departments, "DeptName", "DeptName", student.DeptName);
            ViewBag.IdGender = new SelectList(db.Genders, "IdGender", "Gender1", student.IdGender);
            ViewBag.IdStudTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle", student.IdStudTitle);
            return View(student);
        }

        // GET: Students/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName", student.IdDept);
            // ViewBag.DeptName = new SelectList(db.Departments, "DeptName", "DeptName", student.DeptName);
            ViewBag.IdGender = new SelectList(db.Genders, "IdGender", "Gender1", student.IdGender);
            ViewBag.IdStudTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle", student.IdStudTitle);
            return View(student);
        }

        // POST: Students/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdStudent,FirstN,LastN,IdGender,IdDept,IdStudTitle,StudNumber")] Student student)
        {
            if (ModelState.IsValid)
            {
                db.Entry(student).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName", student.IdDept);
            // ViewBag.DeptName = new SelectList(db.Departments, "DeptName", "DeptName", student.DeptName);
            ViewBag.IdGender = new SelectList(db.Genders, "IdGender", "Gender1", student.IdGender);
            ViewBag.IdStudTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle", student.IdStudTitle);
            return View(student);
        }

        // GET: Students/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            return View(student);
        }

        // POST: Students/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Student student = db.Students.Find(id);
            db.Students.Remove(student);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // GET: Students/ViewReport
        public ActionResult ViewReport(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            id = id.Replace('_', '.'); // back to normal
            ReportDocument reportDocument = new ReportDocument();
            reportDocument.Load(Server.MapPath("~/Reports/StudentDetails.rpt"));
            reportDocument.SetDatabaseLogon("sa", "1234", "DESKTOP-3J745NI\\PROCASQLSERVER", "stmgtdb", false);
            reportDocument.SetParameterValue("studentID", "'" + id + "'");
            var s = reportDocument.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);

            return File(s, "application/pdf");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
