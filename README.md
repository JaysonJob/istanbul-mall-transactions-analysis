# Istanbul Mall Transactions Analysis

End-to-end analysis of 99,458 rows retail transactions from major Istanbul shopping malls (2021–2023),
built with PostgreSQL and Power BI.

## Data Source

The Istanbul shopping mall dataset came from Kaggle,created and uploaded by user Mehmet Tahir Aslan.
It is officially called the "Customer Shopping Dataset - Retail Sales Data" and contains real
transaction data from 10 different malls in Istanbul between 2021–2023. I then downloaded the file
as an excel file.

🔗 [Customer Shopping Dataset on Kaggle](https://www.kaggle.com/datasets/mehmettahiraslan/customer-shopping-dataset)

## What's Inside

- **SQL** - data cleaning, indexing, analytical views, and business question queries
- **Power BI** - interactive dashboards covering sales, customers, products, malls, and payment methods
- **Insights page** - findings and strategic recommendations for the business

## Tech Stack

PostgreSQL · SQL · Power BI · DAX

## Workflow

1. Cleaned and standardised raw data in PostgreSQL (nulls, date formats, triming)
2. Created indexes for query performance and views for each analytical dimension
3. Connected PostgreSQL to Power BI and built a star schema (fact + dimension tables)
4. Designed dashboards with KPI cards, bar charts, pie charts, and trend lines
5. Wrote an executive summary and recommendations page

## Dashboards
## Ececutive summary
![alt text](https://github.com/JaysonJob/istanbul-mall-transactions-analysis/blob/163260280bc3451d2c0274f600ed4d4d2748b159/Screenshot%202026-06-03%20132111.png)
- Executive Summary
- Sales Overview
- Customer Analysis
- Product Performance
- Mall Performance
- Payment Methods
- Insights & Recommendations

## Key Findings

### 1. Customer Demographics
- Male customers generate 59.72% of revenue ($150.21M) vs 40.28% for females ($101.3M) - the gap
suggests males are buying higher-value items, likely Technology
- The 55+ age group spends the most ($71.77M), nearly double the 18–24 group ($33.45M) - this
network skews older and premium
- The 18–24 segment is significantly underleveraged at the lowest spend across all age groups

### 2. Payment Behaviour
- 79.72% of transactions are cashless (credit card 44.6%, debit card 35.12%) - cash is largely
irrelevant in this market

### 3. Product & Mall Performance
- Technology alone generates $100M, nearly 40% of total revenue - one category is carrying the
network, which is a concentration risk
- Viaport Outlet leads in units sold (45K) but high volume doesn't equal high revenue - likely
driven by lower price-point products
- Total revenue is $251.51M across 99K customers, averaging $2,540 per customer

## Recommendations

- The 55+ group is already your top spender - focus on premium product availability, not loyalty programs
- Reduce Technology dependence by cross-promoting Clothing and Shoes to existing high-value
Technology buyers
- Investigate the female revenue gap before acting - understand whether it's fewer customers or
lower spend per visit, as each requires a different fix
- With 80% cashless adoption already achieved, focus on reducing card transaction fees rather than
further cashless incentives
- Investigate Viaport Outlet's revenue per customer - high footfall with low average spend suggests
a product mix problem
