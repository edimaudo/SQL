#sample data
description,category,532,userId,madeOn,amount,currencyCode,excludedFromCalc,,
172410000000000000.00,cash_withdraw_transfer,NEEDS,ObjectId(5e6b5225934dbd0016e86f4b),13/1/20,-40,SGD,FALSE,,
172410000000000000.00,utilities_telecoms,NEEDS,ObjectId(5e6b5225934dbd0016e86f4b),15/1/20,-122.65,SGD,FALSE,,
172410000000000000.00,cash_withdraw_transfer,NEEDS,ObjectId(5e6b5225934dbd0016e86f4b),15/1/20,-60,SGD,FALSE,,
172410000000000000.00,cash_withdraw_transfer,NEEDS,ObjectId(5e6b5225934dbd0016e86f4b),16/1/20,-11.5,SGD,FALSE,,
172410000000000000.00,cash_withdraw_transfer,NEEDS,ObjectId(5e6b5225934dbd0016e86f4b),18/1/20,-120,SGD,FALSE,,
172410000000000000.00,cash_withdraw_transfer,NEEDS,ObjectId(5e6b5225934dbd0016e86f4b),18/1/20,-83,SGD,FALSE,,
172410000000000000.00,cash_withdraw_transfer,MoneyIn-Transfer,ObjectId(5e6b5225934dbd0016e86f4b),19/1/20,10000,SGD,FALSE,,
172410000000000000.00,cash_withdraw_transfer,NEEDS,ObjectId(5e6b5225934dbd0016e86f4b),21/1/20,-80,SGD,FALSE,,
172410000000000000.00,cash_withdraw_transfer,MoneyIn-Transfer,ObjectId(5e6b5225934dbd0016e86f4b),22/1/20,686,SGD,FALSE,,

#using mysql
#532 calculation by user
Select 
q1.DateInfo,q1.Needs_Nominal,q1.Wants_Nominal,q1.Goals_Nominal, q1.MoneyIn_Nominal,q1.Balance_Nominal,
IF(q1.Balance_Nominal > 0,q1.Needs_Nominal / (q1.Needs_Nominal +  q1.Wants_Nominal +  q1.Goals_Nominal + q1.Balance_Nominal),q1.Needs_Nominal / (q1.Needs_Nominal + q1.Wants_Nominal + q1.Goals_Nominal)) as Needs_Percent,
IF(q1.Balance_Nominal > 0,q1.Wants_Nominal / (q1.Needs_Nominal +  q1.Wants_Nominal +  q1.Goals_Nominal + q1.Balance_Nominal),q1.Wants_Nominal / (q1.Needs_Nominal + q1.Wants_Nominal + q1.Goals_Nominal)) as Wants_Percent,
IF(q1.Balance_Nominal > 0,q1.Goals_Nominal / (q1.Needs_Nominal +  q1.Wants_Nominal +  q1.Goals_Nominal + q1.Balance_Nominal),q1.Goals_Nominal / (q1.Needs_Nominal + q1.Wants_Nominal + q1.Goals_Nominal)) as Goals_Percent,
IF(q1.Balance_Nominal > 0,q1.Balance_Nominal / (q1.Needs_Nominal +  q1.Wants_Nominal +  q1.Goals_Nominal + q1.Balance_Nominal),0) as Balance_Percent
From 
(
SELECT DATE_FORMAT(madeOn, "%M %Y") as DateInfo,
ABS(SUM(CASE WHEN `532`='NEEDS' AND excludedFromCalc='FALSE' THEN amount END)) as Needs_Nominal,
ABS(SUM(CASE WHEN `532`='WANTS' AND excludedFromCalc='FALSE' THEN amount END)) as Wants_Nominal,
ABS(SUM(CASE WHEN `532`='GOALS' AND excludedFromCalc='FALSE' THEN amount END)) as Goals_Nominal,
SUM(CASE WHEN `532`='MoneyIn-Transfer' AND `532`='income' AND excludedFromCalc='FALSE' THEN amount END) as MoneyIn_Nominal,
SUM(CASE WHEN `532`='MoneyIn-Transfer' AND `532`='income' AND excludedFromCalc='FALSE' THEN amount END) - (ABS(SUM(CASE WHEN `532`='NEEDS' AND excludedFromCalc='FALSE' THEN amount END)) + ABS(SUM(CASE WHEN `532`='WANTS' AND excludedFromCalc='FALSE' THEN amount END)) + ABS(SUM(CASE WHEN `532`='GOALS' AND excludedFromCalc='FALSE' THEN amount END))) as Balance_Nominal
From Receive_nominal
group by madeOn
) as q1

##Aggregate month-year sales by category
SELECT DATE_FORMAT(madeOn, "%M %Y") as DateInfo,
SUM(CASE WHEN category='allowance' THEN amount END) as allowance,
SUM(CASE WHEN category='auto_vehicle' THEN amount END) as auto_vehicle,
SUM(CASE WHEN category='bars' THEN amount END) as bars,
SUM(CASE WHEN category='cash_withdraw_transfer' THEN amount END) as cash_withdraw_transfer,
SUM(CASE WHEN category='dining' THEN amount END) as dining,
SUM(CASE WHEN category='entertainment' THEN amount END) as entertainment,
SUM(CASE WHEN category='financial_services_charges' THEN amount END) as financial_services_charges,
SUM(CASE WHEN category='government_services' THEN amount END) as government_services,
SUM(CASE WHEN category='groceries' THEN amount END) as groceries,
SUM(CASE WHEN category='healthcare' THEN amount END) as healthcare,
SUM(CASE WHEN category='income' THEN amount END) as income,
SUM(CASE WHEN category='insurance_investment' THEN amount END) as insurance_investment,
SUM(CASE WHEN category='kids' THEN amount END) as kids,
SUM(CASE WHEN category='loans' THEN amount END) as loans,
SUM(CASE WHEN category='rent_mortgage_home' THEN amount END) as rent_mortgage_home,
SUM(CASE WHEN category='shopping' THEN amount END) as shopping,
SUM(CASE WHEN category='snacks' THEN amount END) as snacks,
SUM(CASE WHEN category='transport' THEN amount END) as transport,
SUM(CASE WHEN category='travel' THEN amount END) as travel,
SUM(CASE WHEN category='uncategorised' THEN amount END) as uncategorised,
SUM(CASE WHEN category='utilities_telecoms' THEN amount END) as utilities_telecoms
from Receive_nominal
group by madeOn


