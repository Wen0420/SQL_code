-- 1. Replace all the space in film description with "_".
SELECT 
    REGEXP_REPLACE(description, '\s', '_')
FROM
    film_text; 
    
-- 2. Return the characters between the "()" in address; Remove the "()" and everything in it.
SELECT 
    REGEXP_SUBSTR(address, '(?<=\().+(?=\))')
FROM
    address;
    
-- 3. Return customers' first name and last name from customers' email address.
SELECT 
    email,
    REGEXP_SUBSTR(email, '^[A-Z]+(?=.)'),
    REGEXP_SUBSTR(email, '(?<=.)[A-Z]+(?=@)')
FROM
    customer;
    
-- 4. Return a movie count summary by special features.
create table features_str as (
select special_features, 
SUBSTRING_INDEX(special_features, ',', 1) as str_1,
SUBSTRING_INDEX(SUBSTRING_INDEX(special_features, ',', 2), ',', -1) as str_2,
SUBSTRING_INDEX(SUBSTRING_INDEX(special_features, ',', 3), ',', -1) as str_3,
SUBSTRING_INDEX(SUBSTRING_INDEX(special_features, ',', 4), ',', -1) as str_4
from film );

create table features_str_1 as (
select case when str_4 = str_3 then null else str_4 end as str4, 
       case when str_3 = str_2 then null else str_3 end as str3, 
	   case when str_2 = str_1 then null else str_2 end as str2,
       str_1 as str1
from features_str); 

create temporary table features_str_list as (
select str1 as str from features_str_1 
union all 
select str2 as str from features_str_1
union all
select str3 as str from features_str_1
union all
select str4 as str from features_str_1
);

select str, count(*) as movie_cnt
from features_str_list
where str is not null
group by str;
