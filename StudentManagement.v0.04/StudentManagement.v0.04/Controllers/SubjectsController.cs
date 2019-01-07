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
    public class SubjectsController : Controller
    {
        private stmgtdbEntities db = new stmgtdbEntities();

        // GET: Subjects
        public ActionResult Index()
        {
            var subjects = db.Subjects.Include(s => s.Department).Include(s => s.StdTitle);
            return View(subjects.ToList());
        }

        // GET: Subjects/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Subject subject = db.Subjects.Find(id);
            if (subject == null)
            {
                return HttpNotFound();
            }
            return View(subject);
        }

        // GET: Subjects/Create
        public ActionResult Create()
        {
            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName");
            ViewBag.IdStdTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle");
            return View();
        }

        // POST: Subjects/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdSubject,SubjectName,Credits,IdDept,IdStdTitle,SubjectNumber")] Subject subject)
        {
            if (ModelState.IsValid)
            {
                db.Subjects.Add(subject);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName", subject.IdDept);
            ViewBag.IdStdTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle", subject.IdStdTitle);
            return View(subject);
        }

        // GET: Subjects/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Subject subject = db.Subjects.Find(id);
            if (subject == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName", subject.IdDept);
            ViewBag.IdStdTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle", subject.IdStdTitle);
            return View(subject);
        }

        // POST: Subjects/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdSubject,SubjectName,Credits,IdDept,IdStdTitle,SubjectNumber")] Subject subject)
        {
            if (ModelState.IsValid)
            {
                db.Entry(subject).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdDept = new SelectList(db.Departments, "IdDept", "DeptName", subject.IdDept);
            ViewBag.IdStdTitle = new SelectList(db.StdTitles, "IdTitle", "StudentTitle", subject.IdStdTitle);
            return View(subject);
        }

        // GET: Subjects/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Subject subject = db.Subjects.Find(id);
            if (subject == null)
            {
                return HttpNotFound();
            }
            return View(subject);
        }

        // POST: Subjects/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Subject subject = db.Subjects.Find(id);
            db.Subjects.Remove(subject);
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
