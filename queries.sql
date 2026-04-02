create database ecommerce_project;
use  ecommerce_project;
select database()

create table customers (
customer_id int primary key
auto_increment,
name varchar(100),
email varchar(100),
city varchar(50),
signup_date date
);

select*from customers;


create table users (
user_id varchar(20),
name varchar(100),
email varchar(100),
gender varchar(10),
city varchar(100),
signup_date date
);

select*from users limit 10;

create table products (
product_id varchar(20) primary key,
product_name varchar(200),
category varchar(100),
brand varchar(100),
price decimal(10,2),
rating decimal(3,2)
); 

select*from products limit 10;

create table orders (
order_item_id varchar(20) primary key,
order_id varchar(20),
product_id varchar(20),
user_id varchar(20),
quantity int,
order_date datetime,
order_status varchar(50),
total_amount decimal(10,2),

foreign key (user_id) references
users(user_id)
);

alter table users
add primary key (user_id);

drop table if exists orders;

select*from orders limit 10;

create table order_items(
order_item_id varchar(20) primary key,
order_id varchar(20),
product_id varchar(20),
user_id varchar(20),
quantity int,
item_price decimal(10,2),
item_total decimal(10,2),

foreign key (order_id) references
orders(order_id),
foreign key(product_id)
references products(product_id),
foreign key (user_id) references
users(user_id)
);

drop table order_items;

select count(*)from order_items;

select sum(item_total) as total_revenue 
from order_items;

select p.product_name,
sum(oi.quantity) as total_sold
from order_items oi
join products p
on oi.product_id=p.product_id
group by p.product_name
order by total_sold desc
limit 5;

select u.name, sum(oi.item_total)as
total_spent
from order_items oi
join users u
on oi.user_id=u.user_id
group by u.name
order by total_spent desc
limit 5;

select p.category, sum(oi.item_total)as
total_sales
from order_items oi
join products p
on oi.product_id=p.product_id
group by p.category
order by total_sales desc;

select date_format(o.order_date,'%y-%m') as month,
sum(oi.item_total) as revenue
from order_items oi
join orders o
on oi.order_id=o.order_id
group by month
order by month;

select u.name, p.category,
sum(oi.item_total) as total_spent
from order_items oi
join users u on oi.user_id=u.user_id
join products p on oi.product_id=
p.product_id
group by u.name,p.category
order by total_spent desc
limit 10;

use ecommerce_project;
select database();
select
p.category,
count(distinct oi.order_id) as
total_orders,
sum(oi.quantity)as total_items_sold,
sum(oi.item_total)as total_revenue,
round(avg(oi.item_total),2)as
avg_order_value
from order_items oi
join products p on oi.product_id =
p.product_id
group by p.category
order by total_revenue desc;

select count(*)from order_items;

select p.category, sum(oi.item_total)as
total_revenue
from order_items oi
join products p
on oi.product_id=p.product_id
group by p.category
order by total_revenue desc;