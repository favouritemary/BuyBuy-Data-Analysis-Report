

/*1. Time-Profit Analysis*/

/*a. Write a query that returns the total profit made by BuyBuy from 1Q11 to 4Q16 (all
quarters of every year).*/

SELECT sales_year,
CASE
    WHEN month_column IN (1,2,3) THEN 'Q1'
    WHEN month_column IN (4,5,6) THEN 'Q2'
    WHEN month_column IN (7,8,9) THEN 'Q3'
    ELSE 'Q4'
   END AS Months_in_Quarter, Sum (profit) as total_profit
   FROM sales_data
   GROUP BY 1,2
   ORDER BY 1 ASC;
   
/*b. Write queries that return the total profit made by BuyBuy in Q2 of every year from
2011 to 2016.*/   
SELECT sales_year,
CASE
    WHEN month_column IN (1,2,3) THEN 'Q1'
    WHEN month_column IN (4,5,6) THEN 'Q2'
    WHEN month_column IN (7,8,9) THEN 'Q3'
    ELSE 'Q4'
   END AS Months_in_Quarter, Sum (profit) as total_profit
   FROM sales_data
   WHERE month_column IN (4,5,6)
   GROUP BY 1,2
   ORDER BY 1 ASC;

/*c. Write a query that returns the annual profit made by BuyBuy from the year 2011 to
2016.*/
SELECT sales_year, Sum (profit) AS Annual_Profit
FROM sales_data
GROUP BY 1

/*2. Region-Profit Analysis*/
/*a. Write 2 queries that return the countries where BuyBuy has made the most profit and
also the least profit of all-time. Your query must display both results on the same
output.*/
SELECT *
FROM (
SELECT cus_country, sum(profit) total_profit
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1) AS most_profit
UNION ALL
SELECT *
FROM
(SELECT cus_country, sum(profit) AS total_profit
FROM sales_data
GROUP BY 1
ORDER BY 2 ASC
LIMIT 1) AS least_profit;


SELECT *
FROM (
  SELECT cus_country, sum(profit) AS profit_sum
  FROM sales_data
  GROUP BY cus_country
  ORDER BY profit_sum DESC
  LIMIT 1
) AS most_profit
UNION ALL
SELECT *
FROM (
  SELECT cus_country, sum(profit) AS profit_sum
  FROM sales_data
  GROUP BY cus_country
  ORDER BY profit_sum ASC
  LIMIT 1
) AS least_profit;


/*b. Write a query that shows the Top-10 most profitable countries for BuyBuy sales
operations from 2011 to 2016*/

SELECT cus_country, sales_year, sum(profit) as total_profit
FROM sales_data
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10;


/*c. Write a query that shows the all-time Top-10 least profitable countries for BuyBuy
sales operations.*/

SELECT cus_country, sales_year, sum(profit) as total_profit
FROM sales_data
GROUP BY 1,2
ORDER BY 3 ASC
LIMIT 10;

/*3. Product-Revenue Analysis*/
/*a. Write a query that ranks all product categories sold by Buybuy, from least amount to
the most amount of all-time revenue generated.*/

SELECT prod_category,sum(revenue)
FROM sales_data
GROUP BY 1
ORDER BY 2 ASC;


/*b. Write a query that returns Top-2 product categories offered by Buybuy with an all-time
high number of units sold.*/
SELECT prod_category,sum(ord_quantity) as units_sold
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
Limit 2;


/*Write a query that shows the Top 10 highest-grossing products sold by BuyBuy based
on all-time profits.*/

SELECT product, sum(revenue) as total_revenue
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
Limit 10;

ALTER TABLE sales_data
RENAME COLUMN cost TO costs;

SELECT sales_year, sum(costs) AS total_costs, sum(revenue) AS total_revenue
FROM sales_data
GROUP BY 1;

-- Add the new column
ALTER TABLE sales_data ADD COLUMN sales numeric;
-- Calculate and update the sales column
UPDATE sales_data SET sales = ord_quantity * unit_price;


SELECT sales_year, sum(sales) AS total_sales, sum(revenue) AS total_revenue
FROM sales_data
GROUP BY 1;

SELECT cus_country,
CASE
	WHEN cus_age <= 30 THEN 'Youths'
    WHEN cus_age <= 45 THEN 'Young Adults'
    WHEN cus_age <= 60 THEN 'Adults'
    ELSE 'Seniors'
  END AS age_band, sum(revenue) as revenue
FROM sales_data
GROUP BY 1,2
ORDER BY 3 DESC;

SELECT cus_country,
CASE
	WHEN cus_age <= 30 THEN 'Youths'
    WHEN cus_age <= 45 THEN 'Young Adults'
    WHEN cus_age <= 60 THEN 'Adults'
    ELSE 'Seniors'
  END AS age_band, count(cus_age) as pop,
FROM sales_data
GROUP BY 1,2
ORDER BY 3 DESC;