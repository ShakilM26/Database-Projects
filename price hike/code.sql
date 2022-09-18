-- Transaction 

BEGIN;
ALTER TABLE market_price RENAME COLUMN item to items;
COMMIT;
ALTER TABLE market_price RENAME COLUMN price to current_price;
commit;
END;


-- Find price of beef when it's lower than 500 taka  

SELECT * FROM market_price WHERE current_price in (SELECT DISTINCT(current_price) FROM market_price where 
                                     current_price < 500 and items = 'Beef');
