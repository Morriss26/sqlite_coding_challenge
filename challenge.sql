--================================================
--SQLite Coding Challenge
--Tools used: VS Code with SQLite extension and SQLTools extension
--Validation: Each query was ran seperately to verify that the results were correct
--and tha the queries made sense in comparison to the data and the expected results.
--================================================

-- Task 1
--Logic: Calculated the total spend for each customer by using the sum function to multiply the quantity of each order item by its unit price, and then summing that for each customer.
SELECT
    c.first_name || ' ' || c.last_name AS full_name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
    FROM customers c
    JOIN orders o ON o.customer_id = c.id
    JOIN order_items oi ON o.id = oi.order_id
    GROUP BY c.id, c.first_name, c.last_name
    ORDER BY total_spend DESC
    LIMIT 5;

-- Task 2
--Logic: Calculate the revenue for each product category by summing up line totals grouped by the product category.
p.category,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Task 3
--Logic: Calculated the average salary for each department compared to employee salaries by joining the employees table 
--with a subquery that calculates the average salary for each department.
e.first_name,
e.last_name,
d.name AS department_name,
e.salary AS employee_salary,
dept_avg.avg_salary AS department_average
FROM employees e
JOIN departments d ON d.id = e.department_id
JOIN(
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
    )
    AS dept_avg ON dept_avg.department_id = e.department_id
    WHERE e.salary > dept_avg.avg_salary
    ORDER BY e.salary DESC;

-- Task 4
--Logic: Counted the number of customers with a "Gold" Loyalty level using a WHERE function to filter the customers 
--and then grouped the results by city to get the count of gold customers in each city. Than order by DESC.
SELECT
city,
COUNT(*) AS gold_customer_count
FROM customers
WHERE loyalty_level = 'Gold'
GROUP BY city
ORDER BY gold_customer_count DESC;

--Extension: Full loyalty distribution by city
SELECT
city,
SUM(CASE WHEN loyalty_level = 'Bronze' THEN 1 ELSE 0 END) AS bronze,
SUM(CASE WHEN loyalty_level = 'Silver' THEN 1 ELSE 0 END) AS silver,
SUM(CASE WHEN loyalty_level = 'Gold' THEN 1 ELSE 0 END) AS gold
FROM customers
GROUP BY city   
ORDER BY gold DESC, silver DESC, bronze DESC;