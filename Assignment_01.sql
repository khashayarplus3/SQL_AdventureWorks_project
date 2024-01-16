-- What is the first name of the customer with company name “Alpine Ski House?”
-- Helen
select firstname , companyname from customer
where companyname = 'Alpine Ski House'

--How many AdventureWorks customers go by the title of “Mr."? 
-- 255
select firstname, lastname , count(title) as Mr_count
from customer
where title = 'Mr.'
group by firstname, lastname 

--Which salesperson in the customer table represents the LEAST number of customers?
-- "adventure-works\michael9"	sales: 16
select salesperson, count(customerid) as count_of_sales
from customer
group by salesperson 
order by count_of_sales asc
limit 1


