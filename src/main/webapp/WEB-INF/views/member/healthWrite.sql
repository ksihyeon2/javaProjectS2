show tables;

create table healthWrite(
	idx int not null auto_increment primary key,  /* 고유 ID */
	mid varchar(30) not null,											/* 아이디 */
	part varchar(10) not null,                    /* 운동 파트 (근력,유산소 등..) */
	healthDate datetime not null,									/* 운동 날짜 */
	healthTime int not null,											/* 운동 시간 */
	weight int,																		/* 몸무게 */
	healthDetailText text,												/* 운동 상세 내용 */
);

select datediff(today,now()) as date_diff from healthWrite;

