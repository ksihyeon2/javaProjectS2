show tables;

create table visit(
	today datetime default now(),
	visit int default 0
);


select *, timestampdiff(hour,today,now()) as hour_diff from visit;
select *, datediff(today,now()) as date_diff from visit;

update visit set visit = visit+1 where today = today;

select * from visit;

update visit set visit = visit+1 where today = today and member='비회원';
select *, datediff(modifyDate,now()) as date_diff, timestampdiff(hour,modifyDate,now()) as hour_diff from modify order by idx desc limit 0,10;
select count(*) from complaint where complaintState = '대기중';

select count(*) from modify where modifyState = '미완료';