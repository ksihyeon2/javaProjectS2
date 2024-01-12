show tables;

create table reply (
	idx     		int not null auto_increment,				/* 댓글의 고유 번호 */
	boardIdx	 	int not null,                       /* 원본글(부모글)의 고유번호(외래키로 설정) */
	re_step			int not null,												/* 레벨(re_step값)에 따른 들여쓰기(계층 번호) : 부모 댓글의 re_step은 0이다. 대댓글의 경우는 부모 re_step+1로 처리 */
	re_order 		int not null,												/* 댓글의 순서를 결정, 최신 부모 댓글은 1번, 대댓글의 경우는 re_order+1 시킨 후 나머지 댓글들은 re_order 보다 1개 증가*/
	nickName 		varchar(30) not null,								/* 댓글 작성자의 닉네임 */
	wDate 			datetime default now(),							/* 댓글 작성 날짜 */
	content 		text not null,											/* 댓글 내용*/
	primary key(idx),
	foreign key(boardIdx) references board(idx)
	on update cascade    /* 부모 필드를 수정하면 함께 영향을 받는다 */
	on delete restrict   /* 부모 필드를 함부로 삭제할 수 없다.*/
);

select count(*) as replyCnt from reply where boardIdx = 4 order by 1;

select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, (select count(*) from reply where boardIdx = 4) as replyCnt from reply where boardIdx = 4 order by re_order;
select count(*) from reply where boardIdx=4;

update reply set re_order = re_order + 1 where boardIdx = #{boardIdx} and re_order > #{re_order};
