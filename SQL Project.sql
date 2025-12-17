create database proj;
use proj;
show tables;
## Query 1 KPI'S

select *from bdata;
select sum(loan_amount) As Total_Loan_Amount,
sum(funded_amount) as Total_Funded_Amount,
avg(int_rate) as average_int_rate,
sum(total_pymnt) as Total_Payment from bdata;


# Query2 Region Wise Loan Amount(group by,order by)

select distinct(region_name)region,concat(format(sum(loan_amount)/1000000,2),"M")total_Loan_Amount
 from bdata group by region order by 
total_loan_amount desc;


# Query3 grade wise fees(having clause)


select distinct(grade)grade,sum(total_fees)total_fees
from bdata
group by grade
having total_fees>0
order by total_fees asc;


#Query 4 store procedure(where,limit)
call proj.Bank_List('102-dbs');

#Query 5 Window Function(RNK,DRNK,RNo)

select Client_name,region_name,loan_amount,
row_number() over(order by loan_amount desc)rno,
rank() over(order by loan_amount desc)rnk,
dense_rank() over(order by loan_amount desc)drnk
from bdata;


#Query 6 Sub-Query(To fetch the data based on other query)

with ab as(
select *,
dense_rank() over(order by funded_amount desc)drnk
from bdata)
select * from ab where drnk in (3,5,7);












