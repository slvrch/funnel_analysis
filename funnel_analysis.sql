------- Funnel Performance -------
--- how many sessions successfully reached each stage of the funnel
select 
   pagetype, count(distinct session_id) as total_session
from vw_customer_journey_fe
group by pagetype, funnel_step
order by funnel_step;

--- what is the conversion rate from the Home page to the Confirmation page
with funnel as (
  select pagetype, count(distinct session_id) total_session
  from vw_customer_journey_fe vcjf 
  group by pagetype 
)
select 
   round(100.0 * (
   select total_session
   from funnel 
   where pagetype = 'confirmation'
   )
   /
   (
   select total_session
   from funnel
   where pagetype = 'home'
   ), 2
 ) overral_conversion_rate;

--- what is the conversion rate between each stage of the funnel
with funnel as (
   select pagetype, count(distinct session_id) total_session
   from vw_customer_journey_fe vcjf 
   group by pagetype 
)
select
   'Home → Product' as step,
   round(
   100.0 *
   (
   select total_session 
   from funnel
   where pagetype = 'product_page'
   )
   /
   (
   select total_session 
   from funnel 
   where pagetype = 'home'
   ), 2
   ) as conversion_rate
   union all
   select
   'Product → Cart',
   round(
   100.0 *
   (
   select total_session from funnel where pagetype = 'cart'
   )
   /
   (
   select total_session from funnel where pagetype = 'product_page'
   ), 2
   )
   union all
   select 'Cart → Checkout',
   round(
   100.0 *
   (
   select total_session from funnel where pagetype = 'checkout'
   )
   /
   (
   select total_session from funnel where pagetype = 'cart'
   ), 2
   )
   union all
   select 'Checkout → Confirmation',
   round(
   100.0 *
   (
   select total_session from funnel where pagetype = 'confirmation'
   )
   /
   (
   select total_session from funnel where pagetype = 'checkout'
   ), 2
   );

--- at which stage do the most users drop out
with funnel as (
   select pagetype, count(distinct session_id) as total_session
   from vw_customer_journey_fe vcjf 
   group by pagetype 
)
select 
  'Home → Product' step,
  round(
  100 -
  (
  100.0*
  (
  select total_session from funnel where pagetype = 'product_page'
  )
  /
  (
  select total_session from funnel where pagetype = 'home'
  )
  ), 2
  ) dropoff
  union all 
  select 'Product → Cart',
  round(
  100-
  (
  100.0*
  (
  select total_session from funnel where pagetype = 'cart'
  )
  /
  (
  select total_session from funnel where pagetype = 'product_page'
  )
  ), 2
  )
  union all 
  select 'Cart → Checkout',
  round(
  100-
  (
  100.0 *
  (
  select total_session from funnel where pagetype = 'checkout'
  )
  /
  (
  select total_session from funnel where pagetype = 'cart'
  )
  ), 2
  )
  union all
  select 'Checkout → Confirmation',
  round(
  100-
  (
  100.0*
  (
  select total_session from funnel where pagetype = 'confirmation'
  )
  /
  (
  select total_session from funnel where pagetype = 'checkout'
  )
  ), 2
  );


-------- Funnel Segmentation ---------

-- is there a difference in conversion rates at each stage of the funnel based on the referral source
with referral_funnel as (
    select
        referral_source,
        count(distinct case when pagetype='home' then session_id end) as home_session,
        count(distinct case when pagetype='product_page' then session_id end) as product_session,
        count(distinct case when pagetype='cart' then session_id end) as cart_session,
        count(distinct case when pagetype='checkout' then session_id end) as checkout_session,
        count(distinct case when pagetype='confirmation' then session_id end) as confirmation_session
    from vw_customer_journey_fe
    group by referral_source
)
select
    referral_source,
    round(product_session*100.0/home_session,2) as home_to_product,
    round(cart_session*100.0/product_session,2) as product_to_cart,
    round(checkout_session*100.0/cart_session,2) as cart_to_checkout,
    round(confirmation_session*100.0/checkout_session,2) as checkout_to_confirmation,
    round(confirmation_session*100.0/home_session,2) as overall_conversion
from referral_funnel
order by overall_conversion desc;

