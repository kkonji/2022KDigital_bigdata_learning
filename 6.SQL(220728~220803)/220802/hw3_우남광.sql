create database shoppingmall;

use shoppingmall;

create table user_table (
userID char(8),
userName varchar(10) not null,
birthYear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height smallint,
mDate date
)

alter table user_table add primary key(userID);

insert into user_table ( userID, userName, birthYear, addr, mobile1, mobile2, height, mDate )
values ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
('KJD', '김제동', 1974, '경남', null, null, 173, '2013-03-03'),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
('SDY', '신동엽', 1971, '경기', null, null, 176, '2008-10-10'),
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08');

select * from user_table;

create table buy_table(
num int not null auto_increment,
userID char(8) not null,
prodName char(6) not null,
groupName char(4),
price int not null,
amount smallint not null,
constraint pk_num primary key (num)
);

alter table buy_table add foreign key (userID) references user_table(userID);

select * from buy_table;

insert into buy_table (userID, prodName, groupName, price, amount)
values ('KHD', '운동화', null, 30, 2),
('KHD', '노트북', '전자', 1000, 1),
('KYM', '모니터', '전자', 200, 1),
('PSH', '모니터', '전자', 200, 5),
('KHD', '청바지', '의류', 50, 3),
('PSH', '메모리', '전자', 80, 10),
('KJD', '책', '서적', 15, 5),
('LHJ', '책', '서적', 15, 2),
('LHJ', '청바지', '의류', 50, 1),
('PSH', '운동화', null, 30, 2),
('LHJ', '책', '서적', 15, 1),
('PSH', '운동화', null, 30, 2);


# 쿼리 1 
select u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as 연락처 from user_table u
inner join
buy_table b
on u.userID  = b.userID;


# 쿼리 2
select u.userID , u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as 연락처 from user_table u
inner join
buy_table b
on u.userID  = b.userID
where u.userID = 'KYM';


# 쿼리 3
select u.userID , u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as 연락처 from user_table u
inner join
buy_table b
on u.userID  = b.userID
order by u.userID;

# 쿼리 4
select userID, userName, addr from user_table ut 
where userID in (
select distinct u.userID  from user_table u
inner join
buy_table b
on u.userID  = b.userID ) ;


# 쿼리 5
select userID, userName, addr, concat(ut.mobile1, ut.mobile2) as 연락처 from user_table ut
where ut.addr in ('경북', '경남') order by ut.userID;


insert into user_table ( userID, userName, birthYear, addr, mobile1, mobile2, height, mDate )
values ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07')