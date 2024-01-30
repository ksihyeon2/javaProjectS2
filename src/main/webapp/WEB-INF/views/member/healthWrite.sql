show tables;

create table healthWrite(
	idx int not null auto_increment primary key,
	mid varchar(30) not null,
	part varchar(10) not null,
	healthDate datetime not null,
	healthTime int not null,
	weight int,
	healthDetailText text,
	today datetime default now()
);

select datediff(today,now()) as date_diff from healthWrite;

