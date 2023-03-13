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
    channelGrouping,
    date,
    geoNetwork_country AS country,
    COUNT(DISTINCT CONCAT(fullVisitorId, CAST(visitId AS STRING))) AS transactions,
    SUM(totals_totalTransactionRevenue) AS total_revenue
  FROM
    `data-to-insights.ecommerce.rev_transactions`
  WHERE
    NOT geoNetwork_country = "(not set)"
  GROUP BY
    1,
    2,
    3
  ORDER BY
    date,
    geoNetwork_country ASC )
SELECT
  channelGrouping AS channel,
  ARRAY_AGG(STRUCT(date,
      country,
      transactions,
      total_revenue)) AS trx
FROM
  cte
GROUP BY
  1
```

## Table View
>https://docs.google.com/spreadsheets/d/1mwkq5EqcGI3bYVK_lc7hWhI2mOIyo7H6RoOyiZtR0iA/edit?usp=sharing
