show tables;

create table gym(
	idx int not null auto_increment primary key,
	gymName varchar(30) not null,
	area varchar(10) not null,
	address varchar(100) not null,
	photo varchar(100) default '준비중.jpg',
	tel varchar(20)
);