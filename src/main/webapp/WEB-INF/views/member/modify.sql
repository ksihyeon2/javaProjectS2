create table modify(
	idx int not null auto_increment primary key,     /* 고유 ID */
	hName varchar(20) not null,											 /* 운동 명 */
	requestMid varchar(10) not null,								 /* 수정 요청 아이디 */
	modifyPart varchar(10) not null,								 /* 수정 요청 파트 */
	modifyText text not null,											   /* 수정 요청 내용 */
	modifyState char(3) default '미완료',							 /* 수정 요청 상태 */
	modifyDate datetime default now()								 /* 수정 요청 날짜 */
);

select * from modify where hName = '바벨 로우' and requestMid = 'ccc1234';

select * from healthWrite where mid = 'bbb1234' order by idx limit 5;

select count(*) from modify where modifyState = '미완료';

select * from inquiry where inquirystate = '미완료' order by asktime desc;

select * from modify where modifyState = '미완료' and (select * from inquiry where inquirystate = '미완료');

select sum(count(*) as modifySize from modify where modifyState = '미완료') from modify;

select * from modify as m left join inquiry as i on m.modifyState = i.inquirystate;