create view gold.mart_sales_overview as
    select
        fs.order_id,
        concat(dc.first_name, ' ', dc.last_name) as full_name,
        dc.email,
        fs.order_date,
        fs.amount
    from silver.fact_sales fs
    join silver.dim_customers dc 
        on fs.customer_key = dc.customer_key

select 
    order_id
from silver.fact_sales fs
left join silver.dim_customers dc
    on fs.customer_key = dc.customer_key
where dc.customer_key is null