@model Dictionary<int, $rootnamespace$.Controllers.Customer>

@foreach (var cust in Model)
{
    <tr>
        <td>@cust.Key</td>
        <td>@cust.Value.ID</td>
        <td>@cust.Value.Name</td>
        <td>@cust.Value.MailingAddress</td>
        <td>@cust.Value.Email</td>
    </tr>
}