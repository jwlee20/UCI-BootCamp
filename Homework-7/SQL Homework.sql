-- SQL Homework

USE sakila;

-- 1a
select * from actor;

-- 1b
select concat(first_name," ", last_name) as 'Actor name'
from actor;

-- 2a
SELECT *
FROM actor
where first_name like 'Joe%';

-- 2b
SELECT *
FROM actor
where last_name like '%Gen%';

-- 2c
select last_name, first_name
from actor
where last_name like '%LI%';

-- 2d
select country_id, country
from country;

-- 3a
select * from actor;
alter table actor
modify column description blob;

-- 3b
alter table actor
drop column description;

-- 4a
select last_name from actor;
select last_name,count(*) as 'Count' from actor
group by last_name;

-- 4b
select last_name,count(*) as 'Count' from actor
group by last_name
having count(*) > 2;

-- 4c

update actor set first_name = 'HARPO' where first_name = 'GROUCHO' and last_name ='WILLIAMS';
select first_name,last_name from actor where last_name = 'WILLIAMS';

-- 4d

update actor set first_name = 'GROUCHO' where first_name = 'HARPO' and last_name = 'WILLIAMS';
select first_name,last_name from actor where first_name = 'HARPO' or first_name='GROUCHO';

-- 5a

show create table address;
select * from address;

-- 6a

select * from staff;
select * from address;

select address, first_name, last_name from address
join staff on staff.address_id = address.address_id;


-- 6b
select * from staff;
select * from payment;

select first_name, last_name, sum(amount) from staff,payment
where staff.staff_id = payment.staff_id and payment.payment_date like '2005-08%'
group by first_name,last_name;

-- 6c

select * from film_actor;
select * from film;

select title, count(actor_id) as 'Actor Count' from film_actor
inner join film on film.film_id = film_actor.film_id
group by title;

-- 6d
select * from inventory;
select * from film;

select title, count(title) as 'Count' from film
where inventory.film_id = film.film_id and title = 'Hunchback Impossible';

-- 6e

select * from payment;
select * from customer;

select first_name,last_name,sum(amount) as 'Total Amount' from payment
join customer on customer.customer_id = payment.customer_id
group by first_name,last_name;

-- 7a
select * from film;
select * from language;

select title from film
join language as l on film.language_id = l.language_id
where l.name = 'English'  and (film.title like 'K%' or film.title like 'Q%');

-- 7b
select * from film; -- film_id, title
select * from film_actor; -- film_id, actor_id
select * from actor; -- actor_id

select film.title, actor.first_name,actor.last_name,count(film_actor.film_id) as 'Count' from film,film_actor,actor
where actor.actor_id = film_actor.actor_id and film_actor.film_id = film.film_id and title = 'Alone Trip'
group by first_name,last_name;

-- 7c
select * from country;  -- country_id
select * from city; -- country_id, city_id
select * from address; -- city_id, address_id
select * from customer; -- address_id

select customer.first_name, customer.last_name,customer.email,country.country from customer , address, city, country
where customer.address_id = address.address_id and address.city_id = city.city_id and city.country_id = country.country_id and country.country= 'Canada';

-- 7d
select * from film_category;  -- film_id, category_id
select * from category; -- category_id, name='family'
select * from film; -- film_id, title

select film.title from film_category,category,film
where film.film_id = film_category.film_id and film_category.category_id = category.category_id and category.name = 'family';

-- 7e
select * from rental;  -- rental_id, inventory_id
select * from film; -- film_id
select * from inventory; -- film_id, inventory_id

select film.title,count(rental.rental_id) as 'Count' from rental,film,inventory
where rental.inventory_id = inventory.inventory_id and inventory.film_id = film.film_id
group by film.title order by count desc;

-- 7f
select * from payment; -- customer_id,amount
select * from customer; -- customer_id,address_id
select * from address; -- address_id, address

select address.address,sum(payment.amount) from payment, customer, address
where payment.customer_id = customer.customer_id and customer.address_id = address.address_id
group by address.address;

-- 7g

-- STORE ID ONLY EXISTS FOR ADDRESS ID 1 AND 2... HOW DO YOU INCLUDE STORE ID NULL?
select * from address; -- address_id, city_id, address
select * from store; -- address_id, store_id
select * from city; -- city_id, country_id
select * from country; -- country_id, country

select address.address,store.store_id,city.city,country.country from address
left join store on address.address_id = store.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;

-- 7h
select * from category; -- name, category_id
select * from film_category; -- caetgory_id, film_id
select * from inventory; -- film_id, inventory_id
select * from rental; -- inventory_id, rental_id
select * from payment; -- rental_id, amount

select category.name, sum(payment.amount) as 'payp' from category, film_category, inventory, rental, payment
where payment.rental_id = rental.rental_id and rental.inventory_id = inventory.inventory_id and inventory.film_id = film_category.film_id and film_Category.category_id = category.category_id
group by category.name order by payp desc;

-- 8a

create view topgenres as 
select category.name, sum(payment.amount) as 'payp' from category, film_category, inventory, rental, payment
where payment.rental_id = rental.rental_id and rental.inventory_id = inventory.inventory_id and inventory.film_id = film_category.film_id and film_Category.category_id = category.category_id
group by category.name order by payp desc;

-- 8b

select * from topgenres;

-- 8c

drop view topgenres;
