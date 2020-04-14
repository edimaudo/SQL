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

##top three categories with the most backers, length of campaigns

##top three categories with the least backers and length of campaigns

##top three categories that raised the most money 

##top three categories that raised the least money 

##What is the amount the most successful board game company raised and how many backers

##rank the top three countries with the most successful campaign in terms of dollars and campaigns backed

##look at campaign lengths and the amount of money raised
