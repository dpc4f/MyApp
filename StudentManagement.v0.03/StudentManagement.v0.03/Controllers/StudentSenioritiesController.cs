using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using StudentManagement.v0._03.Models;

namespace StudentManagement.v0._03.Controllers
{
    public class StudentSenioritiesController : Controller
    {
        private stmgmtEntities db = new stmgmtEntities();

        // GET: StudentSeniorities
        public ActionResult Index()
        {
            return View(db.StudentSeniorities.ToList());
        }

        // GET: StudentSeniorities/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StudentSeniority studentSeniority = db.StudentSeniorities.Find(id);
            if (studentSeniority == null)
            {
                return HttpNotFound();
            }
            return View(studentSeniority);
        }

        // GET: StudentSeniorities/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: StudentSeniorities/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idSeniority,StudentTitle,Years")] StudentSeniority studentSeniority)
        {
            if (ModelState.IsValid)
            {
                db.StudentSeniorities.Add(studentSeniority);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(studentSeniority);
        }

        // GET: StudentSeniorities/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StudentSeniority studentSeniority = db.StudentSeniorities.Find(id);
            if (studentSeniority == null)
            {
                return HttpNotFound();
            }
            return View(studentSeniority);
        }

        // POST: StudentSeniorities/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idSeniority,StudentTitle,Years")] StudentSeniority studentSeniority)
        {
            if (ModelState.IsValid)
            {
                db.Entry(studentSeniority).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(studentSeniority);
        }

        // GET: StudentSeniorities/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            StudentSeniority studentSeniority = db.StudentSeniorities.Find(id);
            if (studentSeniority == null)
            {
                return HttpNotFound();
            }
            return View(studentSeniority);
        }

        // POST: StudentSeniorities/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            StudentSeniority studentSeniority = db.StudentSeniorities.Find(id);
            db.StudentSeniorities.Remove(studentSeniority);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // GET: Seniorities/ViewReport
        public ActionResult ViewReport(int? id)
        {
            //ParameterFields parameterFields = new ParameterFields();
            //ParameterField parameterField = new ParameterField();
            //ParameterDiscreteValue parameterDiscreteValue = new ParameterDiscreteValue();
            //parameterField.Name = "@stYear";
            //parameterDiscreteValue.Value = stYear;
            //parameterField.CurrentValues.Add(parameterDiscreteValue);
            //parameterFields.Add(parameterField);

            ReportDocument reportDocument = new ReportDocument();
            reportDocument.Load(Server.MapPath("~/Reports/StudentSeniorities.rpt"));
            reportDocument.SetDatabaseLogon("sa", "1234", "DESKTOP-3J745NI\\PROCASQLSERVER", "stmgmt", false);
            reportDocument.SetParameterValue("stYear", id);

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
