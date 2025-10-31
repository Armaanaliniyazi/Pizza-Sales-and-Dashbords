CREATE TABLE pizza_sales (
    pizza_id            INT,
    order_id            INT,
    pizza_name_id       VARCHAR(50),
    quantity            INT,
    order_date          DATE,
    order_time          TIME,
    unit_price          NUMERIC(10,2),
    total_price         NUMERIC(10,2),
    pizza_size          VARCHAR(50),
    pizza_category      VARCHAR(200),
    pizza_ingredients   VARCHAR(300),  -- changed from 100
    pizza_name          VARCHAR(50)
);

select * from pizza_sales

--  Q1 Total Revenue - The sum of the total price of all pizza orders

select sum(total_price) as total_revenue
from pizza_sales

--Q2 Average order value - The average amount spent perorder calculate by dividing the total revenue by
-- total number of orders

select sum(total_price) / count(distinct order_id) as avg_orders
from pizza_sales

--Q3 Total pizza sold - The sum of the quantities of all pizza sold

select sum(quantity) as total_sold
from pizza_sales

--Q4 Total Order - The total number of order placed 

select count(distinct order_id) as total_order
from pizza_sales

--Q5 Average Pizza per order - The average number of pizza sold per order calculated by dividing the total number
-- of pizza sold by the total number of order

select * from pizza_sales

select 
cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as avg_pizza 
from pizza_sales

-- Second Method Uses

SELECT 
    ROUND(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id), 2) AS avg_pizza
FROM 
    pizza_sales;

--Q6 Daily trend for total orders

select 
to_char(order_date, 'Day') as order_day,
count(distinct order_id) as total_orders
from pizza_sales
group by to_char(order_date, 'Day')

--Q7 Monthly trend for total orders

select 
to_char(order_date, 'Month') as order_month,
count(distinct order_id) as total_orders
from pizza_sales
group by to_char(order_date, 'Month')

--Q8 Percentage of sales by pizza category

select * from pizza_sales

select pizza_category,
sum(total_price) as total_revenue,
round(sum(total_price) * 100 / (select sum(total_price) from pizza_sales),2) as percentage_sales
from pizza_sales
where extract(Month from order_date) = 1
group by pizza_category

-- that output show only jan using where clause function

--Q9 -- Percentage of sales by pizza size

select pizza_size,
sum(total_price) as total_revenue,
round(sum(total_price) * 100 / (select sum(total_price) from pizza_sales),2) as percentage_sales
from pizza_sales
group by pizza_size
order by total_revenue desc

-- Q10 Top 5 best sellers by revenue. total price and total orders

select * from pizza_sales

select pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5

-- Q11 Top 5 best bottom sellers by revenue. total price and total orders

select pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc
limit 5

-- Q12 Top 5 best sellers by revenue. total quantity and total orders

select pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5

-- Q13 Top 5 best bottom sellers by revenue. total quantity and total orders

select pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity asc
limit 5

-- Q14 Top 5 best sellers by revenue. only total orders

select pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc
limit 5

-- Q15 Top 5 best bottom sellers by revenue. only total orders

select pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders asc
limit 5



