-- Q1. How many properties are there for rent
select count(*) from property_for_rent;
-- Answer: 6

-- Q2. How Manay Branches are there?
select count(*) from branch;
-- Answer: 4


-- Q3. How Many staff are there?
select count(*) from staff;
-- Answer: 6

-- Q4: List the Staff in B5? 
 select * from staff where Bno = 'B5';
-- SL21	John	White	19 Taylor St,London	0171-8445112	Manager	M	1945-10-01	30000.00	WK442011B	B5
-- SL41	Julie	Lee	28 Malvern St, Kilburn	0181-5543541	Assistant	F	1965-06-13	9000.00	WA290573K	B5
 
 
-- Q5: List the number of staff per branch? 
select BNO,count(*) from staff group by BNO;
-- Answer:
-- B3	3
-- B5	2
-- B7	1
 
 
 
-- Q6: How many Viewings were there for property number PA14? 
 select * from viewing where pno = 'PA14';
 -- CR56	PA14	1995-05-24	Too Small
-- CR62	PA14	1995-05-14	No Dining Room
 
 
-- Q7:  What is the total Salary bill in the company? 
select sum(salary) from staff;
-- ANswer 102000.00

 
 
-- Q8: Who is the highest paid? 
select Fname, Lname, Salary
from staff
where salary = (select max(salary) from staff);
-- ANswer: 
-- John	White	30000.00
 
-- Q9: Find the owners do not live in Glasgow? 
 select * from owner where address not like '%Glasgow%';
 -- Answer: 
 -- CO46	Joe	Keogh	2 Fergus Dr, Banchory, Aberdeen AB2 7SZ	01224-861212
 
-- Q10: Find Owners whose last names end in ‘Y’ 
select * from owner where lname like '%Y';
-- Answer:
-- CO40	Tina	Murphy	63 Well St, Shawlands, Glasgow G42	0141-934-1728 
 
 
 
-- Q11: Show the following for all properties: 
 
-- Pno,  
-- Street,  
-- Rooms,  
-- Rent, 
-- Owner No 
-- Staff No 

select 
PNO,
Street,
Rooms,
Rent,
ONO as 'Owner No',
SNO as 'Staff No'
from property_for_rent;
 
 
-- Q12: Then for property PG4 
select 
PNO,
Street,
Rooms,
Rent,
ONO as 'Owner No',
SNO as 'Staff No'
from property_for_rent
where pno = 'PG4';
 
 
-- Q13: Or for owner CO46 
select 
PNO,
Street,
Rooms,
Rent,
ONO as 'Owner No',
SNO as 'Staff No'
from property_for_rent
where pno = 'PG4' or ONO = 'CO46';
  
 
-- Q14: For properties that the rent is greater than 400 
 select 
PNO,
Street,
Rooms,
Rent,
ONO as 'Owner No',
SNO as 'Staff No'
from property_for_rentproperty_for_rent
where rent > 500;
 
-- Q15: For properties that the rent is between 355 and 470 
 select 
PNO,
Street,
Rooms,
Rent,
ONO as 'Owner No',
SNO as 'Staff No'
from property_for_rent
where rent between 355 and 470;