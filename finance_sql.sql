select *
from financial_analysis.financial_data;

Use financial_analysis;

-- Mixing the shifted value into one --
select concat(`Sales Qtr - Crore`, `MyUnknownColumn`) AS sales_qtr_crore
from financial_data;

-- creating new column name with proper value--
alter table financial_analysis.financial_data
add sales_qtr_crore varchar(50);

-- filling the real value from the shifted values--
update financial_analysis.financial_data
SET sales_qtr_crore = concat(`Sales Qtr - Crore`, `MyUnknownColumn`);

-- removing unnecessary columns--
alter table financial_analysis.financial_data
drop column `Sales Qtr - Crore`,
drop column `MyUnknownColumn`;

-- renaming the columns in order to write the names more easily-- 
alter table financial_analysis.financial_data
change `Mar Cap - Crore` mar_cap_crore varchar(50);

-- viewing the data for confirmation--
select *
FROM financial_analysis.financial_data;


-- Also removing series number cause of improper numbering--
alter table financial_analysis.financial_data
drop `S.No.`;

-- updating blank cells to null value for making the data more simple--
update financial_analysis.financial_data
set `mar_cap_crore` = NULL
where `mar_cap_crore` = '';

update financial_analysis.financial_data
set `sales_qtr_crore` = NULL
where `sales_qtr_crore` = '';

-- modifying the table into proper correct form--
alter table financial_analysis.financial_data
modify sales_qtr_crore decimal(10,2);

alter table financial_analysis.financial_data
modify mar_cap_crore decimal(10,2);

-- Finding the null values--
select *
from financial_analysis.financial_data
where sales_qtr_crore IS NULL
AND mar_cap_crore IS NULL;

-- removing null values--
delete from financial_analysis.financial_data
where sales_qtr_crore IS NULL;

-- Rechecking the values--
select *
from financial_analysis.financial_data
where sales_qtr_crore IS NULL
AND mar_cap_crore IS NULL;


-- Finding top 5 companies with highest market cap--
select `Name`, mar_cap_crore
from financial_analysis.financial_data
order by mar_cap_crore DESC
limit 5;

-- Finding 5 companies with least market cap--
select `Name`, mar_cap_crore
from financial_analysis.financial_data
order by mar_cap_crore ASC
limit 5;

-- Finding top 5 companies with hogest sales--
select `Name`, sales_qtr_crore
from financial_analysis.financial_data
order by sales_qtr_crore DESC
limit 5;

-- Finding 5 companies with least sales--
select `Name`, sales_qtr_crore
from financial_analysis.financial_data
order by sales_qtr_crore ASC
limit 5;

-- Companies earning more than it's market cap--
select `Name`, mar_cap_crore, sales_qtr_crore
from financial_analysis.financial_data
where sales_qtr_crore > mar_cap_crore;

select count(*)
from financial_analysis.financial_data
where sales_qtr_crore > mar_cap_crore; #7

-- companies generating less than 100 cr sales --
select count(*)
from financial_analysis.financial_data
where sales_qtr_crore < 100; #13

select *
from financial_analysis.financial_data
where sales_qtr_crore < 100;

-- Average sales--
select AVG(sales_qtr_crore) AS avg_sales
from financial_analysis.financial_data;

-- total sales--
select SUM(sales_qtr_crore) AS total_sales
from financial_analysis.financial_data