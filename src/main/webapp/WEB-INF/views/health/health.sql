show tables;

create table health(
	idx 			 int not null auto_increment primary key,
	hName 	   varchar(20) not null,             /* 운동 이름 */
	part  	   varchar(10) not null,             /* 운동 부위 */	
	detailPart varchar(30) not null,             /* 운동 상세 부위 */
	level 	 	 int,															 /* 운동 난이도 */
	position 	 text not null,										 /* 시작 자세 */
	motion   	 text not null,										 /* 운동 동작 */
	breath   	 text not null,										 /* 호흡법 */
	caution  	 text not null,									   /* 주의 사항 */
  comment  	 varchar(100),                     /* 코멘트 */
  photo 		 varchar(100),                     /* 운동 사진 */
  interest   int not null default 0						 /* 관심 수 */
);

select * from interest;
select * from interest where part = 'health';

select partIdx from interest where part = 'health' order by partIdx;

select hName, interest from health where interest != 0 order by interest desc limit 5;

select * from health where level = 1 and part = '등' order by rand() limit 2;

select count(*) from modify;