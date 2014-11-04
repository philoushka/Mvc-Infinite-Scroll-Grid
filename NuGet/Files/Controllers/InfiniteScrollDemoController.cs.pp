using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;

namespace $rootnamespace$.Controllers
{
    public class InfiniteScrollDemoController : Controller
    {
        public const int RecordsPerPage = 20;
        public InfiniteScrollDemoController()
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

    public class Customer
    {
        public string ID { get; set; }
        public string Name { get; set; }
        public string MailingAddress { get; set; }
        public string Email { get; set; }
    }

    public class CustomerRepository
    {
        public IEnumerable<Customer> ListCustomers()
        {
            string customerFile = HostingEnvironment.MapPath("~/App_Data/Customers.csv");

            foreach (string line in System.IO.File.ReadAllLines(customerFile))
            {
                var parts = line.Split('|');
                yield return new Customer
                {
                    ID = parts[0],
                    Name = parts[1],
                    MailingAddress = parts[2].Replace("\"", string.Empty),
                    Email = parts[3]
                };
            }
        }
    }

}