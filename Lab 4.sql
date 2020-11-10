-- Lab | Advanced SQL and Pivot tables

use sakila;

--  1- Select the first name, last name, and email address of all the customers who have rented a movie.


select distinct(concat(first_name,' ',last_name)) AS full_name,email from customer c
right join rental r
on c.customer_id=r.customer_id;


--  2- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select concat(first_name,' ',last_name) AS full_name,avg(amount) as avg_payment from customer c
right join payment p
on c.customer_id=p.customer_id
group by full_name;



--  3- Select the name and email address of all the customers who have rented the "Action" movies.
        
--    a- Write the query using multiple join statements

select concat(first_name,' ',last_name) AS full_name, email, ca.name from customer c
right join rental r
on c.customer_id=r.customer_id
join inventory i
on r.inventory_id=i.inventory_id
join film_category fc
on i.film_id=fc.film_id
join category ca
on fc.category_id=ca.category_id
where ca.name = 'Action'
group by full_name;



--    b- Write the query using sub queries with multiple WHERE clause and IN condition

select concat(first_name,' ',last_name) AS full_name, email from customer c
where customer_id in (
select customer_id from rental
where inventory_id in(
select  inventory_id from inventory
where film_id in (
select film_id from film_category 
where category_id in (
select category_id from category
where name = 'Action'))))
group by full_name;





--    c- Verify if the above two queries produce the same results or not






--    4-Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
 
 select *,
 (case when amount < 2 then 'Low'
 when amount between 2 and 4 then 'Medium'
 when amount > 4 then 'High'
 end ) as trans_class from payment;