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