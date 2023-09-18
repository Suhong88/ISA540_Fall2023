-- show today's date

select current_date;

-- generate a random number between 0 and 1
select random();

-- display the first five customer in customer table

select *
from customer
limit 5;

-- display full name of first five customers

select concat(first_name,' ', last_name) as name
from customer
limit 5;

-- WHERE clause
-- comparision operator <, <=, >, >=, = and <>

-- display name of activate customer. limit to five customers.

select concat(first_name,' ', last_name) as name, active
from customer
where active=1
limit 5

-- display name of activate customer who shopped in store 1. limit to five customers

select concat(first_name,' ', last_name) as name, active, store_id
from customer
where active=1 and store_id=1
limit 5

-- JOIN Clause

-- display name of all customers in India

select concat(first_name,' ', last_name) as name, country
from customer
inner join address on customer.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id
where country='India';

-- GROUP BY clause

-- display number of customers by country. 

select country, count(customer_id) as Number_of_Customers
from customer
inner join address on customer.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id
group by country;

-- modify the above query to display the top 5 countries with the most customers

select country, count(customer_id) as Number_of_Customers
from customer
inner join address on customer.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id
group by country
order by Number_of_Customers desc
limit 5;

-- visualize the above result

-- subquery

-- display total sales by customer

select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount) as total_sales
from customer
inner join rental on customer.customer_id=rental.customer_id
inner join payment on rental.rental_id=payment.rental_id
group by 1,2;

-- display average sales by all customers

select round(avg(total_sales),2) as average_sales
from
(select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount) as total_sales
from customer
inner join rental on customer.customer_id=rental.customer_id
inner join payment on rental.rental_id=payment.rental_id
group by 1,2) t

-- display customer whose total sales are over the average sales of all customers

select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount) as total_sales
from customer
inner join rental on customer.customer_id=rental.customer_id
inner join payment on rental.rental_id=payment.rental_id
group by 1,2
having sum(amount)> (select round(avg(total_sales),2) as average_sales
		from
		(select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount) as total_sales
		from customer
		inner join rental on customer.customer_id=rental.customer_id
		inner join payment on rental.rental_id=payment.rental_id
		group by 1,2) t);

-- alternative approach

with average_sales (average_sales) as 
(select round(avg(total_sales),2)
from
(select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount) as total_sales
from customer
inner join rental on customer.customer_id=rental.customer_id
inner join payment on rental.rental_id=payment.rental_id
group by 1,2) t)

select customer.customer_id, concat(first_name,' ', last_name) as name, sum(amount) as total_sales
from customer
inner join rental on customer.customer_id=rental.customer_id
inner join payment on rental.rental_id=payment.rental_id
group by 1,2
having sum(amount)> (select average_sales from average_sales);


