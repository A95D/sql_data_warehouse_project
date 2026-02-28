-- Создание таблиц в схеме bronze
create table if not exists bronze.crm_cust_info(
  id int,
  first_name varchar,
  last_name varchar,
  email varchar,
  insertion_timestamp timestamp default now()
);

create table if not exists bronze.erp_sales_rev(
  order_id int,
  customer_id int,
  order_date date,
  amount numeric,
  insertion_timestamp timestamp default now()
)
