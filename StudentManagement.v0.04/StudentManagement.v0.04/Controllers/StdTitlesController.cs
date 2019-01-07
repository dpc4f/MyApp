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
    public class StdTitlesController : Controller
    {
        private stmgtdbEntities db = new stmgtdbEntities();

        // GET: StdTitles
        public ActionResult Index()
        {
            return View(db.StdTitles.ToList());
        }

        // GET: StdTitles/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            id = id.Replace('_', '.'); // back to normal
            StdTitle stdTitle = db.StdTitles.Find(id);
            if (stdTitle == null)
            {
                return HttpNotFound();
            }
            return View(stdTitle);
        }

        // GET: StdTitles/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: StdTitles/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdTitle,StudentTitle,YearNumb")] StdTitle stdTitle)
        {
            if (ModelState.IsValid)
            {
                db.StdTitles.Add(stdTitle);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(stdTitle);
        }

        // GET: StdTitles/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            id = id.Replace('_', '.'); // back to normal
            StdTitle stdTitle = db.StdTitles.Find(id);
            if (stdTitle == null)
            {
                return HttpNotFound();
            }
            return View(stdTitle);
        }

        // POST: StdTitles/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdTitle,StudentTitle,YearNumb")] StdTitle stdTitle)
        {
            if (ModelState.IsValid)
            {
                db.Entry(stdTitle).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(stdTitle);
        }

        // GET: StdTitles/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            id = id.Replace('_', '.'); // back to normal
            StdTitle stdTitle = db.StdTitles.Find(id);
            if (stdTitle == null)
            {
                return HttpNotFound();
            }
            return View(stdTitle);
        }

        // POST: StdTitles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            id = id.Replace('_', '.'); // back to normal
            StdTitle stdTitle = db.StdTitles.Find(id);
            db.StdTitles.Remove(stdTitle);
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
