-- Загрузка данных на слой bronze из csv

COPY bronze.crm_cust_info  
FROM '/datasets/crm_customers.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY bronze.erp_sales_rev 
FROM '/datasets/erp_sales.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');
