create table modify(
	idx int not null auto_increment primary key,
	hName varchar(20) not null,
	requestMid varchar(10) not null,
	modifyPart varchar(10) not null,
	modifyText text not null,
	modifyState char(3) default '미완료',
	modifyDate datetime default now()
);

select * from modify where hName = '바벨 로우' and requestMid = 'ccc1234';

select * from healthWrite where mid = 'bbb1234' order by idx limit 5;

