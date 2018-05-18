/*Pivoting data*/

Create table v_dailyproducts (
Year int,
Month int, 
Day int, 
Product varchar(10),
Packages int,
Sales int
);
 
    
select v.Year, v.Month, v.Day,
sum(IF(v.Product='Product A', v.`Packages`, 0 )) as PackageA,
sum(IF(v.Product='Product B', v.`Packages`, 0 )) as PackageB,
sum(IF(v.Product='Product C', v.`Packages`, 0 )) as PackageC,
sum(IF(v.Product='Product D', v.`Packages`, 0 )) as PackageD,
sum(IF(v.Product='Product A', v.`Sales`, 0 )) as PackageASales,
sum(IF(v.Product='Product B', v.`Sales`, 0 )) as PackageBSales,
sum(IF(v.Product='Product C', v.`Sales`, 0 )) as PackageCSales,
sum(IF(v.Product='Product D', v.`Sales`, 0 )) as PackageDSales
from v_dailyproducts as v 
group by v.Year, v.Month, v.Day;
