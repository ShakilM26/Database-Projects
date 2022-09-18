-- Transaction 

BEGIN;
ALTER TABLE market_price RENAME COLUMN item to items;
COMMIT;
ALTER TABLE market_price RENAME COLUMN price to current_price;
commit;
END;
