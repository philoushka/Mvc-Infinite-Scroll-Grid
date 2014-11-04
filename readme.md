### MVC Infinite Scroll Grid ###

Here is a demonstration of a way to add infinite scrolling to a grid, table, or any other HTML element in an ASP.NET MVC project.

###[Demo - Try Out Infinite Scrolling](http://mvcinfinitescroll.azurewebsites.net/)###

Use this by:

- copying the code here from GitHub
- clone the repo for yourself
- add it to your project via NuGet


### How Does This Work? ###

- On the first hit to the page/URL, you grab all the data that could/would be displayed in this table. It doesn't even have to be a `table` with rows and columns. It could be any HTML that logically repeats.
- This data is saved to session.
- The first *n* entries are rendered to the view.
- When the user scrolls to the bottom of the page in their browser, the page sends an AJAX request back to a controller method for another batch.
- The controller takes the current 'page' number, and gets the next *n* entries from session.
- A partial view is rendered and returned back as HTML back to the browser
- The browser appends the rendered HTML to the page.

### Tweak You Might Want ###

- Use `Cache[]` instead of `Session[]`. If your data doesn't need to differ between users, you can use `Cache["Customers"]` with `System.Web.Caching`. This is useful if you want to keep your memory profile on the server low, the amount and type of data you're scrolling through, etc.   
 

### Pull Requests ###

I welcome your pull requests. Please submit your PR in a branch named for the feature/fix that you're introducing (i.e. not `master`).

### Authors ###

Phil Campbell and other contributors. Contact me by [creating a new issue on the repo](https://github.com/philoushka/Mvc-Infinite-Scroll-Grid/issues), or by [Twitter](https://twitter.com/philoushka)

### Licensing ###

MIT License
