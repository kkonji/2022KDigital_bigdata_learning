use sqlclass_db;

select * from nobel;

# 1
select * from nobel
where year = 1960 and (subject in ('Physics', 'Peace'));

# 2
select year, subject from nobel
where winner = 'Albert Einstein';

# 3
select year, winner from nobel
where year between 1910 and 1950;

# 4
select subject, winner from nobel
where winner like 'John%';

# 5
select * from nobel 
where (year = 1964) and (subject not in ('Chemistry', 'Medicine')) order by winner;

# 6
select * from nobel 
where (year between 1910 and 1960) and (subject = 'Literature');

# 7
select subject, count(*) from nobel 
group by subject order by count(*) desc;

# 8
select distinct year from nobel 
where year not in (
select year from nobel
where subject in ('medicine')) ;


# 9 - 교수님 버젼
select count(distinct year) from nobel 
where year not in (
select year from nobel
where subject in ('medicine')) ;


# 9
select count(*) from
(select distinct year from nobel 
where year not in (
select distinct year from nobel
where subject in ('medicine')) ) as e;


