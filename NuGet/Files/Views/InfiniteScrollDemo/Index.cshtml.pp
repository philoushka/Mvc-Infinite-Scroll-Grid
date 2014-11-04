@{
    ViewBag.Title = "ASP.NET MVC Infinite Scroll Demo";
}
<h1>ASP.NET MVC Infinite Scroll Demo</h1>
<p>
    Here's a table of data. Instead of loading all <span class="text-primary">@ViewBag.TotalNumberCustomers</span> items, let's load them only when the user calls for them.
    This technique can be used with any HTML element that holds repeating items. This demo uses <code>&lt;table&gt;</code>, but you can use <code>&lt;div&gt;</code> or <code>&lt;ul&gt;</code> and <code>&lt;li&gt;</code> as you need.
</p>

<h2>Customer Demo</h2>
<p>
    This table starts off with <strong>@ViewBag.RecordsPerPage</strong> items. Scroll down on this page. You'll see that rows are added as you scroll down.
    The app will deliver <strong>@ViewBag.RecordsPerPage </strong> items at a time, up to its max of <strong>@ViewBag.TotalNumberCustomers</strong>.
</p>

<table class="infinite-scroll">
    <thead>
        <tr>
            <th>Row</th>
            <th>Employee ID #</th>
            <th>Name</th>
            <th>Address</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody>
        @Html.Partial("_CustomerRow", (ViewBag.Customers as Dictionary<int, $rootnamespace$.Controllers.Customer>))
    </tbody> 
</table>
<div id="loading">
    <img src='@Url.Content("~/images/spin.gif")' /><p><b>Loading the next @ViewBag.RecordsPerPage&hellip;</b></p>
</div>
@section scripts{
    <script src="~/Scripts/infiniteScroll.js"></script>
    <script type="text/javascript">
        $(function () {
            $("div#loading").hide();
        });
        var moreRowsUrl = "/InfiniteScrollDemo/GetCustomers"; //the URL to your ActionMethod
        //var moreRowsUrl = ' Url.RouteUrl("CustomerList")'; //if you have a route defined, you can use an Html helper like Url.RouteUrl
        $(window).scroll(scrollHandler);
</script>
}