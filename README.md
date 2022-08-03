# Working with Facts and Dimension Tables

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

#### Exercise 3 - Design the dimension tables
There are two dimensions to our fact(monthly bill).
1. Customer information
2. Date information
Let us organize all the fields that give information about the customer into a dimension table.
<table style="width:100%">
  <tr>
    <td>Field Name</td>
    <td>Details</td>
  </tr>
  <tr>
    <td>customerid</td>
    <td>Primary Key - Id of the customer</td>
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
</table>

Let us organize or derive all the fields that give information about the date of the bill.

<table style="width:100%">
  <tr>
    <td>Field Name</td>
    <td>Details</td>
  </tr>
  <tr>
    <td>monthid</td>
    <td>Primary Key - Id of the month</td>
  </tr>
  <tr>
    <td>year</td>
    <td>Year derived from the month field of the original data. Example: 2010</td>
  </tr>
  <tr>
    <td>month</td>
    <td>Month number derived from the month field of the original data. Example: 1, 2, 3</td>
  </tr>
  <tr>
    <td>monthname</td>
    <td>Month name derived from the month field of the original data. Example: March</td>
  </tr>
   <tr>
    <td>quarter</td>
    <td>Quarter number derived from the month field of the original data. Example: 1, 2, 3, 4</td>
  </tr>
   <tr>
    <td>quartername</td>
    <td>Quarter name derived from the month field of the original data. Example: Q1, Q2, Q3, Q4</td>
  </tr>
</table>

#### Exercise 4 - Create a star schema using the fact and dimension tables
Based on the previous two exercises, we have now arrived at 3 tables, we can name them as in the table below.
Table Name	Type
<table style="width:100%">
  <tr>
    <td>Table Name</td>
    <td>Type<td>
    <td>Details</td>
  </tr>
  <tr>
    <td>FactBilling</td>
    <td>Fact<td>
    <td>This table contains the billing amount, and the foreign keys to customer and month data</td>
  </tr>
  <tr>
    <td>DimCustomer</td>
    <td>Dimension</td>
    <td>This table contains all the information related the customer<td>
  </tr>
  <tr>
    <td>DimMonth</td>
    <td>Dimension<td>
    <td>	This table contains all the information related the month of billing</td>
  </tr>
 </table>
 
 When we arrange the above tables in Star Schema style, we get a table strucutre that looks likes the one in the image below.
 
 ![alt_text](https://i.imgur.com/lvTBCgI.jpg)
 
 The image shows the fact and dimension tables along with the relaionships between them.
 
 Step 1: Start the postgresql server.
 
 Step 2: Create the database on the data warehouse.
 
 Using the createdb command of the PostgreSQL server, we can directly create the database from the terminal.
 
 Run the command below to create a database named billingDW.
 
 ```createdb -h localhost -U postgres -p 5432 billingDW```
 
 In the above command
 
  -h mentions that the database server is running on the localhost
  
  -U mentions that we are using the user name postgres to log into the database
  
  -p mentions that the database server is running on port number 5432
 
 Step 3: Download the schema .sql file.
 
 Download the file by running the command below.
 
 ```wget https://github.com/mazqoty/Working_with_Facts_and_Dimension_Tables/blob/main/postgresql_Star-Schema_Script.sql```
 
 Step 4: Create the schema
 
 Run the command below to create the schema in the under ```billingDW``` database.
 
 ```psql  -h localhost -U postgres -p 5432 billingDW < postgresql_Star-Schema_Script.sql```
 
 You should see an ouput similar to the one below.
 
 ![alt_text]()
 
