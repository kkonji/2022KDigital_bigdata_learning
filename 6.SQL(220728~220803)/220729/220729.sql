# 3. 쿼리 입문

# 데이터베이스 선택
use sakila;

select * from language;

select name from language;

select name, last_update from language;

# select 절에 추가할 수 있는 항목: 
# 숫자 혹은 문자열, 표현식, 내장함수 호출 및 사용자 정의 함수 호출
select language_id, 
'common' language_usage,    # 원래 테이블에는 없음
language_id * 3.14 lang_pi_value,
upper(name) language_name   # 컬럼 이름 변경
from language;

# 위의 것들을 열의 별칭(alias) 라고 부른다.
# as 를 붙임으로써 가독성을 향상할 수 있다.

select language_id, 
'common' as language_usage,    # 원래 테이블에는 없음
language_id * 3.14 as lang_pi_value,
upper(name) as language_name   # 컬럼 이름 변경
from language;


# 중복 제거

select * from film_actor;

# 원래 all은 디폴트값이라 있든 없든 상관없다.
select all actor_id from film_actor order by actor_id;
# distinct로 중복 제거 - 데이터 양이 많으면 시간이 많이 걸리므로 마구잡이로 하는 것은 자제
select distinct actor_id from film_actor order by actor_id;

# from 절
# 1. 쿼리에 사용되는 테이블을 명시
# 2. 테이블을 연결하는 수단

/* 테이블 유형
 * 영구 테이블 : create table문으로 생성
 * 파생 테이블 : 하위 쿼리에서 반환하고 메모리에 보관된 행들
 * 임시 테이블 : 메모리에 저장된 휘발성 데이터
 * 가상 테이블 : craete view문으로 생성 
 */

# 파생 테이블 만들기 - subquery 9장 참조
# from 절에 위치한 select문(서브쿼리)은 실행 결과로 테이블을 생성
# select ... from subquery [AS] tbl_name ...

select concat(cust.last_name, ', ', cust.first_name) as full_name
from
( select first_name, last_name, email 
from customer 
where first_name = 'JESSIE')   # from 서브쿼리
as cust;  # 서브쿼리의 별칭을 cust로 쓰겠다.

# 내부에 있던 부분
select first_name, last_name, email 
from customer 
where first_name = 'JESSIE';

# 임시 테이블 만들기 : 데이터 베이스 세션이 닫힐 때 사라짐
create temporary table actor_j 
(actor_id smallint(5),   # smallint(숫자) : '숫자'자리 맞춤을 의미
first_name varchar(45),
last_name varchar(45)
);

insert into actor_j   # J로 시작하는 문자율을 들고오라. 
select actor_id, first_name, last_name from actor 
where last_name like 'J%'; 

select * from actor_j;

/* 가상 테이블(view)만들기
 * SQL 쿼리의 결과 셋을 기반으로 만들어진 가상 테이블
 * 실제 데이터가 저장되는 것이 아닌, view를 통해 데이터를 관리
 * 복잡한 쿼리문을 매번 사용하지 않고, 가상 테이블로 만들어서 쉽게 접근
 * create view [뷰이름] as 
 * select [컬럼명1], ... from [테이블명] 
 */
 
create view cust_vw as
select customer_id, first_name, last_name, active
from customer;

select first_name, last_name from cust_vw
where active = 0;

# 가상 테이블 삭제
# drop view 뷰이름;


/* 3.4 where 절
 * 테이블 연결: join(inner join) : 2개 이상의 테이블을 묶어서 하나의 결과셋을 만들어 내는 것.
 * select <열 목록>
 * from <기준 테이블> [inner] join <참조할 테이블>
 * on <조인 조건> [where <검색조건>]
 */
# 값 확인
select * from customer;
select * from rental;

# 합칠 때 기준테이블을 기준으로 합침
select customer.first_name, customer.last_name ,
time(rental.rental_date) as rental_time
from customer inner join rental
on customer.customer_id = rental.customer_id 
where date(rental.rental_date) ='2005-06-14';

# 별칭을 사용
select c.first_name, c.last_name ,
time(r.rental_date) as rental_time
from customer c inner join rental r
on c.customer_id = r.customer_id 
where date(r.rental_date) ='2005-06-14';

# date함수 -> 날짜 추출, time함수 -> 시간 추출
select date('2022-07-29 10:35:45') as day1;
select time('2022-07-29 10:35:45') as time1;


# 3.5 where 절 - 필터 조건: and, or, not 등 사용
select title from film 
where rating= 'G' and rental_duration >= 7;

select title, rating, rental_duration from film
where (rating='G' and rental_duration >= 7) 
or (rating='PG-13' and rental_duration <4);


# 3.6 group by절과 having절
# select 컬럼 from 테이블 group by 그룹화할 컬럼;
# having : 특정 열을 그룹화한 결과에 조건을 설정 (그룹화 이후에 수행되는 조건)
# where : 그룹화 하기전에 필터링 조건

# count(*) : 그룹화한 전체 행의 수
select c.first_name, c.last_name, count(*)
from customer as c
inner join rental as r 
on c.customer_id  = r.customer_id 
group by c.first_name , c.last_name 
having count(*) >= 30;


/* 3.7 order by 절
 * order by [컬럼명] [asc|desc]
 * 지정된 컬럼을 기준으로 결과를 정렬
 * 다중 컬럼인 경우, 왼쪽부터 정렬
 */

select c.first_name, c.last_name,
time(r.rental_date) as rental_time
from customer as c
inner join rental as r 
on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14'
order by c.last_name, c.first_name asc;

