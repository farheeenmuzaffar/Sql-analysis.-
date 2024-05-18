select * from plans;
-- 1. How many customers has Foodie-Fi ever had?
select count(distinct customer_id) as Foodie_fi_customers from subscriptions;

-- 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start
-- of the month as the group by value
select * from subscriptions;
select month(start_date), count(customer_id) as trial_plan
from subscriptions
group by start_date
order by start_date;
