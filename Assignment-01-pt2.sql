--note: correct logical processing order for a select query in sql 
-- from , where , group by , having , select, distinct, order by , limit 

-- Task7: using title, firstname, lastnames and suffix , concat them into a full name; 
--some people dont have suffix & middle name

select firstname, lastname, middlename , 
	concat(title, ' ', firstname, ' ', coalesce(middlename, ''), ' ', lastname, coalesce(suffix, '')) as fullname
from customer 


--task 8 : which of the following company names appear multiple times in our customer table? 
-- Cycle Merchants , Great Bikes, The Bike Shop , Famous Bike Shop, Friendly Bike Shop
select companyname, count(*) as appearance_count
from customer
group by companyname
having count(*)> 1
-- answer : Friendly Bike Shop Appears twice 

--task 9: Which customer has the Most Recent modified date in the customer table?
select modifieddate, companyname from customer
order by modifieddate desc
--Answer: Jay Adams (company: Valley Bicycle Specialists)

--task 10: How many company names contain the word 'bike'?
--since 'bike' can be both in upper and lower case we manipulate company name first 
select distinct companyname , lower(companyname) as company_name_simplified 
from customer
where lower(companyname) like '%bike%' 
-- theres 108 rows 
--alternitively; 
SELECT distinct COUNT(*) AS company_count
FROM customer
WHERE lower(companyname) LIKE '%bike%';

-- end of assignment #1 
