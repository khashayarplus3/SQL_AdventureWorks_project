-- Task 1: How many companies have an address in the US state of Colorado?
-- we joined the customer , customeraddress and address tables to get this 

select count(distinct customer.customerid) as company_count
from customer
join customeraddress on customer.customerid = customeraddress.customerid
join address on address.addressid = customeraddress.addressid
where lower(address.stateprovince) = lower('Colorado');
-- returns 8 

--Task 2: How many comoanies are based in UK?
select count(distinct customer.customerid) as company_count
from customer
join customeraddress on customer.customerid = customeraddress.customerid
join address on address.addressid = customeraddress.addressid
where lower(address.countryregion) = lower('United Kingdom');
-- 38

--Task 3: How many companies have more than 1 address?
select count(distinct customer.customerid) as company_count
from customer
join customeraddress on customer.customerid = customeraddress.customerid
join address on address.addressid = customeraddress.addressid
-- then we run it without the DISTINCT keyword 
select count(customer.customerid) as company_count
from customer
join customeraddress on customer.customerid = customeraddress.customerid
join address on address.addressid = customeraddress.addressid
-- First command returns 417, second returns 407, therefore 10 companies have multiple addresses. 
-- alternatively from ChatGPT; 
SELECT COUNT(*) as company_count
FROM (
    SELECT customer.customerid
    FROM customer
    INNER JOIN customeraddress ON customer.customerid = customeraddress.customerid
    INNER JOIN address ON address.addressid = customeraddress.addressid
    GROUP BY customer.customerid
    HAVING COUNT(*) > 1
) AS single_address_companies;
--returns 10 

--Task 5: Which of the following cities is NOT included among the list of companies that have more than one address?
--Austin, Dallas, London, Montreal, Phoenix

select customer.customerid, customer.company_name, address.addressline1, address.stateprovince
from customer
inner join customeraddress on customer.customerid = customeraddress.customerid
inner join address on address.addressid = customeraddress.addressid
where customer.customerid in (
    select customer.customerid
    from customer
    inner join customeraddress on customer.customerid = customeraddress.customerid
    inner join address on address.addressid = customeraddress.addressid
    group by customer.customerid
    having count(*) > 1
-- returns all the companies that have a double address and by looking at them we can 
-- see what companies are not in the list of duplicates: this is inefficient( come back to it)
-- we do see that no London firms have a double address 
	
--Task 6: How many unique companies are located in the US state of Oregon?
select count(distinct customer.customerid) as company_count
from customer
join customeraddress on customer.customerid = customeraddress.customerid
join address on address.addressid = customeraddress.addressid
where lower(address.stateprovince) = lower('Oregon')
	
-- Task 9: If you take all the customers with first name "John" and CROSS JOIN 
--them to all the customers with first name "Margaret," how many rows will your query return? (7 & 8 were MCQ) 
with johnresults as (
    select customer.firstname
    from customer
    where customer.firstname = 'John'
),
margaret_results as (	
    select customer.firstname
    from customer
    where customer.firstname = 'Margaret'
)
	
select johnresults.firstname as john, margaret_results.firstname as margaret
from johnresults 
cross join margaret_results;
-- answer is 30 
	
 