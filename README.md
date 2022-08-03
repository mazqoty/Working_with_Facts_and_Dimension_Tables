# Working with Facts and Dimension Tables
=========================================

In this lab you will:

1. Study the schema of the given csv file
2. Design the fact tables
3. Design the dimension tables
4. Create a star schema using the fact and dimension tables

#### Exercise 1 - Study the schema of the given csv file

In this lab, we will design a data warehouse for a cloud service provider.
The cloud service provider has given us their billing data in the csv file ```cloud-billing-dataset.csv```. This file contains the billing data for the past decade.
Here are the field wise details of the billing data.

<table style="width:100%">
  <tr>
    <td>Field Name</td>
    <td>Details</td>
  </tr>
  <tr>
    <td>customerid</td>
    <td>Id of the customer</td>
  </tr>
  <tr>
    <td>category</td>
    <td>Category of the customer. Example: Individual or Company</td>
  </tr>
  <tr>
    <td>country</td>
    <td>Country of the customer</td>
  </tr>
  <tr>
    <td>industry</td>
    <td>Which domain/industry the customer belongs to. Example: Legal, Engineering</td>
  </tr>
  <tr>
    <td>month</td>
    <td>The billed month, stored as YYYY-MM. Example: 2009-01 refers to the month January in the year 2009</td>
  </tr>
  <tr>
    <td>billedamount</td>
    <td>Amount charged by the cloud services provided for that month in USD</td>
  </tr>
</table>

We need to design a data warehouse that can support the queries listed below:

- average billing per customer
- billing by country
- top 10 customers
- top 10 countries
- billing by industry
- billing by category
- billing by year
- billing by month
- billing by quarter
- average billing per industry per month
- average billing per industry per quarter
- average billing per country per quarter
- average billing per country per industry per quarter

Here are five rows picked at random from the csv file.

![alt text](https://i.imgur.com/YC55fj7.png)

#### Exercise 2 - Design the fact tables

The fact in this data is the bill which is generated monthly.
The fields ```customerid``` and ```billedamount``` are the important fields in the fact table.
We also need a way to identify the additional customer information, other than the id, and date information. So we need fields that refer to the customer and date information in other tables.
The final fact table for the bill would look like this:
<table style="width:100%">
  <tr>
    <td>Field Name</td>
    <td>Details</td>
  </tr>
  <tr>
    <td>billid</td>
    <td>Primary key - Unique identifier for every bill</td>
  </tr>
  <tr>
    <td>customerid</td>
    <td>Foreign Key - Id of the customer</td>
  </tr>
  <tr>
    <td>monthid</td>
    <td>Foreign Key - Id of the month. We can resolve the billed month info using this</td>
  </tr>
  <tr>
    <td>billedamount</td>
    <td>Amount charged by the cloud services provided for that month in USD</td>
  </tr>
</table>
