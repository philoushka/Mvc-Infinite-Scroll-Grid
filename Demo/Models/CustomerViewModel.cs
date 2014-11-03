using System.Collections.Generic;

namespace MvcInfiniteScrollGridDemo.Models
{
    public class CustomerViewModel
    {
        public Dictionary<int, Customer> Customers { get; set; }
        public CustomerViewModel()
        {
            Customers = new Dictionary<int, Customer>();
        }
    }
}