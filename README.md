# istanbul-mall-transactions-analysis
The Istanbul shopping mall dataset came from Kaggle,created and uploaded by user Mehmet Tahir Aslan.
It is officially called the "Customer Shopping Dataset - Retail Sales Data" and contains real transaction data from 10 different malls in Istanbul between 2021–2023.
I then downloaded the file as an excel file.

Direct link to the dataset:
🔗 https://www.kaggle.com/datasets/mehmettahiraslan/customer-shopping-dataset

End-to-end analysis of 99,458 rows retail transactions from major Istanbul shopping malls (2021–2023), built with PostgreSQL and Power BI.

What's Inside

SQL - data cleaning, indexing, analytical views, and business question queries
Power BI - interactive dashboards covering sales, customers, products, malls, and payment methods
Insights page - findings and strategic recommendations for the business

Tech Stack
PostgreSQL · SQL · Power BI · DAX
Quick Summary
Records99,458 transactionsPeriodEarly 2021 - Early 2023MallsKanyon, Mall of Istanbul, Istinye Park, Cevahir AVM, Metrocity + moreCategoriesClothing, Technology, Shoes, Food & Beverage + more
Workflow

Cleaned and standardised raw data in PostgreSQL (nulls, date formats, casing)
Created indexes for query performance and views for each analytical dimension
Connected PostgreSQL to Power BI and built a star schema (fact + dimension tables)
Designed dashboards with KPI cards, bar charts, pie charts, and trend lines
Wrote an executive summary and recommendations page

Dashboards

Executive Summary
Sales Overview
Customer Analysis
Product Performance
Mall Performance
![alt text](https://github.com/JaysonJob/istanbul-mall-transactions-analysis/blob/main/Screenshot%202026-06-03%20132000.png?raw=true)
Payment Methods
Insights & Recommendations
  KEY FINDINGS
1.Customer Demographics
Male customers generate 59.72% of revenue ($150.21M) vs 40.28% for females ($101.3M) - the gap suggests males are buying higher-value items, likely Technology
The 55+ age group spends the most ($71.77M),nearly double the 18–24 group ($33.45M) - this network skews older and premium
The 18–24 segment is significantly underleveraged at the lowest spend across all age groups

2.Payment Behaviour
79.72% of transactions are cashless (credit card 44.6%, debit card 35.12%) - cash is largely irrelevant in this market

3.product & Mall Performance
Technology alone generates $100M, nearly 40% of total revenue - one category is carrying the network, which is a concentration risk
Viaport Outlet leads in units sold (45K) but high volume doesn't equal high revenue - likely driven by lower price-point products
Total revenue is $251.51M across 99K customers,averaging $2,540 per customer

  RECOMENDATIONS
The 55+ group is already your top spender - focus on premium product availability,not loyalty programs
Reduce Technology dependence by cross-promoting Clothing and Shoes to existing high-value Technology buyers
Investigate the female revenue gap before acting - understand whether it's fewer customers or lower spend per visit, as each requires a different fix
With 80% cashless adoption already achieved,focus on reducing card transaction fees rather than further cashless incentives
Investigate Viaport Outlet's revenue per customer - high footfall with low average spend suggests a product mix problem

