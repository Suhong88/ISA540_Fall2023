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

select customer.customer_id, concat(first_name,' ', last_name) as name, payment_date
from customer
inner join payment on customer.customer_id=payment.customer_id
where active=1 and store_id=1 and extract (month from payment_date)=5;

-- 2. display number of customers by country. 
-- Sort the list by country with the highest number of customer

select country, count(*)
from customer
inner join address on customer.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id
group by 1
order by 2 desc;


-- 3 find the total payment by customer. sort the list with the highest payment first.

select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount)as total_sales
from customer
inner join payment on customer.customer_id=payment.customer_id
group by 1,2
order by 3 desc;

-- 4. find the highest payment amount of all customers. 
--    Display the highest amount.

select max(total_sales) as highest_sales
from
(select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount)as total_sales
from customer
inner join payment on customer.customer_id=payment.customer_id
group by 1,2) t;

-- 5. find the customer ID and name who has the highest sales

with highest_sales (highest) as 
(select max(total_sales)
from
(select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount)as total_sales
from customer
inner join payment on customer.customer_id=payment.customer_id
group by 1,2) t)

select customer.customer_id, concat(first_name,' ', last_name) as name
from customer
inner join payment on customer.customer_id=payment.customer_id
group by 1,2
having sum(amount)=(select highest from highest_sales);

-- option 2 using rank function

select customer_id, name, total_sales
from
(select customer.customer_id, concat(first_name,' ', last_name) as name, 
       sum(amount)as total_sales,
	   rank() over(order by sum(amount) desc)
from customer
inner join payment on customer.customer_id=payment.customer_id
group by 1,2) t
where rank=1;

select *
from inventory;

-- 6. find the most popular title based on total sales

select title, sum(amount) as total_sales
from film
inner join inventory on film.film_id=inventory.film_id
inner join rental on inventory.inventory_id=rental.inventory_id
inner join payment on rental.rental_id= payment.rental_id
group by 1
order by 1
limit 1;

-- 7. find the most popular title in each month based on total sales

select *
from
(select title, extract(month from payment_date) as month, sum(amount) as total_sales,
       rank() over(partition by extract(month from payment_date) order by sum(amount) desc)
from film
inner join inventory on film.film_id=inventory.film_id
inner join rental on inventory.inventory_id=rental.inventory_id
inner join payment on rental.rental_id= payment.rental_id
group by 1,2) t
where rank=1;

-- 8. find the top 3 most popular title in each month based on total sales

select *
from
(select title, extract(month from payment_date) as month, sum(amount) as total_sales,
       rank() over(partition by extract(month from payment_date) order by sum(amount) desc)
from film
inner join inventory on film.film_id=inventory.film_id
inner join rental on inventory.inventory_id=rental.inventory_id
inner join payment on rental.rental_id= payment.rental_id
group by 1,2
where rank<=3;
 
-- 9. display average rental rate and length by rating
 
select rating, round(avg(rental_rate),2) as rental_rate, round(avg(length),2) as avg_length
from film
group by 1;