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
	good		 int default 0 																 /* '좋아요' 클릭 횟수 누적 */
);