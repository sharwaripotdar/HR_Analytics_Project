create database hrproject;
use hrproject;

select * from hr_1;
select * from hr_2;

#  Total Employee ---------------------------

create view Total_employee as
select count(*) total_employee from hr_1;

select * from Total_employee;

# Gender Count ------------------------------------------

create view gender as
select gender, count(gender) Coutn_gender from hr_1
group by gender;

select * from gender;

# Current Employee ---------------------------------------------------------

create view `current employee` as
Select count(attrition) current_employee from hr_1 where attrition = 'No';

select * from `current employee`;

# Attrition Employee ------------------------------------------------------

create view Attrition AS
SELECT count(attrition) Ex_Employee from hr_1 where attrition = 'Yes';

select * from Attrition;

# ----------------------------- KPI 1 ---------------------------------------

# 1. Average Attrition rate for all Departments ----------------------------


select * from hr_1;

create view Dept_average as
select department, round(count(attrition)/(select count(employeenumber) from hr_1)*100,2)  as attrtion_rate
from hr_1
where attrition = "yes"
group by department;

select * from dept_average;




# ---------------------------------- KPI 2  --------------------------------------------

# 2. Average Hourly rate of Male Research Scientist


DELIMITER //
create procedure emp_role (in input_gender varchar(20), in input_jobrole varchar(30))
begin
 select Gender, round(avg(HourlyRate),2) `Avg Hourly Rate` from hr_1
 where gender = input_gender and jobrole = input_jobrole
 group by gender;
end //
DELIMITER ;

call emp_role('female',"Research Scientist");

# ------------------------------ KPI 3 ----------------------------------------------


# 3. Attrition rate Vs Monthly income stats

select * from hr_2;

# for changing the column name
ALTER TABLE hr_2
RENAME COLUMN `Employee ID` TO EmployeeId;
set sql_safe_updates=0;

create view Attrition_employeeincome as
select h1.department,
round(count(h1.attrition)/(select count(h1.employeenumber) from hr_1 h1)*100,2) `Attrtion rate`,
round(avg(h2.MonthlyIncome),2) average_income 
from hr_1 h1 join hr_2 h2
on h1.EmployeeNumber = h2.EmployeeId
where attrition = 'Yes'
group by h1.department;

select * from attrition_employeeincome;



# ------------------------------------ KPI 4 ----------------------------------------------

# 4. Average working years for each Department

Create view `Employee Age` as 
select h1.department,
Round(avg(h2.totalworkingyears),0) Avg_working_yrs 
from hr_1 h1 join hr_2 h2 
on h1.employeenumber = h2.EmployeeId
group by h1.department;

select * from `employee age`;


# --------------------------------------------- KPI 5 --------------------------------------------

# 5. Job Role Vs Work life balance

select * from hr_2;

select h1.jobrole,h2.worklifebalance, count(h2.worklifebalance) Employee_count
from hr_1 h1 join hr_2 h2
on h1.employeenumber = h2.EmployeeId
group by h1.jobrole,h2.worklifebalance
order by h1.jobrole;
 


 # --------------------------------------------- KPI 6-------------------------------------------

# 6. Attrition rate Vs Year since last promotion relation

select * from  hr_2;

select h2.YearsSinceLastPromotion,
count(h1.attrition)  attrition_count
from hr_1 h1 join hr_2 h2 
on h1.employeenumber = h2.EmployeeId
where h1.attrition = 'Yes'
group by YearsSinceLastPromotion
order by YearsSinceLastPromotion;














