--- does the conversion rate vary across different devices
with device_funnel as (
select
devicetype,
count(distinct case when pagetype='home' then session_id end) home_session,
count(distinct case when pagetype='product_page' then session_id end) product_session,
count(distinct case when pagetype='cart' then session_id end) cart_session,
count(distinct case when pagetype='checkout' then session_id end) checkout_session,
count(distinct case when pagetype='confirmation' then session_id end) confirmation_session
from vw_customer_journey_fe
group by devicetype
)
select
devicetype,
round(product_session*100.0/home_session,2) home_to_product,
round(cart_session*100.0/product_session,2) product_to_cart,
round(checkout_session*100.0/cart_session,2) cart_to_checkout,
round(confirmation_session*100.0/checkout_session,2) checkout_to_confirmation,
round(confirmation_session*100.0/home_session,2) overall_conversion
from device_funnel
order by overall_conversion desc;

--- which country has the greatest potential to generate sales
with country_funnel as (
select
country,
count(distinct case when pagetype='home' then session_id end) home_session,
count(distinct case when pagetype='confirmation' then session_id end) confirmation_session
from vw_customer_journey_fe
group by country
)
select
country,
home_session,
confirmation_session,
round(
confirmation_session*100.0/home_session,
2
) as confirmation_rate
from country_funnel
order by confirmation_rate desc;

-- at what time do users have the greatest chance of completing the funnel
with hour_funnel as (
select
visit_hour,
count(distinct case when pagetype='home' then session_id end) home_session,
count(distinct case when pagetype='confirmation' then session_id end) confirmation_session
from vw_customer_journey_fe
GROUP BY visit_hour
)
select
visit_hour,
home_session,
confirmation_session,
round(
confirmation_session*100.0/home_session,
2
) as confirmation_rate
from hour_funnel
order by confirmation_rate desc;


------ Funnel Diagnosis ------

--- which page is most often the last page a user views before leaving the site
select 
   row_number() 
   over(
   order by count(distinct session_id) desc
   ) as rank,
   exit_page,
   count(distinct session_id) total_exit,
   round(
    100.0 *
    count(distinct session_id)
    /
    (
    select count(distinct session_id)
    from vw_customer_journey_fe
    ), 2
   ) exit_rate
from vw_customer_journey_fe
group by exit_page;


--- from which page do users most often navigate away
with transition as (
   select 
     pagetype,
     next_page,
     count(*) total_transition
   from vw_customer_journey_fe
   group by pagetype, next_page 
)
select 
    pagetype,
    next_page,
    total_transition,
    round(
    100.0 *
    total_transition
    /
    sum(total_transition)
    over(partition by pagetype), 2
    ) transition_rate
from transition 
order by pagetype, total_transition desc;

-- what is the most common sequence of pages visited during a single session
with customer_path as (
  select 
      session_id,
      string_agg(
         pagetype,
         '→'
         order by step_number
      ) as customer_path
   from vw_customer_journey_fe
   group by session_id 
)
select 
   customer_path,
   count(*) as total_session,
   round(
     count(*)*100.0
     /
     (
     select count(*)
     from customer_path
     ), 2
   ) as percentage
from customer_path 
group by customer_path 
order by total_session desc;

-- do sessions that result in a successful purchase last longer
select 
   session_purchase,
   avg(total_time_session) as avg_session_duration,
   min(total_time_session) as min_duration,
   max(total_time_session) as max_duration
from(
  select distinct session_id, session_purchase, total_time_session
  from vw_customer_journey_fe
)t
group by session_purchase ;

-- before logging out, which page is the user on
select 
   previous_page,
   exit_page,
   count(*) as total_session
from vw_customer_journey_fe
where pagetype = exit_page 
group by previous_page, exit_page 
order by total_session desc;

-- what is the average time taken for a purchase to be completed
select avg(total_time_session) as avg_purchase_duration, max(total_time_session) as max_duration, min(total_time_session) as min_duration
from(
  select distinct session_id, total_time_session
  from vw_customer_journey_fe
  where session_purchase = 1
)t;


-- how many pages are usually viewed before the session ends
select 
   exit_page, 
   avg(total_step) as avg_step_before_exit
from(
  select distinct session_id, exit_page, total_step
  from vw_customer_journey_fe
)t
group by exit_page 
order by avg_step_before_exit desc;


--- whats is the distribution of sessions by number of steps
select 
   total_step,
   count(distinct session_id) as total_session,
   round(
      count(distinct session_id)*100.0
      /
      (
      select count(distinct session_id)
      from vw_customer_journey_fe
      ), 2
   ) as session_percentage
from vw_customer_journey_fe
group by total_step
order by total_step ;