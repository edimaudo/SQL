##
##Objective is to insights into Kickstarter campaigns
##

## data dictionary mainly for camapaign column
/*name - project name
sub category id - the industry/category
country - id corresponding to country
currency - id corresponding to currency
launched - date fundraising 
goal - desired amount
pledged - how much was promised
backers - how many individuals contributed
outcome - was the project funded or not*/



## Data located in ks-data.sql and loaded into MySQL

##dollar amount raised between successful and unsuccessful campaigns, average amount, length of campaigns
Select c1.outcome, avg(c1.total_goal) as average_goal, sum(c1.campaign_length_in_days) as campaign_length_in_days
from 
(select c.outcome, sum(c.goal) as total_goal, DATEDIFF(c.deadline,c.launched) as campaign_length_in_days
from campaign as c
where c.outcome in ("successful",'failed')
group by c.outcome,DATEDIFF(c.deadline,c.launched)) as c1
group by c1.outcome

##What country raise the most amount
Select c2.name as country_name, sum(c1.pledged) as total
from campaign c1, country c2
where c1.`country_id` = c2.`id`
and c1.outcome = "successful"
group by c2.name
order by sum(c1.pledged) DESC
limit 1

##top three categories with the most backers, length of campaigns
SELECT c3.category, sum(c3.number_of_backers), sum(c3.campaign_length_in_days)
from (Select c2.`name` as category, sum(c1.`backers`) as number_of_backers, DATEDIFF(c1.deadline,c1.launched) as campaign_length_in_days
from campaign c1, category c2
where c1.`sub_category_id` = c2.`id`
group by c2.`name`,DATEDIFF(c1.deadline,c1.launched)) c3
group by c3.category
order by 2 DESC
limit 3;

##top three categories with the least backers and length of campaigns
SELECT c3.category, sum(c3.number_of_backers), sum(c3.campaign_length_in_days)
from (Select c2.`name` as category, sum(c1.`backers`) as number_of_backers, DATEDIFF(c1.deadline,c1.launched) as campaign_length_in_days
from campaign c1, category c2
where c1.`sub_category_id` = c2.`id`
group by c2.`name`,DATEDIFF(c1.deadline,c1.launched)) c3
group by c3.category
order by 2 asc
limit 3;

##top three categories that raised the most money 
SELECT c3.category, sum(c3.pledges)
from (Select c2.`name` as category, sum(c1.`pledged`) as pledges
from campaign c1, category c2
where c1.`sub_category_id` = c2.`id`
group by c2.`name`) c3
group by c3.category
order by 2  desc
limit 3;

##top three categories that raised the least money 
SELECT c3.category, sum(c3.pledges)
from (Select c2.`name` as category, sum(c1.`pledged`) as pledges
from campaign c1, category c2
where c1.`sub_category_id` = c2.`id`
group by c2.`name`) c3
group by c3.category
order by 2  asc
limit 3;

##What is the amount the most successful board game company raised and how many backers

##rank the top three countries with the most successful campaign in terms of dollars and campaigns backed
select c2.name as country_name, sum(c1.pledged) as total_pledges, sum(c1.backers) as total_backers
from campaign c1, country c2
where c1.country_id = c2.`id`
group by c2.name
order by 2 desc, 3 desc
limit 3

##look at campaign lengths and the amount of money raised
Select DATEDIFF(c1.deadline,c1.launched) as campaign_length_in_days, sum(c1.`pledged`) as pledges
from campaign c1
group by DATEDIFF(c1.deadline,c1.launched)
order by 1 desc
