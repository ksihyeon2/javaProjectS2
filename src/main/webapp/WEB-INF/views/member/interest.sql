show tables;

create table interest(
	idx int not null auto_increment primary key,
	mid varchar(10) not null,
	part varchar(10) not null,
	partIdx int not null
);