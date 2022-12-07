# 5장. 다중 테이블 쿼리
 /* 조인(join) : 두 테이블의열을 하나의 결과셋에 포함하도록 연결
 *ERD : 테이블 관계도를 그리는 그림
 *테이블을 잘라놓는 이유: 데이터가 커지므로 빨리 서치하기 위해서 잘게 쪼개게 됨
 *self join, right join, full join, inner join, cross join, left join	
 */
use sakila;

desc customer;

desc address;

# 한 쿼리에서 두 테이블의 데이터 검색
# 5.1.1 데카르트 곱  -> 교차 조인, on 조건이 없는것이 특징
# select 열이름.. from 테이블1 join 테이블2;
select c.first_name, c.last_name, a.address from customer c join address a;

# 5.1.2 내부 조인
# select 열이름 .. from 테이블1 join 테이블2 
# on 테이블1.열이름 = 테이블2.열이름 (조인할 열이름 매치)
select c.first_name, c.last_name, a.address 
from customer c join address a 
on c.address_id  = a.address_id ;

select c.first_name, c.last_name, a.address 
from  address a  join customer c
on a.address_id  = c.address_id ;

# 두 테이블을 조인할 때 열 이름이 동일한 경우 using 사용 가능
select c.first_name, c.last_name, a.address
from customer c inner join address a
using (address_id);

# 외부조인 기본 (10장에서 자세히 소개)
-- SELECT <열 목록>
-- FROM <첫 번째 테이블(LEFT)>
-- <LEFT | RIGHT | FULL> [OUTER] JOIN <두 번째 테이블(RIGHT)>
-- ON <조인 조건>
-- [WHERE 검색조건];


# 5.1.3 ANSI 조인문법
# ANSI 조인문법 이전의 문법에선 ON 대신 WHERE을 사용
select c.first_name, c.last_name, a.address
from customer c, address a
where c.address_id = a.address_id;

/* ANSI 조인 문법이 가지는 이점
 * 조인 조건과 필터조건은 이해하기 쉽게 두개의 각각 다른 절로 구분
 * 각 테이블 쌍에 대한 조인 조건이 on절에 포함되어 있으므로 조인 조건의 일부가 실수로 누락될 가능성이 낮음
 * SQL92 조인 문법을 사용하는 쿼리는 표준화되어 있으므로 데이터베이스 서버 간에 이식이 가능하지만 예전 문법은 서버마다 약간씩 달라서 이식이 쉽지 않습니다.
 */

select c.first_name, c.last_name, a.address
from customer c, address a
where c.address_id = a.address_id
and a.postal_code  = 52137;
# on 조건과 where조건이 구분되어 있지 않아서 조인 조건 누락 여부를 알기가 어렵다. 

select c.first_name, c.last_name, a.address
from customer c inner join address a
on c.address_id = a.address_id
where a.postal_code  = 52137;



# 5.2 세 개 이상 테이블 조인
# from절에 3개의 테이블, 2개의 조인유형, 2개의 on 하위절
# select 열이름들 from 테이블1 inner join 테이블2
# on 테이블1.열이름 = 테이블2.열이름
# inner join 테이블3
# on 테이블2.열이름 = 테이블3.열이름
select c.first_name, c.last_name, a.address
from customer c inner join address a
on c.address_id = a.address_id
inner join city ct 
on a.city_id = ct.city_id;

# inner join하는 테이블들의 순서는 상관없다.


# 5.2.1 서브쿼리 사용
select c.first_name, c.last_name, addr.address, addr.city 
from customer c inner join 
(select a.address_id, a.address, ct.city 
from address a inner join city ct 
on a.city_id = ct.city_id 
where a.district = 'California'
) addr
on c.address_id  = addr.address_id;


# 5.2.2 테이블 재사용
select f.title
from film f inner join film_actor fa 
on f.film_id  = fa.film_id 
inner join actor a 
on fa.actor_id = a.actor_id 
where ((a.first_name ='CATE' and a.last_name = 'MCQUEEN') or (a.first_name = 'CUBA' and a.last_name = 'BIRCH'));


# 두 배우가 모두 출연한 영화를 검색
select f.title from film f
inner join film_actor fa1
on f.film_id = fa1.film_id 
inner join actor a1
on fa1.actor_id  = a1.actor_id 
inner join film_actor fa2
on f.film_id = fa2.film_id 
inner join actor a2
on fa2.actor_id  = a2.actor_id 
where (a1.first_name ='CATE' and a1.last_name = 'MCQUEEN') 
and (a2.first_name = 'CUBA' and a2.last_name = 'BIRCH');


# 5.3 셀프 조인
# 자기 자신과 조인 하는 것을 셀프조인 : 반드시 alias를 사용해야한다
# 자기 참조 외래 키
select f.title, f_prnt.title as prequel
from film as f inner join film as f_prnt 
on f_prnt.film_id = f.prequel_film_id
where f.prequel_film_is is not null;

use sqlclass_db;

create table customer
(customer_id smallint unsigned, 
first_name varchar(20),
last_name varchar(20),
birth_date date,
spouse_id smallint unsigned,
constraint primary key (customer_id));

