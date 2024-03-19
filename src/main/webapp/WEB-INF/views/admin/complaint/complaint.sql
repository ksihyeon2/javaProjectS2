
show tables;

create table complaint(
	idx 						int not null auto_increment primary key,    	/* 신고 테이블 고유 번호 */
	complaintidx	  int not null,																	/* 해당 항목 게시글의 고유 번호 */
	complaintMid		varchar(100) not null,												/* 신고자 아이디 */
	complaintType  	varchar(100) not null,												/* 신고 사유 타입 */
	complaintText   text not null,																/* 신고 사유 */
	complaintDate		datetime default now()												/* 신고 날짜 */
);

update complaint set complaintNum = complaintNum+1 and complaintMid = complainMid where idx = 1;

select * from complaint order by complaintDate;
