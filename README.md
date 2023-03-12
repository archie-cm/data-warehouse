# Datawarehouse  

# Session 3: Data Warehouse
>From this public table `data-to-insights.ecommerce.rev_transactions`. Create an efficient query which
derives the total transactions per date and country based on the channel grouping! (Don’t forget to
clean the data and bonus point if using repeated columns)

## Query
```sql
WITH
  cte AS (
  SELECT
    DISTINCT channelGrouping,
    date,
    geoNetwork_country,
    COUNT(DISTINCT CONCAT(fullVisitorId, CAST(visitId AS STRING))) AS Transactions,
    SUM(totals_totalTransactionRevenue) AS Total_Revenue
  FROM
    `data-to-insights.ecommerce.rev_transactions`
  GROUP BY
    1,
    2,
    3
  ORDER BY
    date,
    geoNetwork_country ASC )
SELECT
  channelGrouping AS Channel,
  ARRAY_AGG(date) AS Date,
  ARRAY_AGG(geoNetwork_country) AS Country,
  ARRAY_AGG(Transactions) AS Transactions,
  ARRAY_AGG(Total_Revenue) AS Total_Revenue
FROM
  cte
GROUP BY
  channelGrouping
```

## Table View
>https://docs.google.com/spreadsheets/d/19GaxTItZeDpJbYS8hf_0gGzczQesaz18PbWL5NJIKeg/edit?usp=sharing