desc customer;

insert into customer	(customer_id,	first_name,	last_name,	birth_date,	spouse_id)
values
(1,	'John',	'Mayer',	'1983-05-12',	2),
(2,	'Mary',	'Mayer',	'1990-07-30',	1),
(3,	'Lisa',	'Ross',	'1989-04-15',	5),
(4,	'Anna',	'Timothy',	'1988-12-26',	6),
(5,	'Tim',	'Ross',	'1957-08-15',	3),
(6,	'Steve',	'Donell',	'1967-07-09',	4);

select * from customer;


select cust.customer_id, cust.first_name , cust.last_name ,cust.spouse_id , spouse.first_name , spouse .last_name 
from customer as cust
join customer as spouse
on cust.spouse_id =spouse.customer_id;


# 순차성 데이터
create table instruction (
id smallint unsigned auto_increment,
content varchar(40),
previous_id smallint,
next_id smallint,
constraint primary key (id)
);

insert into instruction 
(content, previous_id, next_id)
values ('Preheat an oven to 220 degrees C.', null, 2),
('Peel four potatoes.', 1, 4),
('Toss sliced potatoes with oil.', 4,6),
('Cut potatoes into slices.', 2,3),
('Sea hot slices with salt and pepper.', 6, null),
('Bake in the oven for 20 minutes.', 3, 5);

# ???
select * from instruction i ;
select i1.id, i1.content ,i2.content,i3.content  from instruction i1
inner join instruction i2
on i1.next_id  = i2.id 
inner join instruction i3
on i2.next_id = i3.id
inner join instruction i4
on i3.next_id = i4.id;

# 5.4
# 연습문제1
select title from film f
inner join film_actor fa
on f.film_id  = fa.film_id
inner join actor a
on a.actor_id = fa.actor_id
where a.first_name = 'JOHN';



# 연습문제2
select a.city_id , a.address, a_prnt.address from address a 
inner join address a_prnt 
on a_prnt.city_id  = a.city_id 
where (a.address_id != a_prnt.address_id);



# 6. 집합 연산자
/* 집합 연산 규칙: 같은 수의 열을 가져야 함
 * 각 열의 자료형은 서로 동일해야 함
 */
# union 연산자 : 결합된 집합을 정렬하고 중복을 제거
# union all 연산자 : 최종 데이터셋의 행의 수는 결합되는 집합의 행의 수의 총합과 같음
# union all 연산자 : 중복되는 모든 값을 보여줌
select 1 as num, 'abc' as str
union select 9 as num, 'xyz' as str;

# unoin 사용
select 1 as num, 'abc' as str
union select 1 as num, 'abc' as str;

# union all 사용
select 1 as num, 'abc' as str
union all select 1 as num, 'abc' as str;

use sakila;

desc customer;
desc actor;

# union all 테스트
select 'CUST' as type1, c.first_name, c.last_name 
from customer c  
union all
select 'ACTR' as type1, a.first_name, a.last_name
from actor a;


select 'CUST' as type1, c.first_name, c.last_name 
from customer c  
where c.first_name like 'J%' and c.last_name like 'D%'
union all
select 'ACTR' as type1, a.first_name, a.last_name
from actor a where a.first_name like 'J%' and a.last_name like 'D%';

# 집합 연산자 intersect
# MySQL 8.0에서 지원 안함, inner join으로 동일한 결과 얻을 수 있음
select c.first_name , c.last_name from customer c 
inner join actor as a
on (c.first_name= a.first_name)
and (c.last_name = a.last_name);


# 집합 연산 규칙 (복합쿼리)
# 열 이름 정의는 복합 쿼리의 첫 번째 쿼리에 있는 열의 이름 사용
# 복합쿼리는 위-> 아래로 실행
select  c.first_name as fname , c.last_name as lname
from customer c  
where c.first_name like 'J%' and c.last_name like 'D%'
union all
select  a.first_name, a.last_name
from actor a where a.first_name like 'J%' and a.last_name like 'D%'
order by fname, lname desc;


# union all과 union 사용
select  a.first_name as fname , a.last_name as lname
from actor a 
where a.first_name like 'J%' and a.last_name like 'D%'
union all
select  a.first_name, a.last_name
from actor a where a.first_name like 'M%' and a.last_name like 'T%'
union 
select  c.first_name, c.last_name
from customer c where c.first_name like 'J%' and c.last_name like 'D%';


# 6.5 학습 점검
# 6.5.2 
use sakila;
select first_name, last_name from actor 
where last_name like 'L%'
union 
select first_name, last_name from customer 
where last_name like 'L%';

# 6.5.3
select first_name, last_name from actor 
where last_name like 'L%'
union 
select first_name, last_name from customer 
where last_name like 'L%'
order by last_name;


# 기존 테이블 지우고 새로운 테이블 생성
# drop table if exists customer;



# 7장. 데이터 생성, 조작과 변환
/* 7.1 문자열 데이터 처리
 * 1. char : 고정 길이 문자열 자료형, mysql 255글자
 * 2. varchar : 가변 길이 문자열 자료형, mysql 65536글자
 * 3. text : 매우 큰 가변 길이 문자열 저장, 최대 4GB 크기 문서 저장
 */
