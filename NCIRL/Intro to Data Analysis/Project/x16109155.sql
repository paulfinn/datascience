Drop database if exists x16109155;
CREATE DATABASE x16109155;
use x16109155;



-- Create Tables --
drop table if exists account_transaction;
CREATE TABLE Account_Transaction
(
  Account_Transaction_Id Int NOT NULL AUTO_INCREMENT,
  Transaction_Type Varchar(20),
  Transaction_Amount Decimal(18,4),
  Transaction_DateTime Datetime,
  Member_Id Int NOT NULL,
  Rental_id int Null,
  PRIMARY KEY (Account_Transaction_Id)
)
;



-- Table Genre
drop table if exists GENRE;
CREATE TABLE Genre
(
  Genre_Id Int NOT NULL,
  Genre Varchar(30) NOT NULL,
   PRIMARY KEY (Genre_Id)
)
;




-- Table Genre_Title
drop table if exists genre_title;
CREATE TABLE Genre_Title
(
  Genre_Id Int NOT NULL,
  Title_Id Int NOT NULL,
  primary key (Genre_Id,title_id)
)
;


-- Table Member
drop table if exists member;
CREATE TABLE Member
(
  Member_Id Int NOT NULL,
  Member_First_Name Varchar(50),
  Member_Address Varchar(100),
  Account_Balance_Limit Decimal(18,4),
  Member_DOB Date,
  Member_Last_Name Varchar(50),
  Member_Account_Status Varchar(10),
  Member_Email_Address Varchar(100)
)
;

ALTER TABLE Member ADD  PRIMARY KEY (Member_Id)
;


-- Table Member_Audit

drop table if exists member_audit;
CREATE TABLE Member_Audit
(
  Member_Audit_Id Int NOT NULL AUTO_INCREMENT,
  Member_Update_Datetime Bigint,
  Member_Id Int,
  Member_First_Name Varchar(50),
  Member_Address Varchar(100),
  Account_Balance_Limit Decimal(18,4),
  Member_DOB Date,
  Member_Last_Name Varchar(50),
  Member_Account_Status Varchar(10),
  Member_Email_Address Varchar(100),
  PRIMARY KEY (Member_Audit_Id)
)
;



-- Table Platform
drop table if exists Platform;
CREATE TABLE Platform
(
  Platform_Id Int NOT NULL,
  Platform_Name Varchar(50),
  Platform_Manufacturer Varchar(50),
  PRIMARY KEY (Platform_Id)
)
;



-- Table Platform_Title
drop table if exists Platform_title;
CREATE TABLE Platform_Title
(
  Platform_title_id int not null AUTO_INCREMENT,
  Platform_Id Int NOT NULL,
  Title_Id Int NOT NULL,
  primary key (Platform_Title_Id)
)
;


-- Table Publisher
drop table if exists Publisher;
CREATE TABLE Publisher
(
  Publisher_Id Int NOT NULL,
  Publisher_Name Varchar(50),
  PRIMARY KEY (Publisher_Id)
)
;



-- Table Rental
drop table if exists Rental;
CREATE TABLE Rental
(
  Rental_id Int NOT NULL AUTO_INCREMENT,
  Rental_Datetime Datetime NOT NULL,
  Expected_Return_Date Date NOT NULL,
  Actual_Return_Date Date,
  Rental_Fee Decimal(18,4) NOT NULL,
  Daily_Late_Return_Charge Decimal(18,4),
  Member_Id Int NOT NULL,
  Stock_Item_id Int NOT NULL,
  PRIMARY KEY (Rental_id)
)
;

CREATE INDEX IX_Member_Rental ON Rental (Member_Id)
;

CREATE INDEX IX_Stock_Item_Rental ON Rental (Stock_Item_id)
;




-- Table Rental_Rules
drop table if exists rental_rules;
CREATE TABLE Rental_Rules
(
  Rental_Rule_Id Int NOT NULL AUTO_INCREMENT,
  Rule_Type Varchar(20) NOT NULL,
  Active_YN Varchar(1) NOT NULL,
  Rental_Rule_Logic Varchar(500) NOT NULL,
  PRIMARY KEY (Rental_Rule_Id)
)
;




-- Table Reservation
drop table if exists reservation;
CREATE TABLE Reservation
(
  Reservation_Id Int NOT NULL,
  Reservation_Datetime Datetime,
  Stock_Item_id Int NOT NULL,
  PRIMARY KEY (Reservation_Id)
)
;

