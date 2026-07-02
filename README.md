# Istanbul Mall Transactions Analysis

End-to-end analysis of 99,458 retail transactions from major Istanbul shopping malls (2021–2023), built with PostgreSQL and Power BI.

## What's Inside
- **SQL** – data cleaning, indexing, analytical views, and business-question queries
- **Power BI** – interactive dashboards covering sales, customers, products, malls, and payment methods
- **Insights page** – findings and strategic recommendations for the business

## Tech Stack
PostgreSQL · SQL · Power BI · DAX

## Setup / Installation

### 1. Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/) (v13+ recommended)
- [Power BI Desktop](https://www.microsoft.com/en-us/power-platform/products/power-bi/desktop) — the `.pbix` file can be opened **offline** once downloaded; you only need an internet connection/Power BI account if you want to publish or refresh the report online.

### 2. Installation Steps
1. Create a new database in PostgreSQL, e.g.:
   ```sql
   CREATE DATABASE mall_transactions;
   ```
2. Run `customer_shopping_data.sql` against that database. This script will:
   - Create the `mall_analysis` schema and `customer_shopping_data` table
   - Clean the raw data (standardise text fields, fix date formats, handle nulls/duplicates)
   - Build indexes and analytical views (`v_sales_fact`, `v_customer_summary`, `v_mall_performance`, `v_payment_analysis`, `v_gender_analysis`, `v_bi_kpis`)
3. Open `mall transactions power BI report.pbix` in Power BI Desktop.
   - **Offline:** the file opens directly and shows the last-refreshed data — no database connection needed to just view the report.
   - **Online / with live data:** update the PostgreSQL connection details under *Transform Data → Data Source Settings* to point at your local database, then click **Refresh** to pull in the data you loaded in step 2.

## Quick Summary
| | |
|---|---|
| **Records** | 99,458 transactions |
| **Period** | Early 2021 – Early 2023 |
| **Malls** | Kanyon, Mall of Istanbul, Istinye Park, Cevahir AVM, Metrocity + more |
| **Categories** | Clothing, Technology, Shoes, Food & Beverage + more |

## Workflow
1. **Clean the base data** —  Standardised text fields (gender, category, payment method), fixed date formats, replaced blank/null IDs with `'unknown'`, and checked for duplicate invoices.
2. **Index & build views** — *"How do we make repeated business questions fast to answer?"* Added indexes on mall, category, customer, and date, then created reusable views (sales fact, customer summary, mall performance, payment analysis, gender analysis, KPIs) so Power BI queries stay fast.
3. **Connect to Power BI & model** — *"How do the cleaned tables become a report?"* Connected PostgreSQL to Power BI and built a star schema (fact + dimension tables).
4. **Design the dashboards** — *"What should decision-makers see at a glance?"* Built KPI cards, bar charts, pie charts, and trend lines for sales, customers, products, malls, and payment methods.
5. **Summarise findings** — *"So what?"* Wrote an executive summary and recommendations page translating the numbers into action.
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
## Business Questions & Queries
Each query below started as a hypothetical business question. The SQL answers it with real data — the same question/answer pairs are also included as comments directly above each query in `customer_shopping_data.sql`.

> Note: a hypothesis doesn't have to be *true* going in — the point of the query is to test it against the data and see whether it holds up.

| # | Business Question | What the Query Does | Query |
|---|---|---|---|
| 1 | What's our overall transaction volume and revenue baseline? | Totals transactions, revenue, average order value, and the date range covered | Total Revenue & Statistics |
| 2 | Which mall should we prioritise for our next marketing push? | Ranks malls by transaction count, revenue, and average transaction value | Revenue by Mall |
| 3 | Which product categories should we stock more/less of? | Ranks categories by units sold, revenue, and average order value | Best-Selling Categories |
| 4 | As part of a 3-year advertising plan, which age group should we advertise to more, especially younger groups? | Groups customers by age bracket and compares average spend, total spend, and purchase timing (via `v_sales_fact`'s `age_group` field) | Spending Summary by Age Group |
| 5 | Do men or women spend more, and is that consistent across malls? | Compares customer counts, total revenue, and average spend by gender | Spending Summary by Gender |
| 6 | Which payment method should we optimise checkout for? | Compares usage count, total value, and average transaction size by payment method | Payment Method Performance |
| 7 | Which categories drive revenue at each specific mall? | Cross-tabs category revenue by mall to find each location's strongest categories | Category Performance by Mall |
| 8 | Who are our highest-value customers, and are they spending more or less over time? | Ranks the top 3 customers per mall and flags whether their most recent purchase is trending up or down vs. their previous one | Top Customers & Spending Trend |
| 9 | Are individual transactions above or below their mall's average? | Joins each transaction against its mall's average spend to flag over/under-performing sales | Transactions vs. Mall Average |

## Dashboards
Each dashboard below is described first by what it's meant to answer, then by what the data actually shows. A template summary is included so you can see the format to follow

### 1. Executive Summary — *"How is the business doing overall?"*
![alt text](https://github.com/JaysonJob/istanbul-mall-transactions-analysis/blob/163260280bc3451d2c0274f600ed4d4d2748b159/Screenshot%202026-06-03%20132111.png)
> Summary: *[e.g. Total revenue reached $X across Y transactions, with an average order value of $Z. Revenue was fairly stable/grew/declined across the two-year window, with [month] consistently the strongest period.]*

### 2. Sales Overview — *"Where and when is revenue being generated?"*
![Sales overview dashboard](images/sales-overview.png)
> Summary: *[e.g. [Mall name] generates the largest share of revenue, driven mainly by [category]. Sales peak around [month/season], suggesting [seasonal driver].]*

### 3. Customer Analysis — *"Who is actually buying, and who should we target?"*
![Customer analysis dashboard](images/customer-analysis.png)
> Summary: *[e.g. explores spending habits by gender and age group — which gender is the larger customer base, which age brackets spend the most/least, and where the advertising gap is.]*

### 4. Product Performance — *"What should we stock more or less of?"*
![Product performance dashboard](images/product-performance.png)
> Summary: *[e.g. [Category] is the top revenue driver, while [category] under-performs relative to its transaction count, suggesting lower price points rather than low demand.]*

### 5. Mall Performance — *"Which locations are winning, and why?"*
![Mall performance dashboard](images/mall-performance.png)
> Summary: *[e.g. [Mall] leads on both transaction volume and revenue per customer, while [mall] has high foot traffic but a lower average basket size.]*

### 6. Payment Methods — *"How are customers paying, and does it affect spend?"*
![alt text](https://github.com/JaysonJob/istanbul-mall-transactions-analysis/blob/7b12df38d37501a1a61e65c33c429cfe0f970068/Screenshot%202026-06-03%20131346.png)
> Summary: *[e.g. [Payment method] is the most-used option, but [payment method] transactions carry a higher average value, hinting at a different customer segment.]*

### 7. Insights & Recommendations
Translates the above into a short set of strategic recommendations — e.g. which age groups to target in the next advertising cycle, which malls/categories to double down on, and which under-performing segments need attention.

## Repository Structure
```
istanbul-mall-transactions-analysis/
├── README.md
├── customer_shopping_data.sql
├── mall transactions power BI report.pbix
└── images/
    ├── executive-summary.png
    ├── sales-overview.png
    ├── customer-analysis.png
    ├── product-performance.png
    ├── mall-performance.png
    └── payment-methods.png
```
