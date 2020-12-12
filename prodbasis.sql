#Set segment
set @Segment:="ACT";
set @CurrentDate:=CURDATE();

Select *
From prod p inner join basis b on p.`MODEL_TYPE` = b.`MODEL_TYPE`
Where b.Segment = @Segment
and p.`UNIT_STATUS` = "In Production"
and p.`READINESS_DATE` <= @CurrentDate
