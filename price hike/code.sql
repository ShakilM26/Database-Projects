-- Transaction 

BEGIN;
ALTER TABLE market_price RENAME COLUMN item to items;
COMMIT;
ALTER TABLE market_price RENAME COLUMN price to current_price;
commit;
END;



-- Find price of Rice when it's lower than 55
SELECT * FROM market_price where items = 'Rice' and current_price <= 55; 



-- There are some duplicate values. I want to print how many times there are duplicate values
SELECT items, current_price, COUNT(*)
FROM market_price where (items = 'Rice' and current_price <= 55)  
GROUP BY items, current_price;



-- Now I want to print how many times all items have duplicate values.
SELECT items, current_price, COUNT(*)
FROM market_price   
GROUP BY items, current_price having count(*) > 1 order by items desc;



-- Find price of beef when it's lower than 500 taka 

