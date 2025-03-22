
-- Quereis 1: Retrieve Indian children’s age, sex, and value in the 5-24 age school attendance dataset.

select
`country or area`,
age,
sex,
value
from undata
where age >=15 and sex = 'male' and `country or area` = 'india'
order by value desc
;


-- Quereis 2: retrieve the country, year, sex, age, and value from the undata table where the value is the maximum recorded value for the source year 2024.

select `country or area`, year, sex, age, value
from undata
where value =
(select
max(value)
from undata
where `source year`= 2024
);


-- Quereis 3: Retreive to country or area, avarage values and maximume values with gender in undata 5-24 age school attendeces 

select
`country or area`, sex,
count(distinct sex) as total_gender_in_country,
round(avg(value),2) as avarage_gender_value,
round(max(value),2) as maximum_gender_value,
round(min(value),2) as minimum_gender_value
from undata
group by `country or area`, sex
order by `country or area` desc;

-- Quereis 4 : retreive country and value to undata school attendence top country values

select `country or area`, value from undata order by value desc limit 1000;

-- Quereis 5: Retrieve the number of distinct years recorded for each country or area in the undata school attendence table

select 
`country or area`, 
count(distinct year) as num_of_year
from undata
group by `country or area`
order by num_of_year desc;

-- Quereis 6: retrieve the top most country value in undata 5-24 age school attendence

select `country or area`,value, year, count(distinct`country or area`) as num_of_country
from undata
where value = (select max(value) from undata )
group by year, `country or area`,value;

-- Quereis 7: analyze data by sex, summing up values for specific age groups and calculating their respective percentages of the total.

select 
sex,
sum(case when age = '6-23' then value = 0 end) as age_6_23_count,
sum(case when age = 5 then value = 0 end) as age_5_count,
sum(case when age = '5-24' then value = 0 end) as age_5_24_count,
sum(case when age = 6 then value = 0 end) as age_6_count,
sum(value) as total_value,
round(COALESCE (sum(case when age = '6-23' then value  end), 0)/nullif(cast(sum(value)as decimal), 0)*100, 2) as age_6_23_rate,
round(coalesce( sum(case when age = 5 then value  end), 0)/nullif (cast(sum(value) as decimal),0)*100, 2) as age_5_rate,
round(coalesce( sum(case when age = '5-24' then value  end), 0)/nullif (cast(sum(value) as decimal),0)*100, 2) as age_5_24_rate,
round(coalesce( sum(case when age = 6 then value  end), 0)/ nullif (cast(sum(value) as decimal), 0)*100, 2) as age_6_rate
from undata
group by sex;

-- Quereis 8: Retreive to country list in undata school attendence table

select distinct `country or area` from undata ;

-- Quereis 9: Retrieve the sum of value grouped by sex and school attendance.

select sex, `school attendance`,
sum(value)
from undata
group by sex, `school attendance`;

-- Quereis 10 : The school attendence to retreive gender attendence percentage rate


select 
sex,
sum(case when `school attendance` = 'total' then value = 0 end) as total_count,
sum(case when `school attendance` = 'attending school' then value = 0 end) as attending_count,
sum(case when `school attendance` = 'not attending school' then value = 0  end) as not_attending_count,
sum(case when `school attendance` = 'not stated' then value = 0 end) as not_stated_count,
sum(value) as total_value,
round(coalesce( sum(case when `school attendance` = 'total' then value end), 0)/nullif(cast(sum(value)as decimal), 0)*100, 2) as total_attendance_rate,
round(coalesce( sum(case when `school attendance` = 'attending school' then value  end), 0)/nullif (cast(sum(value) as decimal),0)*100, 2) as attending_school_rate,
round(coalesce( sum(case when `school attendance` = 'not attending school' then value end), 0)/nullif (cast(sum(value) as decimal),0)*100, 2) as not_attending_rate,
round(coalesce( sum(case when `school attendance` = 'not stated' then value end), 0)/ nullif (cast(sum(value) as decimal), 0)*100, 2) as not_stated_rate
from undata
group by sex;

-- Quereis 11: retreive country along with values in top country in school attendence table

select `country or area`, sum(value) as total_value_country
from undata
group by `country or area`
order by total_value_country desc;


