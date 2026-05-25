create database Olist_ecommerce;
use olist_ecommerce;


create table customers
(customer_id varchar(35) not null,
customer_unique_id varchar(35)  not null,
customer_zip_code int  not null,
customer_city varchar(255)  not null,
customer_state varchar(16) not null);
desc customers;
select @@secure_file_priv;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\customers.csv'
into table customers
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
select * from customers;

create table geolocation(geolocation_zip_code int,
geolocation_city varchar(255) not null,
geolocation_state varchar(16)  not null);
desc geolocation;
select @@secure_file_priv;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\geolocation.csv'
into table geolocation
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;
select * from geolocation;


create table order_item(
order_id varchar(35) not null,
order_item_id int not null,
product_id varchar(35) not null,
seller_id varchar(35) not null,
shipping_limit_date varchar(50) not null,
price decimal(10,2) not null,
freight_value decimal(10,2) not null,
order_purchase_timestamp varchar(50) not null,
order_delivered_customer_date varchar(50) not null,
order_estimated_delivery_date varchar(50) not null,
duration int not null);
desc order_item;
select @@secure_file_priv;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\order_item.csv'
INTO TABLE order_item
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@order_id,
 @order_item_id,
 @product_id,
 @seller_id,
 @shipping_limit_date,
 @price,
 @freight_value,
 @order_purchase_timestamp,
 @order_delivered_customer_date,
 @order_estimated_delivery_date,
 @duration)
SET
order_id = @order_id,
order_item_id = @order_item_id,
product_id = @product_id,
seller_id = @seller_id,
shipping_limit_date = @shipping_limit_date,
price = @price,
freight_value = @freight_value,
order_purchase_timestamp = @order_purchase_timestamp,
order_delivered_customer_date = @order_delivered_customer_date,
order_estimated_delivery_date = @order_estimated_delivery_date,
duration =
    CASE
        WHEN TRIM(@duration) REGEXP '^[0-9]+$'
        THEN TRIM(@duration)
        ELSE 0
    END;
select * from order_item;
desc order_item;


create table order_payment(order_id varchar(35) not null,
payment_sequential int not null,
payment_type varchar(16) not null,
payment_installments int not null,
payment_value decimal(10,2) not null);
desc order_payment;
select @@secure_file_priv;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\order_payment.csv'
INTO TABLE order_payment
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from order_payment;
desc order_payment;



create table order_reviews(
review_id varchar(35) not null,
order_id varchar(35) not null,
review_score int not null,
review_creation_date varchar(50) not null,
review_answer_timestamp varchar(50) not null,
duration int);
desc order_reviews;
select @@secure_file_priv;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\order_reviews.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@review_id,
 @order_id,
 @review_score,
 @review_creation_date,
 @review_answer_timestamp,
 @duration)
SET
review_id = @review_id,
order_id = @order_id,
review_score = @review_score,
review_creation_date = @review_creation_date,
review_answer_timestamp = @review_answer_timestamp,
duration =
    CASE
        WHEN TRIM(@duration) REGEXP '^[0-9]+$'
        THEN TRIM(@duration)
        ELSE 0
    END;
select * from order_reviews;



create table orders(
order_id varchar(35) not null,
customer_id varchar(35) not null,
order_status varchar(35) not null,
order_purchase_timestamp varchar(50) not null,
order_approved_at varchar(50) not null,
order_delivered_carrier_date varchar(50) not null,
order_delivered_customer_date varchar(50) not null,
order_estimated_delivery_date varchar(50) not null,
day_purchase varchar(16) not null,
duration int ,
customer_city varchar(255) not null,
customer_state varchar(16) not null,
Years year not null);
desc orders;
select @@secure_file_priv;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@order_id,
@customer_id, 
@order_status,
@order_purchase_timestamp,
@order_approved_at,
@order_delivered_carrier_date,
@order_delivered_customer_date,
@order_estimated_delivery_date,
@day_purchase,
@duration,
@customer_city,
@customer_state,
@years)
SET
order_id = @order_id,
customer_id = @customer_id,
order_status = @order_status,
order_purchase_timestamp = @order_purchase_timestamp,
order_approved_at = @order_approved_at,
order_delivered_carrier_date = @order_delivered_carrier_date,
order_delivered_customer_date = @order_delivered_customer_date,
order_estimated_delivery_date = @order_estimated_delivery_date,
day_purchase = @day_purchase,
duration =duration = CASE
              WHEN TRIM(@duration) REGEXP '^[0-9]+$'
              THEN TRIM(@duration)
              ELSE 0
           END,
customer_city = @customer_city,
customer_state = @customer_state,
Years = NULLIF(TRIM(@years), '');

select * from orders;
desc orders;







create table products(product_id varchar(35) not null,
product_category_name varchar(255) not null,
product_category_name_english varchar(255) not null);
desc products;
select @@secure_file_priv;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from products;


create table sellers(
seller_id varchar(35) not null,
seller_zip_code int not null,
seller_city varchar(255) not null,
seller_state varchar(16) not null);
desc sellers;
select @@secure_file_priv;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sellers.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from sellers;




create table product_category_name_translation(
product_category_name varchar(255) not null,product_category_name_english varchar(255) not null);
desc product_category_name_translation;
select @@secure_file_priv;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from product_category_name_translation;

select * from customers;
select * from geolocation;
select * from order_item;
select * from order_payment;
select * from order_reviews;
select * from orders;
select * from products;
select * from sellers;
select * from product_category_name_translation;

