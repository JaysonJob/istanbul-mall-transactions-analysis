create schema mall_analysis;
set search_path to mall_analysis;

create table customer_shopping_data (
    invoice_no varchar(20) primary key,
    customer_id varchar(20) not null,
    gender varchar(10),
    age int,
    category varchar(50),
    quantity int,
    price decimal(10,2),
    payment_method varchar(30),
    invoice_date date,
    shopping_mall varchar(100)
);
select * from customer_shopping_data ;

-- Step 1 cleaning the data
----part 1---
--checking the customer_id
--1.ensuring there are no empty spaces and replace them with unknown
select customer_id
from customer_shopping_data;

--2.-- Replace NULL or empty customer_id with 'UNKNOWN'
update customer_shopping_data 
set customer_id = 'unknown' 
where customer_id is null or customer_id = '';

--part 2--gender
select gender
from customer_shopping_data
group by gender;
-- standardizing the leters
--empty values to be unknown
update customer_shopping_data 
set gender = 'unknown' 
where gender is null or gender = '';

--part 3 --payment method
select payment_method
from customer_shopping_data  
group by payment_method;
 -- triming and standardizing the leters
update customer_shopping_data
set payment_method = trim(initcap(payment_method))
where payment_method !=trim(initcap(payment_method));

--part 4--invoice date
select invoice_date,count(*)
from customer_shopping_data
group by invoice_date;
--- converting to the right formar (from dd-mm-yyy to yyyy-mm-dd)
update customer_shopping_data
set invoice_date = to_char(to_date(invoice_date, 'dd-mm-yyyy'),'yyyy-mm-dd');

-- part 5-- category
--a.standardizing the letters
--b.triming the spaces
--c.null and empty spaces to be unknown
select category,count(*)
from customer_shopping_data
group by category;


update customer_shopping_data 
set category = 'unknown' 
where category is null or category = '';

update customer_shopping_data
set category = trim(initcap(category))
where category !=trim(initcap(category));

--part 6 removing duplicates
--a.check for duplicates using invoice.no(unique column)
select invoice_no, count(*) 
from customer_shopping_data 
group by invoice_no 
having count(*) > 1;


-- part 7 ANALYSIS
--a.answering busines questions 
--1. Total revenue and statistics
select 
    count(*) as total_transactions,
    round(sum(quantity * price)::numeric,2) as total_revenue,
    round(avg(quantity * price)::numeric,2) as avg_transaction_value,
    min(invoice_date) as first_purchase,
    max(invoice_date) as last_purchase
from customer_shopping_data;

--2.Which mall generates the most revenue
select 
    shopping_mall,
    count(*) as transactions,
    round(sum(quantity * price)::numeric,2)as total_revenue,
    round(avg(quantity * price)::numeric,2) as avg_transaction_value
from customer_shopping_data
group by shopping_mall
order by total_revenue desc;

--3.Best selling product categories
select  
    category,count(*) as times_purchased,
    round(sum(quantity)::numeric,2) as total_quantity_sold,
    round(sum(quantity * price)::numeric,2) as total_revenue,
    round(avg(quantity * price)::numeric,2) as avg_order_value
from customer_shopping_data
group by category
order by total_revenue desc;

-- 4 analysing spending by gender
select 
    gender,
    count(distinct customer_id) as total_customers,
    round(sum(quantity * price)::numeric,2) as total_revenue,
    round(avg(quantity * price):: numeric,2)as avg_spent
from customer_shopping_data
group by gender;

-- 5 analysing the different payment methods
select 
    payment_method,count(*) as usage_count,
    round(sum(quantity * price)::numeric,2) as total_amount,
    round(avg(quantity * price)::numeric, 2) as avg_transaction
from customer_shopping_data
group by payment_method
order by total_amount desc;

-- 6.analysing Which categories perform best at each mall
select 
    shopping_mall,
    category,
    round(sum(quantity * price):: numeric,2) as revenue,
    count(*) as transactions
from customer_shopping_data
group by shopping_mall,category
order by shopping_mall,revenue desc;

