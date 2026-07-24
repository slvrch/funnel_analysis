--- what is the average length of the customer journey
select avg(total_step)
from (
   select distinct session_id, total_step
   from vw_customer_journey_fe
) t;

--- what is the longest session in terms of steps
select max(total_step)
from vw_customer_journey_fe;

--- distribution of the number of steps per session
select total_step,
   count(distinct session_id)
from vw_customer_journey_fe
group by total_step
order by total_step ;

--- how long do customers typically spend on the website
select avg(total_time_session)
from(
  select distinct session_id, total_time_session
  from vw_customer_journey_fe
)t;

--- do this sessions that make a purchase last longer
select session_purchase, avg(total_time_session)
from (
   select distinct session_id, session_purchase, total_time_session
   from vw_customer_journey_fe
)t
group by session_purchase;

--- the most widely used landing page
select landing_page, count(distinct session_id)
from vw_customer_journey_fe
group by landing_page ;

--- which page do customers most often leave from
select exit_page, count(distinct session_id)
from vw_customer_journey_fe
group by exit_page 
order by count(*) desc;

--- which device has the highest conversion rate
select
   devicetype,
   avg(session_purchase::numeric)
from(
   select distinct session_id, devicetype, session_purchase
   from vw_customer_journey_fe
)t
group by devicetype;

--- which referral generates the highest conversion rate
select referral_source, avg(session_purchase::numeric) as avg_session_purchase
from(
  select distinct session_id, referral_source, session_purchase
  from vw_customer_journey_fe
)t
group by referral_source 
order by avg_session_purchase desc;

--- which country has the highest conversion rate
select country, avg(session_purchase::numeric) as avg_session_purchase
from(
   select distinct session_id, country, session_purchase
   from vw_customer_journey_fe
)t
group by country
order by avg_session_purchase;

--- what time is the traffic at its heaviest
select visit_hour, count(*)
from vw_customer_journey_fe vcjf 
group by vcjf.visit_hour
order by count(*) desc ;

--- what time is the peak conversion rate
select visit_hour, avg(session_purchase::numeric) avg_session_purchase
from (
   select distinct session_id, visit_hour, session_purchase
   from vw_customer_journey_fe vcjf 
)t
group by t.visit_hour 
order by avg_session_purchase desc;

--- does having more items increase conversion rates
select max_items_cart, avg(session_purchase::numeric) as avg_session_purchase
from (
   select distinct session_id, max_items_cart, session_purchase
   from vw_customer_journey_fe vcjf  
)t
group by max_items_cart;

--- the most frequently visited pages apart from the home page
select pagetype, next_page, count(*)
from vw_customer_journey_fe vcjf 
group by pagetype, next_page 
order by count(*) desc;