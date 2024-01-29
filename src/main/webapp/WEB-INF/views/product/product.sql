show tables;

create table product(
	idx 					int not null auto_increment primary key,		/* 상품 고유 번호 */
	productName 	varchar(20) not null,                       /* 상품명 */
	productDetail varchar(100) not null,											/* 상품 간단 설명 */
	productPrice 	int not null,																/* 상품의 기본 가격 */
	productPhoto 	varchar(200) not null,											/* 상품의 기본 사진 */
	content text 	not null																		/* 상품의 상세 설명 */
);

select * from product order by idx desc limit 0, 10;

select hName from health;