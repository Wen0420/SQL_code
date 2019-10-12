#case when 用不同的限制条件。 6-10 就2，其他以上就写个3
select amount,
case when amount between 0 and 5 then 1
	 when amount between 6 and 10 then 2
	else 3
	end as amount_band
from payment;

#IF ，仅仅是用0，1做判断

#Table operation

#WITH vs Sub query

#法一
select count(distinct customer_id) as cust_no,
case when amount > 10 then 'high'
else 'low'
end as amount_band
from payment 
group by 2;

#法二
括号里的相当于是以temporary table 提出来是为了下面的select.用一个临时的表 然后 对着个表做一个query.

WITH temp as 
(select payment_id,
		customer_id,
        if(amount > 10, "high", "low") as amount_band from payment
) select amount_band,
count(distinct customer_id) as cust_no
from temp
group by amount_band;

#法三 sub query
select amount_band,
count(distinct customer_id) as cust_no
from (
	select payment_id,
			customer_id,
            IF(amount > 10, 'high', 'low') as amount_band
            from payment) a 
group by amount_band;

#set (auto variable) 例如每个月月底的金额我想做一个汇总。

#定义一个值
set @month_end = '2019-09-30';
select @month_end;

#例
where tran_date <= @month_end;

#Select all the payments where the amount is higher than average amount.
set @avg_amount = (select avg(amount) from payment);
select *
from payment
where amount > @avg_amount;

##other table operation
#在sakila 当中创建一个表格,有两列，varcher 最多十个字符。
-- create a table called 'unit' and define column format
create table unit (
	amount float,
    unit varchar(10)
    );

-- insert values for columns
insert into unit (amount, unit)
values
	(120, 'kgs'),
    (11, 'jars'),
    (23.5, 'kgs'),
    (120, 'bottles')
    ;
    

    
    




            







			