-- Take home. Please complete the following questions using SQL. Please show the first five 
-- rows of the results at the bottom.
 
-- for example. Display number of customers by country. 
-- Sort the list by country with the highest number of customer first

select country, count(*)
from customer
inner join address on customer.address_id=address.address_id
inner join city on address.city_id=city.city_id
inner join country on city.country_id=country.country_id
group by 1
order by 2 desc;

/* result
country","count"
"India","60"
"China","53"
"United States","36"
"Japan","31"
"Mexico","30"
 */
 
-- 1. display number of movies by category
 
 
 
 
 
 -- 2. display number of movies by category by rating
 
 
 
 
 
 -- 3. display name of the the actor who appears in the most movies
 
 
 
 
 
-- 4. display the title and description of movies for the actor who appear in the most movies
 
 
 
 
 
 -- 5. what is the minimum, maximum, and average days of a customer keeping a dvd

 
 
 
 
 
 -- 6. display total sales by store and by movie category
 
 
 
 
 
--  7. display top 3 category in each store based on total sales
 
 
 
 
 
 
 -- 8. display the top 10 films that are rentend out for the longest durations on average?
 
 
 
 
 

/* Assume you are the owner of this DVD rental store,
 develop 10 questions you would like to investigate that would help you to
 understand your business and hopefully make your business more successfully.
 develop the query to answer two questsions out of 10 questions you developed, 
 your query need to include at least group by or subquery function.*/
 
