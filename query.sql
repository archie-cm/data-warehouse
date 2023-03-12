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