-- Загрузка данных в слой bronze с указанием столбцов
COPY bronze.crm_cust_info (id, first_name, last_name, email) 
FROM '/datasets/crm_customers.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY bronze.erp_sales_rev (order_id, customer_id, order_date, amount) 
FROM '/datasets/erp_sales.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- вставка нового клиента в таблицу bronze.crm_cust_info
insert into bronze.crm_cust_info (id, first_name, last_name, email)
values (4, 'John', 'Doe', 'john.doe@example.com');

-- обновление email для клиента с id = 2
update bronze.crm_cust_info
set email = 'jane.smith@example.com'
where id = 2;
