# 8. 그룹화와 집계
# 8.1 그룹화의 개념
use sakila;

select customer_id, count(*) from rental r 
group by customer_id ;

# 가장 많이 대여한 회원 찾기
select customer_id, count(*) from rental r 
group by customer_id order by 2 desc;

# 잘못된 필터링 사용 -> group by엔 where 대신 having을 써야 한다.
select customer_id, count(*) from rental 
where count(*) > 40 group by customer_id ;

select customer_id, count(*) from rental r  
group by customer_id having count(*) >= 40;



# 8.2 집계 함수
# max, min, avg, sum, count
desc payment;

# 암시적 그룹 -> group by 안 쓰고 집계함수 사용
# amount열에 집계 함수 계산
select max(amount) as max_amt,
	min(amount) as min_amt,
	avg(amount) as avg_amt,
	sum(amount) as sum_amt,
	count(*) as num_pay
from payment;

# 명시적 그룹 -> group by 쓰고 집계함수 사용
select max(amount) as max_amt,
	min(amount) as min_amt,
	avg(amount) as avg_amt,
	sum(amount) as sum_amt,
	count(*) as num_pay
from payment group by customer_id;


# 고유한 값 계산
# count(distinct 컬럼명) -> 고유한 값 계산
select count(customer_id) as num_rows,
count(distinct customer_id) as num_cust
from payment;

# 집계함수 사용할 때 표현식 사용 가능
select max(datediff(return_date, rental_date))
from rental;


# Null 처리방법
use testdb;
create table number_tb (val smallint);

insert into number_tb values(1);
insert into number_tb values(3);
insert into number_tb values(5);
insert into number_tb values (null);
# 숫자에 대해 5개의 집계 함수 실행
# 함수들이 null 값을 만나면 무시
# count(val) : null값 무시
# count(*) : 전체 행 수 계산, null이 있는 행도 포함
select count(*) as num_rows,
	count(val) as num_vals,
	sum(val) as total,
	max(val) as max_val,
	avg(val) as avg_val
from number_tb ;


# 8.3 그룹 생성
# 단일 열 그룹화
use sakila;

select actor_id, count(*) from film_actor fa 
group by actor_id ;

# 다중 열 그룹화 : 하나 이상의 열을 이용해서 그룹 생성
select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id
group by fa.actor_id , f.rating 
order by 1,2;

# 그룹화와 표현식
# 표현식으로 생성한 값을 기반으로 그룹 생성 가능
select extract(year from rental_date) as year, count(*) as how_many from rental
group by extract(year from rental_date);

# 8.3.4 롤업 생성
# group by 결과로 출력된 항목들의 합계를 나타내는 방법
select fa.actor_id, f.rating, count(*)
from film_actor fa 
	inner join film as f 
	on fa.film_id = f.film_id 
group by fa.actor_id , f.rating with rollup

# 두 가지 필터 조건 사용
# where : 그룹핑을 하기 전에 필터링
# having : 그룹핑한 이후에 필터링
select fa.actor_id, f.rating, count(*)
from film_actor fa 
	inner join film as f
	on fa.film_id =f.film_id 
where f.rating in ('G', 'PG')
group by fa.actor_id, f.rating 
having count(*) > 9;


# 8.5 학습 점검
select customer_id, count(*), sum(amount)
from payment group by customer_id ;
order by 1,2;
