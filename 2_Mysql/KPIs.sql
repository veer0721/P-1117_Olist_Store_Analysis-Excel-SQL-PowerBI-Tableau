-- KPI 1: Weekday vs Weekend Payment Statistics
-- KPI 2: Count of Orders with Review Score 5 and Payment Type as Credit Card
-- KPI 3: Average Delivery Time for Pet Shop Products
-- KPI 4: Average Order Price and Payment Amount for Customers in São Paulo
-- KPI 5: Relationship Between Shipping Days and Review Scores


use olist_ecommerce;

-- KPI 1: Weekday vs Weekend Payment Statistics where payment ill notify as revenue receipt
select * from orders;
create table KPI1 as 
SELECT o.day_purchase,CONCAT(ROUND(SUM(p.payment_value) / 1000000, 2),'M') AS revenue,
CONCAT(ROUND(SUM(p.payment_value) * 100 /SUM(SUM(p.payment_value)) OVER(),2),'%') AS contribution
FROM orders o LEFT JOIN order_payment p ON o.order_id = p.order_id
GROUP BY o.day_purchase;

select * from KPI1;



-- KPI 2: Count of Orders with Review Score 5 and Payment Type as Credit Card
create table KPI2 as
SELECT 
    p.payment_type,concat(round(COUNT(p.order_id)/1000,1),'K') AS total_orders
FROM order_payment p
JOIN order_reviews r 
    ON p.order_id = r.order_id
WHERE r.review_score = 5 group by payment_type ;

select * from KPI2;






-- KPI 3: Average Delivery Time for Pet Shop Products

CREATE TABLE KPI3 AS
SELECT p.product_category_name_english as product_category,
    concat(ROUND(AVG(i.duration)),' Days') AS avg_delivery_time
FROM order_item as i
JOIN products as p 
    ON i.product_id = p.product_id
WHERE p.product_category_name_english like '%pet_shop%'
GROUP BY p.product_category_name_english;


-- KPI 4: Average Order Price and Payment Amount for Customers in São Paulo

CREATE TABLE KPI4 AS
SELECT (SELECT DISTINCT c.customer_city FROM orders o JOIN customers c  ON o.customer_id = c.customer_id WHERE LOWER(c.customer_city) = 'sao paulo') AS customer_city,
(SELECT ROUND(AVG(p.payment_value),1) FROM order_payment p JOIN orders o  ON p.order_id = o.order_id JOIN customers c  ON o.customer_id = c.customer_id WHERE LOWER(c.customer_city) = 'sao paulo') AS avg_pv,
(SELECT ROUND(AVG(i.price),1) FROM order_item i JOIN orders o  ON i.order_id = o.order_id JOIN customers c  ON o.customer_id = c.customer_id WHERE LOWER(c.customer_city) = 'sao paulo') AS avg_price;





-- KPI 5: Relationship Between Shipping Days and Review Scores
create table KPI5 as
select r.review_score as review_score,concat(ceil((avg(i.duration))), ' Days')as Average_delivery from order_item as i left join order_reviews as r
on i.order_id=r.order_id  where r.review_score is not null group by r.review_score ;


-- kpi 6
create table KPI6 as 
SELECT y.Years,(SELECT ROUND(AVG(p.payment_value),1) FROM order_payment p JOIN orders o ON p.order_id = o.order_id WHERE o.Years = y.Years) AS avg_pv,
(SELECT ROUND(AVG(i.price),1) FROM order_item i JOIN orders o ON i.order_id = o.order_id WHERE o.Years = y.Years) AS avg_price from (SELECT DISTINCT Years FROM orders) y ORDER BY y.Years;


-- kpi7
create table KPI7 as 
select payment_type,concat(round(count(*)/1000,1),' K') as order_count from order_payment group by payment_type;





select * from KPI1;
select * from KPI2;
select * from KPI3;
select * from KPI4;
select * from KPI5;
select * from KPI6;
select * from KPI7;





