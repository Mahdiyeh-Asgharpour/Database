-- 1
SELECT first_name, last_name from staff;
--2
select customer_id , last_name , first_name from customer
order by last_name
--3
SELECT city_id,city from city
where country_id=60;
--4
SELECT * FROM customer
WHERE first_name LIKE 'J%' and store_id=1;
--5
SELECT  *  FROM film 
where rental_rate=(select max(rental_rate) from film)
limit 5;
--6
SELECT DISTINCT amount FROM payment;
--7
SELECT count( customer_id )  from payment
WHERE  amount IN (0.99,4.99,0.00);
--8
select count(distinct customer_id) from rental;

--9
select distinct customer_id from rental;

--10
select count(rating),rating from film 
group by rating;
--امتیازی
--1
select customer.first_name ,customer.last_name ,payment.*
from customer
left join payment
on customer.customer_id=payment.customer_id
where payment.customer_id=344 and payment_date between '#2007-02-15'
and'#2007-02-20';

--2
SELECT first_name || ' ' || last_name as full_name FROM customer;
--3
update film
set rental_rate= Round(rental_rate*'0.8',2);
SELECT * from film;

