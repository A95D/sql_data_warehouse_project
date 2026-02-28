-- Создание таблицы dim_customers в схеме silver
create table if not exists silver.dim_customers(
  customer_key serial primary key,
  id int,
  first_name varchar,
  last_name varchar,
  email varchar,
  valid_from timestamp not null default now(),
  valid_to timestamp,
  is_current boolean default true,
  insertion_timestamp timestamp default now()
);

-- Создание таблицы fact_sales в схеме silver
create table if not exists silver.fact_sales(
  order_id int,
  customer_key int,
  order_date date,
  amount numeric,
  insertion_timestamp timestamp default now(),
  foreign key (customer_key) references silver.dim_customers(customer_key)
);
 
-- Проверка данных в dim_customers на наличие некорректных email 
select
    email
from silver.dim_customers
where email is null
    or not email like '%@%';