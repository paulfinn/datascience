select * from account_transaction;


select count(*), t.title_id, p.platform_id from 
title t 
left outer join platform_title pt on t.title_id = pt.title_id
left outer join platform p on pt.platform_id = p.platform_id
-- where t.Game_Name like 'Call%'
group by t.title_id, p.platform_id
having count(*) > 1;



select count(*), title_id, platform_id from 
platform_title pt 

-- where t.Game_Name like 'Call%'
group by title_id, platform_id
having count(*) > 1;

select count(*), title_id, genre_id from 
genre_title pt 

-- where t.Game_Name like 'Call%'
group by title_id, genre_id
having count(*) > 1;



select * from rental;
update rental
set Expected_Return_Date = date_add(Expected_Return_Date, interval -5 day)
where rental_id = 4;


SELECT rental_id, member_id, datediff( now(), expected_return_Date), Daily_Late_Return_Charge  FROM rental r
where stock_item_id = 533 and Actual_Return_Date is null;

    
    
    
    select * from 
    stock_item si left outer join title t on si.title_id = t.title_id;
    
 
    
    
 
  
  insert into stock_item (
   Item_stock_no,
   In_Stock,
   Item_reserved_YN,
   Shelf_Location,
   Platform_Title_Id,
   Rental_Fee, 
   Late_Fee)
  
   select
   Item_stock_no,
   In_Stock,
   Item_reserved_YN,
   Shelf_Location,
   pt.Platform_Title_Id as Platform_Title_Id,
   Rental_Fee, 
   Late_Fee
   
   from stock_item_backup sib
   inner join title t on sib.Title_Id = t.Title_Id
   inner join platform_title pt on pt.Title_Id = t.Title_Id
   
   