using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using StudentManagement.v0._04.Models;

namespace StudentManagement.v0._04.Controllers
{
    public class EnrollmentsController : Controller
    {
        private stmgtdbEntities db = new stmgtdbEntities();

        // GET: Enrollments
        public ActionResult Index()
        {
            var enrollments = db.Enrollments.Include(e => e.Student).Include(e => e.Subject);
            return View(enrollments.ToList());
        }

        // GET: Enrollments/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Enrollment enrollment = db.Enrollments.Find(id);
            if (enrollment == null)
            {
                return HttpNotFound();
            }
            return View(enrollment);
        }

        // GET: Enrollments/Create
        public ActionResult Create()
        {
            ViewBag.IdStudent = new SelectList(db.Students, "IdStudent", "FirstN");
            ViewBag.IdSubject = new SelectList(db.Subjects, "IdSubject", "SubjectName");
            return View();
        }

        // POST: Enrollments/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdEnrollment,IdSubject,IdStudent,TaughtYear,TaughtSemester,GradePoint")] Enrollment enrollment)
        {
            if (ModelState.IsValid)
            {
                db.Enrollments.Add(enrollment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdStudent = new SelectList(db.Students, "IdStudent", "FirstN", enrollment.IdStudent);
            ViewBag.IdSubject = new SelectList(db.Subjects, "IdSubject", "SubjectName", enrollment.IdSubject);
            return View(enrollment);
        }

        // GET: Enrollments/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Enrollment enrollment = db.Enrollments.Find(id);
            if (enrollment == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdStudent = new SelectList(db.Students, "IdStudent", "FirstN", enrollment.IdStudent);
            ViewBag.IdSubject = new SelectList(db.Subjects, "IdSubject", "SubjectName", enrollment.IdSubject);
            return View(enrollment);
        }

        // POST: Enrollments/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdEnrollment,IdSubject,IdStudent,TaughtYear,TaughtSemester,GradePoint")] Enrollment enrollment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(enrollment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdStudent = new SelectList(db.Students, "IdStudent", "FirstN", enrollment.IdStudent);
            ViewBag.IdSubject = new SelectList(db.Subjects, "IdSubject", "SubjectName", enrollment.IdSubject);
            return View(enrollment);
        }

        // GET: Enrollments/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Enrollment enrollment = db.Enrollments.Find(id);
            if (enrollment == null)
            {
                return HttpNotFound();
            }
            return View(enrollment);
        }

        // POST: Enrollments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Enrollment enrollment = db.Enrollments.Find(id);
            db.Enrollments.Remove(enrollment);
            db.SaveChanges();
            return RedirectToAction("Index");
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