CREATE INDEX IX_Stock_Item_Reservation ON Reservation (Stock_Item_id)
;




-- Table Stock_Item
drop table if exists stock_item;
CREATE TABLE Stock_Item
(
  Stock_Item_id Int NOT NULL auto_increment,
  Item_Stock_No Varchar(10),
  In_Stock Int NOT NULL,
  Item_Reserved_YN Varchar(1) NOT NULL,
  Shelf_Location Varchar(10) NOT NULL,
  Platform_Title_Id Int NOT NULL,
  Rental_Fee decimal(18,4),
  Late_Fee decimal(18,4),
  primary key (stock_item_id)
)
;

CREATE INDEX IX_Title_Stock_Item ON Stock_Item (Platform_Title_Id)
;





-- Table Title
drop table if exists title;
CREATE TABLE Title
(
  Title_Id Int NOT NULL,
  Game_Name Varchar(100) NOT NULL,
  Title_Age_Rating Varchar(30),
  Release_Year Varchar(4),
  Publisher_Id Int NOT NULL
)
;

CREATE INDEX IX_Publisher_Title ON Title (Publisher_Id)
;

ALTER TABLE Title ADD  PRIMARY KEY (Title_Id)
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE Rental ADD CONSTRAINT Member_Rental FOREIGN KEY (Member_Id) REFERENCES Member (Member_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Stock_Item ADD CONSTRAINT Platform_Title_Stock_Item FOREIGN KEY (Platform_Title_Id) REFERENCES platform_title (PLatform_Title_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Rental ADD CONSTRAINT Stock_Item_Rental FOREIGN KEY (Stock_Item_id) REFERENCES Stock_Item (Stock_Item_id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Account_Transaction ADD CONSTRAINT Member_Account_Transaction FOREIGN KEY (Member_Id) REFERENCES Member (Member_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Title ADD CONSTRAINT Publisher_Title FOREIGN KEY (Publisher_Id) REFERENCES Publisher (Publisher_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Platform_Title ADD CONSTRAINT Platform_Title_Platform FOREIGN KEY (Platform_Id) REFERENCES Platform (Platform_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Platform_Title ADD CONSTRAINT Platform_Title_Title FOREIGN KEY (Title_Id) REFERENCES Title (Title_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Reservation ADD CONSTRAINT Stock_Item_Reservation FOREIGN KEY (Stock_Item_id) REFERENCES Stock_Item (Stock_Item_id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Genre_Title ADD CONSTRAINT Relationship9_Genre FOREIGN KEY (Genre_Id) REFERENCES Genre (Genre_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Genre_Title ADD CONSTRAINT Relationship9_Title FOREIGN KEY (Title_Id) REFERENCES Title (Title_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;


ALTER TABLE Rental ADD CONSTRAINT Stock_Item_rental FOREIGN KEY (Stock_item_Id) REFERENCES Stock_Item (Stock_Item_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Account_Transaction ADD CONSTRAINT Account_Member FOREIGN KEY (Member_Id) REFERENCES Member (Member_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Platform_title ADD CONSTRAINT Title_Platform_Title FOREIGN KEY (Title_Id) REFERENCES Title (Title_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE Platform_title ADD CONSTRAINT Platform_Platform_Title FOREIGN KEY (Platform_Id) REFERENCES Platform (Platform_Id) ON DELETE RESTRICT ON UPDATE RESTRICT
;

CREATE INDEX Member_IX  ON Member (Member_First_Name, Member_Last_Name, Member_Address) ;
CREATE INDEX Title_IX  ON Title (Game_Name);
CREATE INDEX Rental_DateTime_ix on Rental (Rental_Datetime);
CREATE INDEX Expected_Return_Date_ix on Rental (Expected_Return_Date);


show tables



drop trigger if exists before_member_update
DELIMITER $$
CREATE TRIGGER before_member_update 
    BEFORE UPDATE ON member
    FOR EACH ROW BEGIN
 
    INSERT INTO member_audit
    SET Member_Id	=	old.Member_Id,
		Member_First_Name	=	old.Member_First_Name,
		Member_Address	=	old.Member_Address,
		Account_Balance_Limit	=	old.Account_Balance_Limit,
		Member_DOB	=	old.Member_DOB,
		Member_Last_Name	=	old.Member_Last_Name,
		Member_Account_Status	=	old.Member_Account_Status,
		Member_Email_Address	=	old.Member_Email_Address,
        Member_Update_Datetime = now();
END$$
DELIMITER ; 

drop trigger if exists after_rental_insert;
DELIMITER $$
CREATE  TRIGGER after_rental_insert
	AFTER INSERT ON rental
    for each row 
    BEGIN
		update stock_item
		set In_Stock = 0
		where stock_item_id = new.Stock_Item_id;
        
        insert into account_transaction (transaction_type, Transaction_Amount, Transaction_Datetime, Member_Id, rental_id)
					values ('Rental Charge', new.Rental_Fee, now(), new.member_id, new.Rental_id);
	END$$
DELIMITER ;


drop procedure if exists search_title;

DELIMITER $$
create procedure search_title (p_Game_Name varchar(100), p_platform varchar(100), p_Genre varchar(100))
BEGIN
	select distinct 
    si.stock_item_id, 
    t.Game_name, 
    t.Title_Age_Rating, 
    t.Release_Year, 
    pub.Publisher_Name, 
    p.Platform_Name, 
    g.Genre, In_Stock
    from 
    title t 
    left outer join platform_title pt on t.title_id = pt.title_id
    left outer join stock_item si on pt.platform_title_id = si.platform_Title_Id
    left outer join genre_title gt on t.title_id = gt.title_id
    left outer join genre g on gt.Genre_Id = g.Genre_Id
    left outer join platform p on pt.Platform_Id = p.platform_id
	left outer join publisher pub on t.publisher_id = pub.publisher_id
    where t.Game_Name like concat('%', p_Game_Name, '%') 
    and p.platform_name like concat('%', p_platform, '%')
    and g.genre like concat('%', p_Genre, '%');
END$$

DELIMITER ;



Drop procedure if exists search_member;
DELIMITER $$
create procedure search_member (p_First_Name varchar(100), p_Last_Name varchar(100), p_Email varchar(100), p_Address varchar(100))
BEGIN
	select distinct 
    m.Member_Id, 
    m.Member_First_Name, 
    m.Member_Last_Name, 
    m.Member_DOB, 
    m.Member_Account_Status, 
    m.member_email_address, 
    m.Account_Balance_Limit,
    get_account_balance(member_id) as Account_Balance
    from 
    member m
    where m.Member_First_Name like concat('%', p_First_Name, '%') 
    and m.Member_Last_Name like concat('%', p_Last_name, '%')
    and m.Member_Email_Address like concat('%', p_Email, '%')
    and m.member_address like concat('%', p_Address, '%');
END$$
DELIMITER ;


drop procedure if exists rent_item;
DELIMITER $$
create procedure rent_item (p_Stock_Item_id int, p_member_id int)
BEGIN
 START TRANSACTION;
 
 -- Get rental fee and late return charge from stock item
 select rental_fee, late_fee into @rental_fee, @late_fee 
 from stock_item where
 stock_item_id = p_stock_item_id;
 
 -- Insert Rental details
 insert into rental
 (rental_datetime, Expected_Return_Date,REntal_Fee, Daily_late_return_Charge, Member_Id, stock_item_id)
 values
 (now(), cast(date_add(now(), INTERVAL 3 day) as date), @rental_fee, @Late_Fee, p_Member_id, p_stock_item_id);
 COMMIT;
 
 call customer_rental_report(p_member_id);
END$$
DELIMITER ;


drop procedure if exists return_item;
DELIMITER $$
create procedure return_item(p_stock_item_id int)
BEGIN

-- Get detail of rental
SELECT rental_id, member_id, datediff( now(), expected_return_Date), Daily_Late_Return_Charge into @rental_id, @member_id, @days_late, @daily_charge   FROM rental r
where stock_item_id = p_stock_item_id and Actual_Return_Date is null;


-- Calculate Late fee, if any & add to account
if (@days_late > 0) then


	set @late_charge = @days_late * @daily_charge;
	insert into account_transaction (transaction_type, Transaction_Amount, Transaction_Datetime, Member_Id, rental_id)
					values ('Late Return Charge', @late_charge , now(), @member_id, @Rental_id);
END if;
-- Update rental to flag as returned
update rental
		set actual_return_Date = now()
        where rental_id = @rental_id;

-- Update Stock_Item to show instock
update stock_item
		set In_Stock = 1
		where stock_item_id = p_stock_item_id;



END$$
DELIMITER ; 

drop view if exists	vw_games_in_stock;
create view vw_games_in_stock
as
select distinct 
    si.stock_item_id, 
    t.Game_name, 
    t.Title_Age_Rating, 
    t.Release_Year, 
    pub.Publisher_Name, 
    p.Platform_Name, 
    g.Genre, In_Stock
    from 
    title t 
    left outer join platform_title pt on t.title_id = pt.title_id
    left outer join stock_item si on pt.Platform_title_id = si.Platform_Title_Id
    left outer join genre_title gt on t.title_id = gt.title_id
    left outer join genre g on gt.Genre_Id = g.Genre_Id
    left outer join platform p on pt.Platform_Id = p.platform_id
	left outer join publisher pub on t.publisher_id = pub.publisher_id
    where in_stock = 1; 
    
drop view if exists	vw_games_on_loan;
create view vw_games_on_loan
as
select distinct 
	r.rental_id,
    r.Rental_DateTime,
    r.Expected_Return_Date,
    case when expected_return_date < Now() then 'Overdue' 
    else 'Rented' end as Rental_Status,
    m.Member_Id,
    m.Member_First_Name,
    m.Member_Last_Name,
    si.stock_item_id, 
    t.Game_name, 
    t.Title_Age_Rating, 
    t.Release_Year, 
    pub.Publisher_Name, 
    p.Platform_Name, 
    g.Genre, In_Stock
    from 
    rental r 
    left outer join stock_item si on r.stock_item_id = si.Stock_Item_id
    left outer join member m on r.member_id = m.member_id
    left outer join platform_title pt on pt.platform_title_id = si.platform_title_id
    left outer join title t on t.title_id = pt.Title_Id
    left outer join genre_title gt on t.title_id = gt.title_id
    left outer join genre g on gt.Genre_Id = g.Genre_Id    
    left outer join platform p on pt.Platform_Id = p.platform_id
	left outer join publisher pub on t.publisher_id = pub.publisher_id
    where r.actual_return_date is null; 



-- Calculate Unbilled Late fees, use p_member_id = 0 for all members
drop function if exists get_unbilled_late_fees;
DELIMITER $$
create function get_unbilled_late_fees(p_member_id int)
returns double
BEGIN 

set @unbilled_late_fees = 0;

if (p_member_id != 0) then
	select coalesce(sum(datediff( now(), expected_return_Date) * daily_late_return_charge),0)  into @unbilled_late_fees 
	from rental
	where member_id = p_member_id
	and actual_return_date is null;
else
	select coalesce(sum(datediff( now(), expected_return_Date) * daily_late_return_charge),0)  into @unbilled_late_fees 
	from rental
	where actual_return_date is null;
end if;



RETURN @unbilled_late_fees;

END $$
DELIMITER ;



-- Calculate Balance on a Members Account, use member_id = 0 for all accounts
drop function if exists get_account_balance;
DELIMITER $$
create function get_account_balance(p_member_id int )
returns double
BEGIN 

set @unbilled_late_fees = get_unbilled_late_fees(p_member_id);
set @account_balance = 0;

if (p_member_id !=0) then	
select sum(transaction_amount) into @account_balance from account_transaction where member_id =  p_member_id;
else
select sum(transaction_amount) into @account_balance from account_transaction;
end if;


RETURN @unbilled_late_fees + @account_balance;

END $$
DELIMITER ;




drop procedure if exists customer_rental_report;
DELIMITER $$
create procedure customer_rental_report (p_member_id int)
BEGIN

select
Rental_id,
case when expected_return_date < Now() then 'Overdue' 
    else 'Rented' end as Rental_Status,
r.Rental_Datetime,
t.Game_Name,
p.Platform_Name,
r.Expected_Return_Date,
r.Rental_Fee,
r.Daily_Late_return_charge,
get_account_balance(p_member_id) as Account_Balance

from rental r
inner join stock_item si on r.stock_item_id = si.stock_item_id
inner join platform_title pt on si.Platform_Title_Id = pt.Platform_Title_id
inner join title t on pt.title_id = t.title_id
inner join platform p on pt.platform_id = p.platform_id 
where r.Member_Id = p_member_id
and r.Actual_Return_Date is null;

END$$
DELIMITER ;



drop procedure if exists apply_payment;
DELIMITER $$
create procedure apply_payment (p_Transaction_Amount decimal(18,4),
								p_Member_id int)

BEGIN
if (p_Transaction_Amount > 0) 
		then 
			set p_Transaction_Amount = -p_Transaction_Amount;
END if;

insert into account_transaction(Transaction_type, Transaction_amount, Transaction_DateTime, member_id)
values ('Payment', p_Transaction_Amount, Now(), p_Member_Id);

END$$
DELIMITER ;


drop procedure if exists revenue_report;
DELIMITER $$
create procedure revenue_report (p_start_Date date, 
								p_end_date date, 
                                p_detail_member varchar(1),
                                p_detail_month varchar(1))
BEGIN                                


Select
case when p_detail_member = 'Y' then Member_id else 'All' end as Member,
case when p_detail_month = 'Y' then concat(monthname(transaction_datetime), ' - ', year(transaction_datetime)) else 'All' end as 'Month',
sum(Payments) as Payments,
Sum(Rental_Charges) as Rental_Charges,
Sum(Late_fees) as Late_Fees,
Sum(Payments - (REntal_Charges+Late_fees)) as Outstanding_Balance

from 
(
	select 
	Member_id,
	Transaction_DateTime,
	round(case when Transaction_Type = 'Payment' then abs(transaction_amount) else 0 end, 2) as Payments,
	round(case when Transaction_type = 'Rental Charge' then transaction_amount else 0 end, 2) as Rental_Charges,
	round(case when Transaction_Type = 'Late Return Charge' then transaction_amount else 0 end ,2) as Late_Fees
	from 
	 account_transaction 
	 where date(transaction_datetime) >= p_start_date and date(transaction_datetime) <= p_end_date) sq
  group by case when p_detail_member = 'Y' then Member_id else 'All' end ,
 case when p_detail_month = 'Y' then concat(monthname(transaction_datetime), ' - ', year(transaction_datetime)) end
 ;
 END $$
 DELIMITER ;
 


call search_title('','', '');

call search_title('Race','Playstation', '');
call search_member('','','','');
call rent_item( 533, 71001);
call rent_item( 1644, 71002);
call rent_item( 2, 71003);
call rent_item( 213, 71004);
call rent_item( 4558, 71005);
call rent_item( 5228, 71006);
call rent_item( 1904, 71007);
call rent_item( 1644, 71008);
call rent_item( 5040, 71009);
call rent_item( 5611, 71010);
call rent_item( 3605, 71011);
call rent_item( 2717, 71012);

select round(get_account_balance(0), 2);




call return_item (533);
select get_account_balance(71001);
call customer_rental_report(71001);
call apply_payment (5.93, 71001);
call apply_payment (-3, 71001);
call apply_payment (-0, 71001);

 call revenue_report ('2016-01-01', Date(Now()) , '' , '' ); 

 call revenue_report ('2016-01-01', '2016-12-31' , 'Y' , 'Y' );
 
 
 select * from rental
 where 
 (actual_return_date > expected_return_Date or (expected_return_date < Now() and actual_return_Date is null))
 and
 
 ;
 






-- Outputs & Reports
-- These section provides the outputs require for Section 3
select * from vw_games_on_Loan;
select * from vw_games_in_stock;

 

-- Games Release in 2014
select
t.Game_Name,
t.Title_age_rating,
t.Release_year,
p.Platform_name,
g.genre,
sum(si.In_stock) as Qty_In_Stock

 from 
 title t 
left outer join platform_title pt on pt.title_id = t.title_id
left outer join genre_title gt on gt.title_id = t.title_id
left outer join platform p on pt.platform_id = p.platform_id
left outer join genre g on gt.genre_id = g.genre_id
left outer join stock_item si on si.platform_title_id = pt.platform_title_Id
where t.release_year = '2014'
group by t.Game_Name,
t.Title_age_rating,
t.Release_year,
p.Platform_name,
g.genre;

-- Games by Publisher and Platform
select
t.Game_Name,
t.Title_age_rating,
t.Release_year,
pu.Publisher_name,
p.Platform_name,
g.genre,
sum(si.In_stock) as Qty_In_Stock
 from 
 title t 
left outer join platform_title pt on pt.title_id = t.title_id
left outer join genre_title gt on gt.title_id = t.title_id
left outer join platform p on pt.platform_id = p.platform_id
left outer join genre g on gt.genre_id = g.genre_id
left outer join stock_item si on si.platform_title_id = pt.platform_title_Id
left outer join publisher pu on pu.publisher_id = t.publisher_id
group by t.Game_Name,
t.Title_age_rating,
t.Release_year,
p.Platform_name,
g.genre
order by p.platform_name desc, pu.Publisher_Name














