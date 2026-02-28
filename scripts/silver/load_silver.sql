-- 1.подготовка дельты (те, кого нет, или те, кто изменился) 
create temporary table temp_updates on commit drop as
select 
    b.id customer_id,
    b.first_name,
    b.last_name,
    b.email,
    -- определяем тип изменения для следующих шагов
    case
        when s.customer_id is null then 'NEW'
        else 'CHANGED'    
    end as change_type
from bronze.crm_cust_info b
left join silver.dim_customers s
    on b.id = s.customer_id
    and s.is_current = true -- сравниваем только с активной версией
where s.customer_id is null 
    or (b.email is distinct from s.email 
        or b.first_name is distinct from  s.first_name
        or b.last_name is distinct from  s.last_name
            )

-- 2. закрываем запись для changed клиентов
-- помечаем старые записи как неактивные
update silver.dim_customers target
set 
    valid_to = now(),
    is_current = false
from temp_updates src
where target.customer_id = src.customer_id
    and target.is_current = true
    and src.change_type = 'CHANGED'


-- 3. загружаем записи из дельты как новые версии
-- здесь создается сурргогатрый ключ (customer_key) автоматически
insert into silver.dim_customers (
    customer_id, 
    first_name,
    last_name,
    email, 
    valid_from, 
    valid_to, 
    is_current)
select 
    customer_id,
    first_name,
    last_name,
    email,
    now(),
    null,
    true
from temp_updates 