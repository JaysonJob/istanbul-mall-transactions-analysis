# Istanbul Mall Transactions Analysis
End-to-end analysis of 99,458 rows retail transactions from major Istanbul shopping malls (2021–2023),
built with PostgreSQL and Power BI.

## Data Source
The Istanbul shopping mall dataset came from Kaggle, created and uploaded by user Mehmet Tahir Aslan.
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

## Setup / Installation

### 1. Prerequisites
- PostgreSQL (v13 or later recommended)
- Power BI Desktop (works offline once the .pbix file is opened; no Power BI service account required)

### 2. Installation Steps
1. Create a new database in PostgreSQL, e.g.:
```sql
   CREATE DATABASE istanbul_mall_sales;
```
2. Import the dataset into the database:
```bash
   psql -d istanbul_mall_sales -f customer_shopping_data.sql
```
3. Open the `.pbix` file in Power BI Desktop:
   - **Offline:** Double-click the `.pbix` file — it opens directly in Power BI Desktop with the data model and visuals intact. No sign-in is required to view or explore the dashboards.
   - **Online:** To refresh the data live from PostgreSQL, open the file in Power BI Desktop, go to **Home > Transform data > Data source settings**, and update the PostgreSQL server/database credentials to point to your own local database, then click **Refresh**.

## Workflow
1. Cleaned and standardised raw data in PostgreSQL (nulls, date formats, trimming)
2. Created indexes for query performance and views for each analytical dimension
3. Connected PostgreSQL to Power BI and built a star schema (fact + dimension tables)
4. Designed dashboards with KPI cards, bar charts, pie charts, and trend lines
5. Wrote an executive summary and recommendations page

## Dashboards & SQL Analysis

### Executive Summary
![alt text](https://github.com/JaysonJob/istanbul-mall-transactions-analysis/blob/163260280bc3451d2c0274f600ed4d4d2748b159/Screenshot%202026-06-03%20132111.png)

The executive summary page consolidates the full analysis into a single view: total revenue, customer
count, average spend per customer, and the top-performing category and mall — giving a business
stakeholder the headline numbers before drilling into the detail pages.

### Dashboard Overview
![alt text](https://github.com/JaysonJob/istanbul-mall-transactions-analysis/blob/e740afb5e03268464d6961d8fbd72d812ba860d3/Screenshot%202026-06-03%20132000.png)

This dashboard explores the spending habits of customers across gender, age group, and mall. Females
are the larger customer base above age 30, while customers aged 50+ contribute the most revenue overall,
suggesting this age group has greater disposable income to spend per visit.

### Query: Spending Summary by Gender
**Question:** The company wants to know whether one gender is driving a disproportionate share of
revenue, and whether that's due to more customers or higher spend per customer.

**Query:** Groups transactions by gender and calculates total revenue, revenue share (%), transaction
count, and average spend per transaction.

**Answer:** Male customers generate 59.72% of revenue ($150.21M) vs 40.28% for females ($101.3M) —
despite Power BI showing females as the larger customer base above age 30, indicating males are buying
fewer but higher-value items (likely Technology).

![Spending Summary by Gender](images/gender-analysis.png)

### Query: Payment Method Breakdown
**Question:** As the company considers reducing cash-handling costs, they want to know how many
transactions are already cashless, and which cashless method dominates.

**Query:** Groups transactions by payment method and calculates transaction count and percentage share
of total transactions.

**Answer:** 79.72% of transactions are cashless (credit card 44.6%, debit card 35.12%), meaning cash
handling costs could largely be phased out with minimal disruption to sales.

![alt text](https://github.com/JaysonJob/istanbul-mall-transactions-analysis/blob/7b12df38d37501a1a61e65c33c429cfe0f970068/Screenshot%202026-06-03%20131346.png)

> For the full list of business questions answered in SQL — including age-group spend, category
> revenue share, and mall-level performance — see the comments above each query in
> [`customer_shopping_data.sql`](customer_shopping_data.sql), where each query block is documented
> with its business question and the takeaway from its result.

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
