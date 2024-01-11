show tables;

create table goodcheck(
	idx      		int not null auto_increment primary key,      /* 고유 번호 */ 
	contentidx	int not null,																	/* 해당 게시물 고유 번호 */
	nickName		varchar(30) not null,													/* 공감한 닉네임 */
	goodDate		datetime default now()												/* 공감한 날짜 */
);
