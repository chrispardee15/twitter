-- Data of 2013 census of baby names used in NY state

use cpardee;
-- 1) all names with 10,000 or more entries
select * from Babies where Count >= 10000;
-- 2) top 10 most frequent names
select * from Babies order by Count desc limit 10;
-- 3) all names with 10 or fewer entries
select * from Babies where Count = 10;
-- 4) all names that have only 5 entries
select * from Babies where Count = 5;
-- 5) All names with an even number of entries between 500 and 2000
select * from Babies where (Count%2) = 0 and Count > 500 and Count <2000 order by Count asc;
-- 6) Find all babies with names that start with Z
select * from Babies where Name like 'Z%';
-- 7) select any name that has a q in it
select * from Babies where Name like '%q%';
-- 8) Compare # of male/female Jordans
select Name, Sex, Count from Babies where Name='Jordan';
-- 9) Gender totals
select  Sex, Count from Babies group by Sex;
 -- 10) All names that start with "Re"
select * from Babies where Name like 'Re%';