--part 8--ANSWERING BUSINESS QUESTIONS
--1.who are the top 3 customers in each mall and what is their spendings over time?
with customer_stats as (
   select customer_id, shopping_mall, 
           sum(quantity * price) as total_spent,
           rank() over (partition by shopping_mall order by sum(quantity * price) desc) as rnk
    from customer_shopping_data
    group by customer_id, shopping_mall
),
purchases as (
    select customer_id, invoice_date, quantity * price as amount,
           lag(quantity * price) over (partition by customer_id order by invoice_date) as prev_purchase
    from customer_shopping_data
)
select cs.shopping_mall, cs.customer_id, cs.total_spent, cs.rnk,
       p.amount as last_purchase,
       case when p.amount > p.prev_purchase then 'Increasing' else 'Decreasing' end as trend
from customer_stats cs
join purchases p on cs.customer_id = p.customer_id
where cs.rnk <= 3
  and p.invoice_date = (select max(invoice_date) from customer_shopping_data where customer_id = cs.customer_id)
order by cs.shopping_mall, cs.rnk;

-- Add indexes to speed up queries
create idx idx_mall on customer_shopping_data(shopping_mall);
create idx idx_category on customer_shopping_data(category);
create idx idx_customer on customer_shopping_data(customer_id);
create idx idx_date on customer_shopping_data(invoice_date);

--2.comparing each mall to average transactrions
select csd.shopping_mall, csd.category, 
       csd.quantity * csd.price as transaction_amount,
       mall_avg.avg_mall_spend
from customer_shopping_data csd
join (
    select shopping_mall, round(AVG(quantity * price)::numeric,2) as avg_mall_spend
    from customer_shopping_data
    group by shopping_mall
) mall_avg on csd.shopping_mall = mall_avg.shopping_mall
limit 20;

-- part 9 CREATING VIEWS
--sales view
CREATE VIEW v_sales_fact AS
SELECT 
    invoice_no,
    customer_id,
    shopping_mall,
    category,
    payment_method,
    gender,
    age,
    quantity,
    price,
    quantity * price as total_amount,
    invoice_date,
    extract(year from invoice_date::TIMESTAMP) as year,
    extract(month from invoice_date::TIMESTAMP) as month,
    extract(day from invoice_date::TIMESTAMP) as day_of_week,
    TO_CHAR(invoice_date::TIMESTAMP, 'Month') as month_name,
    case 
        when age < 25 then '18-24'
        when age between 25 and 34 then '25-34'
        when age between 35 and 44 then '35-44'
        when age between 45 and 54 then '45-54'
        else '55+'
    end as age_group
from customer_shopping_data;
 
-- customer summary view
create view v_customer_summary as
select 
    customer_id,
    gender,
    min(age) as age,
    count(distinct invoice_no) as total_transactions,
    count(distinct shopping_mall) as malls_visited,
    count(distinct category) as categories_bought,
    sum(quantity) as total_units,
    sum(quantity * price) as total_spent,
    avg(quantity * price) as avg_transaction,
    min(invoice_date) as first_purchase,
    max(invoice_date) as last_purchase
from customer_shopping_data
group by customer_id, gender;

-- mall perfomance view
create view v_mall_performance as
select 
    shopping_mall,
    count(distinct invoice_no) as total_transactions,
    count(distinct customer_id) as unique_customers,
    count(distinct category) as categories_offered,
    sum(quantity) as units_sold,
    sum(quantity * price) as total_revenue,
    avg(quantity * price) as avg_transaction,
    sum(quantity * price) / count(distinct customer_id) as revenue_per_customer
from customer_shopping_data
group by shopping_mall;

--payment method view
create view v_payment_analysis as
select 
    payment_method,
    shopping_mall,
    count(*) as usage_count,
    sum(quantity * price) as total_amount,
    avg(quantity * price) as avg_transaction,
    count(distinct customer_id) as unique_users
from customer_shopping_data
group by payment_method, shopping_mall;

--gender view
create view v_gender_analysis as
select 
    gender,
    shopping_mall,
    count(distinct customer_id) as customers,
    count(distinct invoice_no) as transactions,
    sum(quantity * price) as total_revenue,
    avg(quantity * price) as avg_spent
from customer_shopping_data
group by gender, shopping_mall;

-- kpi view
create view v_bi_kpis as
select 
    (select count(distinct invoice_no) from customer_shopping_data) as total_orders,
    (select count(distinct customer_id) from customer_shopping_data) as total_customers,
    (select sum(quantity * price) from customer_shopping_data) as total_revenue,
    (select avg(quantity * price) from customer_shopping_data) as avg_order_value,
    (select count(distinct shopping_mall) from customer_shopping_data) as total_malls,
    (select count(distinct category) from customer_shopping_data) as total_categories;
