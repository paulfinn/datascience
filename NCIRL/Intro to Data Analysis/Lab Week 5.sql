create database football;
use football;


create table premiership
(
Team varchar(55) not null,
Played int(11) not null,
Points int(11) not null,
primary key (Team)
);



insert into premiership (Team, Played, Points)
Values ('Celtic',12 ,34 );


insert into premiership (Team, Played, Points)
Values ('Man Utd', 11, 29);


insert into premiership (Team, Played, Points)
Values ('Chelsea', 10, 25);


insert into premiership (Team, Played, Points)
Values ('Liverpool', 12, 23 );

insert into premiership (Team, Played, Points)
Values ('Arsenal', 14 , 26 );

select Team, Played, Points from premiership;

update premiership
set points = 34
where Team = 'Celtic';


insert into premiership (Team, Played, Points)
Values ('Man Utd', 11, 29);

-- Error Code: 1062. Duplicate entry 'Man Utd' for key 'PRIMARY'

update premiership
set Team = 'Everton'
where Team ='Celtic';

update premiership
set Played = Played +2;
-- Error: savfe update mode

update premiership set Played = Played +2
where Team <> 'A';


update premiership set Played = Played +1 
where Team ='Everton';

update premiership
set Played = Played +3
, Points = Points +3
where Team <> 'A';

update premiership
set
played = played + 1,
points = points + 1
where TEam = 'Man Utd';


delete from premiership where team = 'Chelsea';


select team, played, points from premiership;

insert into premiership (team, played, points)
values ('Spurs', 5, 12);

insert into premiership (team, played, points)
values ('West Ham', 7, 34);


select team, played, points
from premiership 
order by TEam;

select team, played, points
from premiership 
order by Played;

select team, played, points
from premiership 
order by Points asc;

select team, played, points
from premiership 
order by Points desc;


update premiership
set
Team = concat(Team , ' Utd')
where Team in ('Everton', 'West Ham', 'Liverpool');

update premiership
set
Team = concat(Team,' County')
where Team in ('Arsenal', 'Spurs');


update premiership
set PLayed = played - 4
where team <> 'A';

update premiership
set played = played -9
where team in ('Arsenal County','West Ham Utd','Man Utd');

select * from premiership where team in (
select team
	from premiership 
    where points = ((select min(points) from premiership) x ) 
    );



    
DELETE e.*
FROM premiership e
WHERE team IN (SELECT team
             FROM (SELECT team
                   FROM premiership
                   WHERE points = (select min(points) from premiership)) x);
                   

DELETE 
FROM premiership 
WHERE team IN (SELECT team
             FROM (SELECT team
                   FROM premiership
                   WHERE played = (select max(played) from premiership)) x);



select * from premiership;


delete from premiership
order by points asc
limit 1;





