## This is not the Real Project. While learning distributed databases, I was practicing every day. 
## After submitting the project I tried to apply all the operations, methods I learned. 



-- How many writers are there and Total Books they wrote
select count(distinct(author)) as total_writer, count(book_name) as total_books from book_store;

-- which writer wrote how many books 
select author,count(book_name) from book_store group by author order by count(book_name) desc;

-- writers and there total book prices
select author,sum(price) from book_store group by author order by sum(price) desc;

-- total book list by every genre
select genre, count(genre) from book_store group by genre order by count(genre) desc;

-- Vertical Fragmentation - insert,grouping,case
create table vertical_part as (select book_name, author, genre, price, year from book_store);

-- insertion
insert into vertical_part values ('A Thousand Splendid Suns','Khaled Hosseini', 'Historical fiction', 450,2007);

-- Grouping 
select genre, sum(price) as prices from vertical_part group by genre order by sum(price) desc limit 6;

-- Fetch the data
select book_name, author from vertical_part offset 5 rows fetch first 5 row only;

-- Having
select author, sum(price) from vertical_part group by author having sum(price) >= 1000 order by sum(price) desc fetch first 5 row only;

*******************************                      **************************************              ***********************************

-- find the lower/min year from database also print the book name and author name
select author, book_name, min(year) from book_store group by year, author,book_name order by year asc;

-- we can get rid of the above query when we using least function
select book_name, least(year) from book_store order by year asc;

-- we can also find the largest year from database
select book_name, greatest(year) from book_store order by year desc;


## we would like to create a new col 
## It will contain the century in which the book was released

-- add col name century
alter table book_store add century varchar;

-- set the value in century col 
update book_store set century = case 
when year = 1200  then '12th century' 
when year >= 1300 and year <= 1400 then '14th century' 
when year >= 1800 and year <=1900 then '19th century' 
when year >= 1900 and year <= 2000 then '20th century' 
else '21st century' end;


## let's find some information from our new col 

-- how many decade's are here 
select count(distinct(century)) as total_century from book_store;

-- decade wise sort the books 
select distinct(century), book_name from book_store group by century, book_name order by century asc;


-- Showing total number of books grouped by century
select distinct(century), count(book_name) from book_store group by century order by century asc;
















