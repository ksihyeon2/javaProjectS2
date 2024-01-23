show tables;

create table board(
	idx      int not null auto_increment primary key,      /* 게시글의 고유 번호 */
	mid      varchar(30) not null,                         /* 게시글 작성이 아이디 */
	nickName varchar(30) not null,												 /* 게시글 작성이 닉네임 */
	title    varchar(100) not null,												 /* 게시글 제목 */
	content  text not null,																 /* 게시글 내용 */
	openSw 	 char(2) default 'OK',												 /* 게시글 공개 여부 (OK:공개, NO:비공개) */
	readNum  int not null default 0,										   /* 게시글 조회수 */
	wDate    datetime default now(),											 /* 게시글 작성 날짜 */
	good		 int default 0, 															 /* '좋아요' 클릭 횟수 누적 */
	delCheck char(2) default 'NO',												 /* 게시글 삭제 여부 (OK:삭제, NO:미삭제) */
	delDate	 datetime default now(),											 /* 게시글 삭제 날짜 */
);

select *, datediff(wDate,now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff from board  where delCheck = 'NO' order by idx desc limit 0, 6;
select * from board where nickName = '관리맨' and delCheck = 'OK' order by idx;
select count(*) from board where nickName = '관리걸' and delCheck = 'NO';

select * from board order by idx desc limit 1, 3;

select * from board where content like '%연습%' or title like '%연습%' or mid like '%연습%';

select * from board where nickName like '%관리맨%' order by idx desc limit 1,3;