using System.Collections.Generic;
using System.Web.Hosting;

namespace MvcInfiniteScrollGridDemo.Models
{
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