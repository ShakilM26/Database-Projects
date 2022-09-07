## This is not the Real Project. While learning distributed databases, I was practicing every day. 
## After submitting the project I tried to apply all the operations, methods I learned. 



-- How many writers are there and Total Books they wrote
select count(distinct(author)) as total_writer, count(book_name) as total_books from book_store;

-- which writer wrote how many books 
select author,count(book_name) from book_store group by author order by count(book_name) desc;

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


