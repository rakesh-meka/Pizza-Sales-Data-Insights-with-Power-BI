select *from pizza_sales;

-- A. KPI’s

--1.Total_Revenue:

select sum(total_price) as Total_Revenue from pizza_sales;


-- 2. Average order value:

select sum(total_price)/ count(distinct order_id) as Avg_order_value 
from pizza_sales;

-- 3. Total Pizza Sold:

select sum(quantity) as Total_Pizza_Sold from pizza_sales;

-- 4. Total Orders:

select count(distinct order_id) as Total_orders from pizza_sales;

-- 5. Average Pizzas per Orders:

select cast (cast(sum(quantity) as decimal(10,2)) /
cast(count( distinct order_id) as decimal(10,2))as decimal(10,2))
as Avg_Pizzas_Per_Order from pizza_sales

--B. Problem Statements

-- 1. Daily Trends for Total_Orders:

select DATENAME(DW, order_date) as Order_day, 
count( distinct order_id) as Total_orders from pizza_sales
group by DATENAME(DW, order_date)
order by Total_orders desc;

-- 2. Monthly Trends for Total Orders:

select DATENAME(Month, order_date) as Month_name, 
Count( Distinct Order_id) as Total_Orders from pizza_sales
group by DATENAME(Month, order_date)
order by Total_Orders desc;

--3. Percentage of Sales by Pizza Category

SELECT pizza_category, cast (sum(total_price) as decimal(10,2)) as Total_Sales,
        cast( sum(total_price) * 100 / (SELECT sum(total_price) FROM pizza_sales) as decimal(10,2)) AS Sale_PCT
FROM pizza_sales
GROUP BY pizza_category;

-- 4. Percentage of Sales by Pizza Size

SELECT pizza_size, cast (sum(total_price) as decimal(10,2)) as Total_Sales,
        cast( sum(total_price) * 100 / (SELECT sum(total_price) FROM pizza_sales where DATEPART(Quarter, order_date) = 1) as decimal(10,2)) AS Sale_PCT
FROM pizza_sales
where DATEPART(Quarter, order_date) = 1
GROUP BY pizza_size
order by Sale_PCT desc;

-- 5. Top 5 Pizzas by Revenue:

select Top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_revenue desc;

-- 6. Bottom 5 Pizzas by Revenue:

select Top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_revenue asc;

-- 7. Top 5 Pizzas by Quantity:

select Top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity desc;

--8. Bottom 5 Pizzas by Quantity

select Top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity asc;

--9. Top 5 Pizzas by orders:

select Top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders desc;

-- 10. Bottom 5 Pizzas by Orders: 

select Top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders asc;




