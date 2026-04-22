SELECT * from financial_data_clean;

SELECT round(sum(revenue),2) AS total_revenue,
round(sum(profit),2) AS total_profit,
round(sum(profit)/sum(revenue)*100,2) AS overall_margin_pct,
round(AVG(revenue),2) AS avg_order_value,
count(order_id) AS total_orders
FROM financial_data_clean;

SELECT category,
ROUND(SUM(revenue),2) as total_revenue ,
 round(SUM(profit),2) as total_profit,
 ROUND(count(order_id),2)as total_orders,
 round(sum(profit)/SUM(revenue)*100,2) as margin_pct,
 ROUND(AVG(revenue),2) as avg_order_value
 from financial_data_clean
 GROUP BY category
 ORDER BY margin_pct DESC ;

 SELECT region,
 round(COUNT(order_id),2)as Total_orders,
 ROUND(SUM(profit),2) as Total_profit,
 ROUND(SUM(revenue),2) as Total_revenue,
 ROUND(SUM(revenue)/COUNT(order_id),2)as profit_per_order,
 ROUND(SUM(profit)/SUM(revenue)*100,2)as margin_pct from financial_data_clean
 GROUP BY region
 ORDER BY profit_per_order DESC;





SELECT 'Best Month' AS label,
       SUBSTR(date,1,7) AS month,
       ROUND(SUM(revenue),2) AS revenue,
       ROUND(SUM(profit),2) AS profit
FROM financial_data_clean
GROUP BY month
HAVING revenue = (
    SELECT ROUND(SUM(revenue),2)
    FROM financial_data_clean
    GROUP BY SUBSTR(date,1,7)
    ORDER BY SUM(revenue) DESC
    LIMIT 1
)

UNION ALL

SELECT 'Worst Month',
       SUBSTR(date,1,7) ,
       ROUND(SUM(revenue),2),
       ROUND(SUM(profit),2)
FROM financial_data_clean
GROUP BY SUBSTR(date,1,7)
HAVING ROUND(SUM(revenue),2) = (
    SELECT ROUND(SUM(revenue),2)
    FROM financial_data_clean
    GROUP BY SUBSTR(date,1,7)
    ORDER BY SUM(revenue) ASC
    LIMIT 1
);


SELECT sales_rep,
COUNT(order_id) AS total_orders,
ROUND(SUM(revenue),2) AS total_revenue,
ROUND(SUM(profit),2) AS total_profit,
ROUND(AVG(revenue),2) AS avg_order_value
FROM financial_data_clean
GROUP BY sales_rep
ORDER BY total_profit DESC;


select region,
category,
ROUND(sum(revenue),2) as revenue,
round(sum(profit),2) as profit,
round(COUNT(order_id),2) as orders
from financial_data_clean
GROUP BY region,category
ORDER BY region,profit DESC;


 SELECT
        SUBSTR(date,1,4)                            AS year,
        COUNT(order_id)                             AS total_orders,
        ROUND(SUM(revenue), 2)                      AS total_revenue,
        ROUND(SUM(profit),  2)                      AS total_profit,
        ROUND(AVG(revenue), 2)                      AS avg_order_value,
        CASE
            WHEN SUM(revenue) > LAG(SUM(revenue)) 
                 OVER (ORDER BY SUBSTR(date,1,4)) 
            THEN 'Growing'
            ELSE 'Declining'
        END                                         AS verdict
    FROm financial_data_clean
    GROUP BY SUBSTR(date,1,4)
    ORDER BY year;



