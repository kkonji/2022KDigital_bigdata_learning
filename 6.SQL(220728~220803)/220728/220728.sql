create database testdb;

use testdb;

create table person
(person_id smallint unsigned,
fname varchar(20),
lname varchar(20),
eye_color enum('BR', 'BL', 'GR'),
birth_date date,
street varchar(30),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code varchar(20),
constraint pk_person primary key (person_id)
);

desc person;

create table favorite_food
(person_id smallint unsigned,
food	VARCHAR(20),
constraint pk_favorite_food primary key (person_id,	food),
constraint fk_fav_food_person_id foreign key (person_id)
references person(person_id)
);

# person_id 자동증가
# foreign key로 설정된 부분은 다른 테이블에서 변경시 에러 발생
# 제약 조건 비활성화 -> 테이블 수정 -> 제약 조건 활성화

# 테이블 수정
set foreign_key_checks=0; # 제약 조건 비활성화
alter table person modify person_id smallint unsigned auto_increment; # 테이블 수정
set foreign_key_checks=1; # 제약 조건 활성화

desc person;

# 데이터 보기
select * from person;

select * from favorite_food;

# select 열이름1, 열이름2, ... from 테이블이름
select person_id, fname, lname, birth_date from person;

# 조건 where 넣고 select 
select person_id, fname, lname, birth_date
from person where lname = 'Turner';

# 데이터 추가
# insert into 테이블이름 (열이름1, 열이름2, ...) values (값1, 값2, ...)

insert into person (person_id, fname, lname, eye_color, birth_date)
values (null, 'william', 'Turner', 'BR', '1972-05-27');

insert into person (person_id, fname, lname, eye_color, birth_date)
values (null, 'sam', 'lina', 'BR', '1946-12-16'), (null, 'luna', 'rine', 'BR', '1988-03-15'), (null, 'line', 'make', 'BR', '1992-05-05');

insert into favorite_food (person_id, food)
values (1,'pizza');

insert into favorite_food (person_id, food)
values (1,'cookies');

insert into favorite_food (person_id, food)
values (1,'nachos');

# 정렬해서 출력(order by, 오름차순이 디폴트 값)
select food from favorite_food
where person_id = 1 order by food desc;

select food from favorite_food
where person_id = 1 order by food ;

insert into person
(person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
values (null, 'Susan', 'Smith', 'BL', '1975-11-02','23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

select person_id, fname, lname, birth_date from person;

# 데이터 수정 (update)
# update 테이블이름 set 필드이름 = 값1, 필드이름2 = 값2, ... where 필드이름 = 데이터값;
update person
set street = '1225 tremon st.', 
city = 'boston', 
state = 'MA', 
country = 'USA', 
postal_code  = '02138'
where person_id = 1;

select * from person;

update person
set street = 'lemon st.', 
city = 'Los angeles', 
state = 'CA', 
country = 'USA' 
where person_id = 5;

# 데이터 삭제(delete)
# delete from 테이블이름 where 필드이름 = 데이터값
delete from person where person_id = 5;

select * from person;

# 테이블 삭제(delete)
# drop table 테이블이름;

delete table person 