use testdb;

create table string_tbl (
	char_fld char(30),
	vchar_fld varchar(30),
	text_fld text
);

insert into string_tbl (char_fld, vchar_fld, text_fld)
values ('This is char data', 'This is varchar data', 'This is text data');

select * from string_tbl;

# varchar 문자열 처리
# update 문으로 vchar_fld 열에 설정 길이보다 더 긴 문자열 저장

update string_tbl
set vchar_fld = 'This is a piece of extremely long varchar data';
# 길이가 너무 길어서 오류 발생

# 작은 따옴표 포함
# escape 문자 추가(' 또는 \)

update string_tbl 
set text_fld = 'This string didn''t work, but it does not';

update string_tbl 
set text_fld = 'This string didn\'t work, but it does now';

# quote 내장 함수
# 전체 문자열을 따옴표로 묶고, 문자열 내의 작은 따옴표에 escape 문자 추가

select quote(text_fld) from string_tbl;

# 7.1.2 length() 함수
insert into string_tbl (char_fld, vchar_fld, text_fld)
values ('This string is 28 char', 'This string is 28 char', 'This string is 28 char');

select length(char_fld) from string_tbl ;

# position() 함수
# 부분 문자열의 위치를 반환, 위치를 찾을 수 없는 경우 0
select position('char' in vchar_fld)
from string_tbl ;

# locate('문자열', 열이름, 시작위치) 함수
# 특정 위치의 문자부터 검색, 검색의 시작 위치 정의
select locate('is' , vchar_fld, 5)
from string_tbl ;

# strcmp(문자열1 문자열2) 함수
-- if 문자열1 < 문자열2 , -1 반환
-- if 문자열1 == 문자열2, 0 반환
-- if 문자열1 > 문자열2, 1 반환

insert into string_tbl(vchar_fld)
values ('abcd'), ('xys'),('QRSTYV'),('qrstuv'), ('12345');


select strcmp('12345',	'12345')	12345_12345,
strcmp('abcd',	'xyz')	abcd_xyz,
strcmp('abcd',	'QRSTUV')	abcd_QRSTUV,
strcmp('qrstuv',	'QRSTUV')	qrstuv_QRSTUV,
strcmp('12345',	'xyz')	12345_xyz,
strcmp('xyz',	'qrstuv')	xyz_qrstuv;


# 7.1.2 문자열 조작(문자열 비교)
# like 또는 regexp 연산자 사용
use sakila;

select name, name like '%y' as ends_in_y from category;

select name, name regexp 'y$' ends_in_y from category;

# concat() 함수 : 문자열을 연결하는 함수
select concat(first_name, ' ', last_name) as cust from customer;
# insert() 함수
# insert(문자열, 시작위치, 길이, 새로운문자열 )
select insert('goodbye world', 9, 0, 'cruel') as string;

select insert('goodbye world', 1, 7, 'hello')
as string;

# replace() 함수
# replace(문자열, 기존문자열, 새로운문자열)
select replace ('goodbye world', 'goodbye', 'hello') as replace_str;

# substr() 함수
# substr(문자열, 시작위치, 개수)
select substr('goodbye cruelworld', 9, 5);


# 7.2 숫자 데이터 처리
# ceil, floor, round, truncate
#  truncate(숫자, 버리는자리수)


# 7.3 시간 데이터 처리
# 자료형: date, datetime, timestamp, time

# cast() 함수 : 지정한 값을 다른 데이터 타입으로 변환
select cast('2019-09-12 15:30:00' as datetime); 

select cast('2019-09-12 15:30:00' as date), cast('2019-09-12 15:30:00' as time); 

# MySQL은 날짜 구분 기호에 관대
# '2019-09-17 15:30:00'
# '2019/09/17 15:30:00'
# '2019,09,17,15,30,00'
# '20190917153000'  -> 4가지 모두 허용

select cast('190912' as date); 
# 190912도 허용

# str_to_date() 사용
# cast() 함수를 사용하기에 적절한 형식이 아닌경우 사용
select str_to_date('Sep 17, 2019', '%M %d, %Y') as return_date;

# 날짜 형식의 구성 요소
# %M %m %d %j %W %Y %y %H %h %i %s %f %p


# 현재 날짜/시간 생성
select current_date(), current_time(), current_timestamp();

# 날짜 반환 시간 함수 
# date_add 함수
select date_add(current_date(), interval 5 day);
# 기간자료형 단어
# second, minute, hour, day, month, year, minute_second, hour_second, year_month
# 해당 월의 마지막 날짜 반환
select last_day('2022-08-01');

# 해당 날짜의 영어요일 이름 반환
select dayname('2022-08-01');

# 문자열 반환하는 시간 함수
select extract(year from '2019-09-18 22:19:05');

# 숫자 반환하는 시간 함수
select datediff('2019-09-03', '2019-06-21');



# 7.4 변환 함수
# cast() 함수
# 데이터를 한 유형에서 다른 유형으로 변환할 때 사용
 select cast('143424' as signed integer);

select cast('20120202' as date);

select cast(20220101 as char);

select cast(now() as signed);
