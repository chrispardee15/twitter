use cpardee;

-- 1) List a student by only last name with associated data
	select * from dalton_t where last_name = 'pardee';
-- 2) All student with the same last name with same birthday (twins)
	select a.* from dalton_t a inner join (select last_name, birth_day, birth_month, birth_year from dalton_t group by last_name, birth_day, birth_month, birth_year having count(*) >1) b on a.last_name = b.last_name and a.birth_day = b.birth_day and a.birth_month = b.birth_month and a.birth_year = b.birth_year order by last_name;
-- 3) All students with same birth month
	select * from dalton_t where birth_month = '10';
-- 4) All student by a specific House
	select * from dalton_t where advisor = 'Herrera/Hopkins';
-- 5) A sorted list of students by last name
	select * from dalton_t order by last_name;
-- 6) A report by gender (totals only)
	select sex_code, count(*) from dalton_t group by sex_code;
-- 7) Total number of fourth-grade vs “K”
	select current_grade, count(*) from dalton_t group by current_grade;
-- 8)  All students born in 2001
	select * from dalton_t where birth_year = 2001;
-- 9)  First name frequency (top 10)
	select first_name, count(*) as frequency from dalton_t group by first_name order by frequency desc limit 10;
-- 10) Students by grade
	select * from dalton_t order by current_grade; 
