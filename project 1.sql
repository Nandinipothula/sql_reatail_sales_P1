use nandhu;
create database retail_sales;
create table retail_dataset(ï»¿transactions_id int primary key,	`sale_date` date,`sale_time` time,`customer_id` int,`gender` varchar(20),
`age` int,	`category` char(20),	`quantiy` float,`price_per_unit` float,`cogs` float,`total_sale` float);

select * from nandhu.retail_dataset;
select * from nandhu.retail_dataset limit 10;
alter table nandhu.retail_dataset 
rename column `ï»¿transactions_id` to transactions_id;
select count(*) from nandhu.retail_dataset ;
select * from nandhu.retail_dataset
where `transactions_id` is null
 and `sale_date` is null
and `sale_time` is null
and `customer_id` is null
and `gender` is null
and `age` is null
and `category` is null
and `quantiy` is null
and `price_per_unit` is null
and `cogs` is null
and `total_sale` is null;
select count(*) from nandhu.retail_dataset;


   select  count( distinct `customer_id`) as customerid from nandhu.retail_dataset;
   select *  from  nandhu.retail_dataset where `sale_date` = '2022-11-05';
   
    select *  from  nandhu.retail_dataset where `sale_date`in ('2022-11-05');  
    
    select * from nandhu.retail_dataset
    where `category` in ('clothing') and `quantiy`>=4  and   `sale_date` between '2022-11-01' and '2022-11-30';
    
    select `category`,sum(`total_sale`) as total_sale,
    count(*) as total_order
    from nandhu.retail_dataset
    where `category` in ('clothing','electronics','beauty') 
    group  by `category`
    order by `category`;
    
    
select `category` , avg(`age`) as age from nandhu.retail_dataset
where `category` in ('beauty');

select `category` , round(avg(`age`),2) as age from nandhu.retail_dataset
where `category` in ('beauty');
   
select *  from nandhu.retail_dataset
where `total_sale` >'1000';

  select `category`,`gender`,
    count(*) as total_trans
    from nandhu.retail_dataset
    where `category` in ('clothing','electronics','beauty') 
    group  by `category`, `gender`
    order by `category`;
    
    select 
    extract( year from `sale_date`) year,
    extract(month from `sale_date`) month,
    round(avg(`total_sale`),2)  as avgsale,
    rank() over(partition by extract(year from `sale_date`)   order by  avg(`total_sale`) desc)  as sales
    from nandhu.retail_dataset
    group by  1,2;
    
    
select `customer_id` ,
sum(`total_sale`) as total_sale
from nandhu.retail_dataset
group by 1
order by 2 desc
limit 5;


select `category`,
count(distinct `customer_id` ) as cnt_unique_cs
from nandhu.retail_dataset
group by `category`;


with  hourly_sale
as
(
select *,
 case
 when extract(hour from `sale_time`) < 12  then 'morning'
 when extract(hour from `sale_time`) between 12 and  16 then 'afternoon'
 else 'evening'
 end as shift
 from nandhu.retail_dataset
 )
 select  
 shift,
 count(*) as `total_sale`
 from hourly_sale
 group by shift;