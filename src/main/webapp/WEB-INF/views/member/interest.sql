show tables;

create table interest(
	idx int not null auto_increment primary key,    /* 고유 ID */
	mid varchar(10) not null,												/* 관심 설정 아이디 */
	part varchar(10) not null,										  /* 관심 파트 (운동, 헬스장 등..) */
	partIdx int not null														/* 관심 파트의 고유 ID */
);


select * from interest where mid = 'admin' and part = 'health';
select * from interest where mid = 'admin' and part = 'health' and partIdx = 6;