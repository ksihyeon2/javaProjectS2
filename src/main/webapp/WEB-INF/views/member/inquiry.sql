show tables;

create table inquiry(
	idx       	 int not null auto_increment primary key,
	askMid 			 varchar(10) not null,                      /* 질문자 */
	answerMid		 varchar(10) default '',										/* 답변자 */
	ask		 			 text not null,														  /* 질문 */
	answer			 text,														  				/* 답변 */	
	asktime			 datetime default now(),										/* 질문 시간 */
	answertime	 datetime,										              /* 답변 시간 */
	inquirystate char(3) default '미완료',										/* 문의 상태(답변완료,미완료) */
	part				 varchar(10) not null													  /* 문의 타입(상품,배송,교환,반품) */
); 

insert into inquiry (idx,askMid,ask) values(default,'길동이','zz');
update inquiry set answertime = now() where askMid = '길동이';
select count(*) from inquiry;
select *, datediff(asktime,now()) as date_diff, timestampdiff(hour,asktime,now()) as hour_diff from inquiry where askMid = 'admin2' order by idx desc limit 0, 10;
select count(*) from inquiry;