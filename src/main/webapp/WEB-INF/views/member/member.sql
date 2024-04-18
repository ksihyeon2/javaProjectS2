show tables;

create table member(
	idx 				int not null auto_increment primary key,
	name 				varchar(20) not null,												 /* 성명 : 한글과 영문 대/소문자만 사용 가능 */
	mid					varchar(30) not null,                        /* 아이디 : 영문 대/소문자 및 숫자로만 5~30자리 가능 */
	pwd 				varchar(100) not null,											 /* 비밀번호 : 특수문자 포함 4~15자리 가능 */
	nickName		varchar(20) not null,												 /* 닉네임 : 한글만 사용 가능 */
	gender			varchar(2),																	 /* 성별 : 여성, 남성 */
	tel					varchar(15),																 /* 전화번호 */
	address			varchar(100),																 /* 주소 */
	email				varchar(60) not null,												 /* 이메일 */
	userDel  		char(2)  default 'NO',            					 /* 탈퇴여부 : NO, OK */
	point		 	 	int default 5000,														 /* 포인트 : 가입 시 최초 5000point 지급 */
	level    	 	int default 3,															 /* 등급 : 0 관리자, 1 우수회원, 2 정회원, 3 준회원 99 비회원 */
	visitcnt		int default 0,															 /* 총 방문 횟수 */
	totalCnt		int default 0,															 /* 일자별 방문 횟수 : 하루에 한 번씩만 증가 가능 */
	todayCnt 	 	int default 0,															 /* 오늘 방문 횟수 */
	startDate 	datetime default now(),											 /* 가입 날짜 */
	lastDate  	datetime default now(),											 /* 마지막 접속일 */
	modifyDate 	datetime default now()											 /* 회원 정보 수정 날짜 */
);
drop table member;
select * from member;
delete from member;

insert into member values(default,'관리자','admin','1234','관리맨','여성','010-1234-5678','청주','tlugs1426@naver.com','NO',default,0,default,default,default,default);

select * from member where nickName='관리맨';

desc member;

select * from member where name = '관리자' and email = 'tlugs1426@naver.com';

select * from member order by idx limit 0,3;

select datediff(modifyDate,now()) as date_diff, timestampdiff(hour,modifyDate,now()) as hour_diff from member;

select * from member where userDel = 'OK' order by idx desc;

select count(*) from member where mid like '%ad%' or nickName like '%ad%' or name like '%홍%';

select * from healthWrite order by healthDate desc;