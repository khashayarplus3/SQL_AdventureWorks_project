-- Assignment 03: AdventureWorks scenario #3
-- task 1-5 were multiple choice questions designed to test knowledge of the database and functions 

-- Task 06: Of the following options, which is the most popular bicycle that AdventureWorks sells?
--Mountain-200 Black, 42, Touring-1000 Blue, 60, Touring-1000 Yellow, 60, Mountain-200 Black, 38
-- the one with the highest revenue 
SELECT product.name, sum(linetotal) AS sales_amount
from salesorderdetail
inner join product on salesorderdetail.productid = product.productid 
where product.name IN ('Mountain-200 Black, 42', 'Touring-1000 Blue, 60', 'Touring-1000 Yellow, 60', 'Mountain-200 Black, 38')
GROUP BY product.name
order by sales_amount desc
limit 1
--"Touring-1000 Blue, 60", 37191.492000


--Task 07: Of the following options, which product category is our most popular when measured by the count of sales?
select productcategory.name , sum(round(salesorderdetail.linetotal,2)) as total_sales
from product
inner join productcategory on product.productcategoryid= productcategory.productcategoryid
inner join salesorderdetail on product.productid = salesorderdetail.productid
group by productcategory.name
order by total_sales desc
limit 1 
-- Touring Bikes, 220655.35


--Task 8: part_1:AdventureWorks management wants to know how many high-priced units we have sold, 
--versus low-priced units. They have asked you to pull the unit prices and order quantities
--from the SalesOrderDetail table and group them into the following ranges:
-- $0-99 dollars, $100-999 dollars, $1000+ dollars
-- Pt2 : How many units have we sold that are valued at $1,000 or more?

select 
Case
	when salesorderdetail.unitprice <= 99 then '0-99 Dollars'
	when salesorderdetail.unitprice between 100 and 999 then '$100-999 Dollars'
	else '$1000+ Dollars'
end as sales_category
, sum( salesorderdetail.orderqty) as number_of_units_sold
from salesorderdetail
where unitprice > 1000
group by sales_category


--Task 9: How many units in Product Category 'Cranksets' have been shipped to an address in London, England?
--For this next question, you will need to join to the SalesOrderHeader table 
select sum(salesorderdetail.orderqty) as order_quantity  
from customeraddress
inner join address on address.addressid = customeraddress.addressid
inner join salesorderheader on customeraddress.customerid = salesorderheader.customerid
inner join salesorderdetail on salesorderdetail.salesorderid = salesorderheader.salesorderid
where address.city = 'London'

--Task 10: Use the ProductModel table to answer the following question:
--Which company from our customers has spent over $90 on the Racing Socks product model?

SELECT ProductModel.name
	, Customer.CompanyName
	, SUM(SalesOrderDetail.LineTotal) AS Total_Sales
FROM ProductModel
	INNER JOIN Product
		ON ProductModel.ProductModelID = Product.ProductModelID
	INNER JOIN SalesOrderDetail
		ON Product.ProductID = SalesOrderDetail.ProductID
	INNER JOIN SalesOrderHeader
		ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesorderID
	INNER JOIN Customer
		ON Customer.CustomerID = SalesOrderHeader.CustomerID
WHERE ProductModel.Name = 'Racing Socks'
GROUP BY ProductModel.name
	, Customer.CompanyName
HAVING SUM(SalesOrderDetail.LineTotal) > 90;


--task 11; Use either RANK() or DENSE_RANK() to create a list of companies that ranks them by the quantity of units (SalesOrderDetail.OrderQty) sold by AdventureWorks.
--Select all companies that are tied for 10th place according to total quantity sold.
with cte as (
	select distinct customer.companyname
		, sum(salesorderdetail.linetotal) as total_sales
		, sum(salesorderdetail.orderqty) as quantity_sold
	from productcategory
		inner join product
			on productcategory.productcategoryid = product.productcategoryid
		inner join salesorderdetail
			on product.productid = salesorderdetail.productid
		inner join salesorderheader
			on salesorderdetail.salesorderid = salesorderheader.salesorderid
		inner join customer
			on customer.customerid = salesorderheader.customerid
	group by customer.companyname
)

select companyname
	, total_sales
	, quantity_sold
	, rank() over (order by quantity_sold desc)
	, dense_rank() over (order by quantity_sold desc)
from cte
order by quantity_sold desc;
--Nearby cycle shop and Closest Bicycle store 


