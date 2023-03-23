with tables(full_name) as(
    SELECT '"' || t.table_schema || '"."' || t.table_name || '"' as full_name
    FROM "information_schema"."tables" t
    WHERE table_schema = 'caba-piba-raw-zone-db'
    AND table_name like '%goet%'
)

select array_join(array_agg('select ''' || full_name || ''' as table_name, count(*) as rows_count from ' || full_name), ' union all ')
from tables
group by true; 
