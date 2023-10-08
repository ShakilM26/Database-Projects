-- 1. Based on rating, I give my one word review 
SELECT *, CASE 
     WHEN rating >= 8 THEN 'Fantastic' 
     WHEN rating BETWEEN 7.5 AND 8 THEN 'Very Good'
     WHEN rating BETWEEN 7 AND 7.5  THEN 'Good'
     WHEN rating BETWEEN 6.5 AND 7 THEN 'Average' 
     ELSE 'Bad'  
     END AS one_word_review FROM movies;

-- 2. Find Profit and Loss from every movie
SELECT *, (earn-budget) AS "Profit/Loss" FROM movies;
-- But I want to make this column as permanent.

ALTER TABLE movies ADD COLUMN profit_loss INT AS (earn-budget);

-- 3. Find only those movies which profit is greater than 0 
SELECT * FROM movies WHERE profit_loss > 0 ORDER BY Profit_or_Loss DESC;

-- 4. Now make a new column 'verdict' based on profit_loss
ALTER TABLE movies ADD COLUMN verdict VARCHAR(255);

-- 5. Divide the dataset based on profit_loss
UPDATE movies SET verdict = CASE 
      WHEN profit_loss >= 300 THEN 'Blockbuster' 
	  WHEN profit_loss BETWEEN 200 AND 300 THEN 'Superhit' 
      WHEN profit_loss BETWEEN 100 AND 200 THEN 'Hit' 
      WHEN profit_loss BETWEEN 0 AND 100 THEN 'Average' 
      ELSE 'Flop' 
      END;

-- 6. COUNT movie verdicts
SELECT SUM(CASE WHEN verdict = 'Blockbuster' THEN 1 ELSE 0 END) 
AS Blockbuster, 
SUM(CASE WHEN verdict = 'Superhit' THEN 1 ELSE 0 END) AS Superhit,
SUM(CASE WHEN verdict = 'Hit' THEN 1 ELSE 0 END) AS Hit,
SUM(CASE WHEN verdict = 'Average' THEN 1 ELSE 0 END) AS Average, 
SUM(CASE WHEN verdict = 'Flop' THEN 1 ELSE 0 END) AS Flop, 
COUNT(*) AS Total_Count FROM movies;