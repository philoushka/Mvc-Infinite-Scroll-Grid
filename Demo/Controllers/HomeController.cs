using MvcInfiniteScrollGridDemo.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcInfiniteScrollGridDemo.Controllers
{
    public class HomeController : Controller
    {
        public const int RecordsPerPage = 20;

        public HomeController()
        {
            ViewBag.RecordsPerPage = RecordsPerPage;
        }

        public ActionResult Index()
        {
            return RedirectToAction("GetCustomers");
        }

        public ActionResult GetCustomers(int? pageNum)
        {
            pageNum = pageNum ?? 0;
            ViewBag.IsEndOfRecords = false;
            if (Request.IsAjaxRequest())
            {
                var customers = GetRecordsForPage(pageNum.Value);
                ViewBag.IsEndOfRecords = (customers.Any()) && ((pageNum.Value * RecordsPerPage) >= customers.Last().Key);
                return PartialView("_CustomerRow", customers);
            }
            else
            {
                LoadAllCustomersToSession();
                ViewBag.Customers = GetRecordsForPage(pageNum.Value);
                return View("Index");
            }
        }

        public void LoadAllCustomersToSession()
        {
            var customerRepo = new CustomerRepository();
            var customers = customerRepo.ListCustomers();
            int custIndex = 1;
            Session["Customers"] = customers.ToDictionary(x => custIndex++, x => x);
            ViewBag.TotalNumberCustomers = customers.Count();
        }

        public Dictionary<int, Customer> GetRecordsForPage(int pageNum)
        {
            Dictionary<int, Customer> customers = (Session["Customers"] as Dictionary<int, Customer>);

            int from = (pageNum * RecordsPerPage);
            int to = from + RecordsPerPage;

            return customers
                .Where(x => x.Key > from && x.Key <= to)
                .OrderBy(x => x.Key)
                .ToDictionary(x => x.Key, x => x.Value);
        }
    }
}