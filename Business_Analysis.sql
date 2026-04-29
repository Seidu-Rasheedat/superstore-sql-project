--- BUSINESS OVERVIEW
-- Total Sales, Profit, Orders: This query provides a high-level summary of overall business performance, including total revenue, total profit, and the number of unique orders.
SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;


--- SALES ANALYSIS
-- Sales by Region: This query analyzes how revenue is distributed across different regions, helping identify the highest-performing markets by total sales.
SELECT 
    region,
    SUM(sales) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- Monthly Sales Trend: This query tracks sales performance over time by aggregating revenue monthly, helping identify trends, seasonality, and periods of growth or decline.
SELECT 
    FORMAT(order_date, 'yyyy-MM') AS month,
    SUM(sales) AS monthly_sales
FROM orders
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;

-- Running total of sales over time: This query calculates cumulative sales over time by adding each day's revenue, to a running total, helping visualize overall business growth and performance trends.
SELECT 
    order_date,
    SUM(sales) AS daily_sales,
    SUM(SUM(sales)) OVER (ORDER BY order_date) AS running_total
FROM orders
GROUP BY order_date
ORDER BY order_date;


---CUSTOMER ANALYSIS
-- Top Customers: This query identifies the highest-value customers based on total spending, helping highlight key contributors to revenue and potential targets for retention strategies.
SELECT TOP 10
    c.customer_name,
    SUM(o.sales) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Customer Segments Contribution: This query evaluates how each customer segment contributes to total sales, helping understand which groups drive revenue and inform targeted marketing strategies.
SELECT 
    c.segment,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.segment;


---PRODUCT PERFORMANCE
-- Top Selling Products: This query identifies the highest-revenue products based on total sales, helping highlight best-performing items and inform product and inventory strategies.
SELECT TOP 10
    product_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC;

-- Most Ordered Categories: This query measures demand by aggregating total quantities sold per category, helping identify which product categories are most frequently purchased.
SELECT 
    category,
    SUM(quantity) AS total_quantity
FROM orders
GROUP BY category
ORDER BY total_quantity DESC;


---PROFITABILITY ANALYSIS
-- Loss-making Products: This query identifies products generating negative total profit, helping uncover underperforming items that may require pricing or cost adjustments.
SELECT 
    product_name,
    SUM(profit) AS total_profit
FROM orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;

-- Profit by Region: This query evaluates profitability across regions by aggregating total profit, helping identify the most and least profitable markets beyond just revenue.
SELECT 
    region,
    SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_profit DESC;


--- ORDER DELIVERY ANALYSIS
-- Shipping time analysis: This query measures the average shipping time and total number of orders, helping evaluate overall delivery performance and operational efficiency.
SELECT 
    AVG(DATEDIFF(day, order_date, ship_date)) AS avg_shipping_days,
    COUNT(*) AS total_orders
FROM orders;


---BUSINESS INSIGHTS
-- Impact of discount on profitability: This query evaluates how different discount levels affect profitability, helping assess whether discount strategies drive sales at the expense of profit.
SELECT 
    discount,
    COUNT(*) AS total_orders,
    SUM(sales) AS total_sales,
    AVG(profit) AS avg_profit,
    SUM(profit) AS total_profit,
    RANK() OVER (ORDER BY AVG(profit) DESC) AS profit_rank
FROM orders
GROUP BY discount
ORDER BY discount;

-- Cities generating highest profit: This query identifies the cities generating the highest total profit, helping highlight key locations that contribute most to overall profitability.
SELECT TOP 10
    city,
    SUM(profit) AS total_profit
FROM orders
GROUP BY city
ORDER BY total_profit DESC;

-- Shipping time distribution: This query shows how many orders fall into each shipping duration, helping understand the distribution of delivery times.
SELECT 
    DATEDIFF(day, order_date, ship_date) AS shipping_days,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATEDIFF(day, order_date, ship_date)
ORDER BY shipping_days;






