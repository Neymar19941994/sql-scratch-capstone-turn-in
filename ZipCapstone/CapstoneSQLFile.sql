--------------Explore data -------------

SELECT * 
FROM survey 
LIMIT 10; 

--------------Analyze survey data ------------
SELECT question AS 'Question', COUNT(*) as 'Total Count' 
FROM survey 
GROUP BY question; 

--------------Home try on (exploring data) ------------

SELECT * 
FROM quiz 
LIMIT 5;

SELECT * 
FROM home_try_on 
LIMIT 5;

SELECT * 
FROM purchase 
LIMIT 5;

------------------Question 5 (left join) ----------

WITH subquery AS (SELECT DISTINCT quiz.user_id, home_try_on.user_id IS NOT null AS 'is_home_try_on', home_try_on.number_of_pairs, purchase.user_id IS NOT null AS 'is_purchase'
FROM quiz
left JOIN home_try_on 
ON quiz.user_id = home_try_on.user_id
left JOIN purchase
ON quiz.user_id = purchase.user_id)

SELECT user_id, case when is_home_try_on = 1 then 'TRUE' else 'FALSE' end AS 'is_home_try_on', number_of_pairs, case when is_purchase = 1 then 'TRUE' else 'FALSE' end AS "is_purchase"
FROM subquery
LIMIT 10;

--------------------Analyizing conversion funnel--------
---Calculate conversion accross ---

With subquery AS (SELECT DISTINCT quiz.user_id, home_try_on.user_id IS NOT null AS 'is_home_try_on', home_try_on.number_of_pairs, purchase.user_id IS NOT null AS 'is_purchase'
FROM quiz
left JOIN home_try_on 
ON quiz.user_id = home_try_on.user_id
left JOIN purchase
ON quiz.user_id = purchase.user_id)

SELECT COUNT(user_id) AS 'Survey_Respondents',
   SUM(is_home_try_on) AS 'Total_Home_Try_On',
   SUM(is_purchase) AS 'Total_Purchase',
    1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'Survey_to_Home_Try_ON',
   1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'Home_try_on_to_Purchase'
   FROM subquery;

With subquery AS (SELECT DISTINCT quiz.user_id, home_try_on.user_id IS NOT null AS 'is_home_try_on', home_try_on.number_of_pairs, purchase.user_id IS NOT null AS 'is_purchase'
FROM quiz
left JOIN home_try_on 
ON quiz.user_id = home_try_on.user_id
left JOIN purchase
ON quiz.user_id = purchase.user_id)

SELECT number_of_pairs, COUNT(DISTINCT user_id) AS 'Survey_Respondents',
   SUM(is_home_try_on) AS 'Total_Home_Try_On',
   SUM(is_purchase) AS 'Total_Purchase',
   1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'Home_try_on_to_Purchase'
FROM subquery
GROUP BY number_of_pairs;


------------Most common -----------------

SELECT style, COUNT(*) AS 'STYLE COUNT [quiz]'
FROM quiz
GROUP BY style;

SELECT model_name, COUNT(*) AS 'MODEL COUNT [purchase]'
FROM purchase
GROUP BY model_name;

SELECT color, COUNT(*) AS 'COLOR COUNT [purchase]'
FROM purchase
GROUP BY color;

---------------------Average Selling price ------------
with subquery3 AS (SELECT COUNT(*) AS 'Total_Count', price 
FROM purchase
GROUP BY color)

SELECT 1.0 * (SUM(price*Total_Count)/SUM(Total_Count))
FROM subquery3;
                                         
SELECT price, COUNT(*) AS 'Price COUNT [purchase]'
FROM purchase
GROUP BY price;                        
                                         
                                        