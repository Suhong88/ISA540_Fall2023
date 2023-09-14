-- In class demo (based on devrental database)
/*
step 1: identify the primary key and foreign keys in each table. Understand how they are related.
Step 2: understand your data: (data type in each table, how many customers, 
how many stores, how many movies, time period of data)
any other information you want to ask
*/

select column_name, data_type
from information_schema.columns
where table_name='rental';

select count(*)
from customer;

select count(*)
from store;

select count(*)
from film;

select count(*)
from category;

select distinct extract(year from rental_date)
from rental;

select distinct to_char(rental_date, 'YYYY-mm') as year_month
from rental
order by 1;

-- 1. find all activate customers who shopped in store 1 and have made a payment in May.
-- Display customer_id, customer name, payment_date. limit to first 10 records. 





-- 2. display number of customers by country. 
-- Sort the list by country with the highest number of customer






-- 3 find the total payment by customer. sort the list with the highest payment first.





-- 4. find the highest payment amount of all customers. 
--    Display the highest amount.





-- 5. find the customer ID and name who has the highest sales





-- 6. find the most popular title based on total sales





-- 7. find the most popular title in each month based on total sales





-- 8. find the top 3 most popular title in each month based on total sales





 
-- 9. display average rental rate and length by rating
 