select c.first_name, c.last_name,
time(r.rental_date) as rental_time
from customer as c
inner join rental as r 
on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14'
order by time(r.rental_date) desc;

# 컬럼의 순서(index) 사용해서 정렬
select c.first_name,	c.last_name,
time(r.rental_date)	as rental_time
from customer	as c
inner join rental	as r
on c.customer_id =	r.customer_id
where date(r.rental_date)	=	'2005-06-14'
order by 1 desc;


# 3.8 연습문제
select actor_id, first_name, last_name from actor order by last_name , first_name ;

select actor_id, first_name, last_name from actor where (last_name = 'WILLIAMS') or last_name = 'DAVIS';

select * from rental;

select distinct customer_id from rental
where date(rental_date) = '2005-07-05';


select c.store_id,	c.email,	r.return_date
from customer	as c
inner join rental	as r
on  c.customer_id  =r.customer_id 
where date(r.rental_date)	=	'2005-06-14'
order by return_date desc;




# 4. 필터링

# 4.1 조건 평가 -생략
# 4.2 조건 작성
/* 하나 이상의 연산자와 결합된 표현식으로 구성
 * 표현식
 * 1. 숫자
 * 2. 테이블 또는 뷰의 열
 * 3. 문자열
 * 4. concat()과 같은 내장 함수
 * 5. 서브 쿼리
 * 6. ('Boston', 'New York', 'Chicago')와 같은 표현식 목록
 */

/* 조건 연산자
 * 비교 연산자: =, !=, <, >, <>, like, in , between
 * 산술 연산자: +, -, *, /
 */

# 4.3 조건 유형
# 동등 조건: 열 = 표현/값

select c.email
from customer as c
inner join rental as r 
on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14';
# 부등 조건: 두 표현식이 동일하지 않음
# 동등,부등 조건을 이요애서 데이터를 수정/제거 할 수 있다.

/* 범위 조건
 * 해당 식이 특정 범위 내에 있는지 확인
 */
# 2005-06-14 00:00:00 ~ 2005-06-16 00:00:00 라서 14,15일만 출력 
select customer_id, rental_date from rental 
where rental_date <= '2005-06-16'
and rental_date  >= '2005-06-14';

# 2005-06-14 ~ 2005-06-16 날짜 모두 출력
select customer_id, rental_date from rental 
where date(rental_date) <= '2005-06-16'
and date(rental_date)  >= '2005-06-14';

# between 연산자
# between [범위의 하한값] and [범위의 상한값]: 상한과 하한이 범위에 포함됨
select customer_id, rental_date from rental r
where rental_date between '2005-06-14' and '2005-06-16';

select customer_id, rental_date from rental r
where rental_date between '2005-06-15 06:00:00' and '2005-06-16 23:00:00';

select customer_id, payment_date, amount 
from payment
where amount between 10.0 and 11.99;

# 문자열 범위
# last_name이 'FA'와 'FRB'로 시작하는 데이터 리턴
select last_name, first_name from customer 
where last_name between 'FA' and 'FRB';


# or 또는 in() 연산
# 유한한 값의 집합으로 제한
# 지정한 컬럼의 값이 특정 값에 해당되는 조건을 만들 때 사용
select title, rating from film 
where rating = 'G' or rating = 'PG';

select title, rating from film 
where rating in ('G', 'PG');

# 서브 쿼리 사용
/* 
 * 'PET%' :PET로 시작하는 단어
 * '%PET' :PET로 끝나는 단어
 * '%PET%': PET를 포함하는 단어
 */
select title, rating from film
where rating in 
(select rating from film
where title like '%PET%');

# NOT IN 사용
# 표현식 내에 존재하지 않음
select title, rating from film
where rating not in ('PG-13', 'R', 'NC-17');

# 문자열 부분 가져오기
# left, mid, right
select left('abcdefg', 3) l;

select right('abcdefg', 2) r;

select mid('abcdeft', 2,3) m;

# 와일드 카드
# '_' : 정확히 한 문자
# '%' : 개수에 상관없이 모든 문자 포함

select last_name, first_name from customer 
where last_name like '_A_T%S';
# '_A_T%S' : 2번째 위치에 A, 4번째 위치에 T, 마지막에 S

select last_name, first_name from customer 
where last_name like 'Q%' or last_name like 'Y%';

# 정규 표현식 사용
select last_name, first_name from customer
where last_name regexp '^[QY]';



# 4.4 Null
# Null 값의 다양한 경우
# - 해당 사항 없음
# - 아직 알려지지 않은 값
# - 정의되지 않은 값

/* Null의 특징
 * Null일 수는 있지만 null과 같을 수는 없습니다.
 * 두개의 null은 서로 같지 않습니다.
 */
# is null 사용 (is not null도 사용가능)
select rental_id, customer_id, return_date from rental where return_date is null 
or return_date not between '2005-05-01' and '2005-09-01';

# 잘못된 예시 =null은 먹히지 않는다.
select rental_id, customer_id, return_date from rental where return_date = null ;


# 4.5 실습
select payment_id, customer_id, amount, date(payment_date) payment_date from payment
where (payment_id between 101 and 120); 

select payment_id, customer_id, amount, date(payment_date) payment_date from payment
where (payment_id between 101 and 120)
and customer_id !=5 and (amount >8 or date(payment_date) ='2005-08-23');

select payment_id, customer_id, amount, date(payment_date) payment_date from payment
where (payment_id between 101 and 120)
and customer_id = 5 and not(amount >6 or date(payment_date) = '2005-06-19'); 

select amount from payment
where amount in (1.98, 7.98, 9.98);

select * from customer
where last_name like '_AW%';
