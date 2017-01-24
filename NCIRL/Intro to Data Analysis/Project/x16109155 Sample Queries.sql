


call search_title('','', '');

call search_title('Race','Playstation', '');
call search_member('','','','');
call rent_item( 533, 71001);
call rent_item( 3, 71001);
call rent_item( 215, 71001);
call rent_item( 4557, 71001);
call rent_item( 1643, 71002);
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
call rent_item( 4651, 71013);

select round(get_account_balance(0), 2);

call return_item (533);
select get_account_balance(71001);
call customer_rental_report(71001);
call apply_payment (5.93, 71001);
call apply_payment (-3, 71001);
call apply_payment (-0, 71001);

use x16109155;


-- Outputs & Reports
-- These section provides the outputs require for Section 3


-- Rental transactions per week
call list_rentals('2016-12-05', '2016-12-11');
call list_rentals('2016-11-21', '2016-11-27');


 
 

 

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
order by p.platform_name desc, pu.Publisher_Name;


-- Customer Rental Report
call customer_rental_report(71001);

-- MOnth to Date Late Payments
call get_late_payment_amount('2016-12-01', now());
call get_late_payment_amount('2016-11-01', now());
call get_late_payment_amount('2016-11-01', '2016-11-30');

select * 
from vw_rental_detail
    Where
    (actual_return_date > expected_return_Date or (expected_return_date < Now() and actual_return_Date is null))
	 and 
	
	 (Expected_Return_Date >='2016-12-01' and  Expected_Return_Date <= now());

-- YTD Sales
 call revenue_report ('2016-01-01', Date(Now()) , '' , '' ); 
 call revenue_report ('2016-01-01', '2016-12-31' , 'Y' , 'Y' );
 
 select * 
from vw_rental_detail;
 
-- Games on Loan 
select * from vw_games_on_Loan;

-- Games in Stock
select * from vw_games_in_stock;
 
 

