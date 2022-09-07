import psycopg2
from psycopg2 import Error 
 
try:
    
    conn = psycopg2.connect(dbname='book store project', user='postgres', password='mandalorian')
    cursor = conn.cursor()
    
    # Since we will modify the database with Python, we are dropping the table at the beginning of writing the query to 
    # avoid the trouble of creating a new table and all operations every time.
    
    cursor.execute('DROP TABLE IF EXISTS books')
    
    
    # Now we are creating our desired table using required columns
    
    table = '''create table books (book_name varchar(100), author varchar(100), genre varchar(100), rating float, num_page int, price int, 
    publication_date date, publisher varchar(100))'''
    cursor.execute(table) 
    
    # We are now inserting the required data according to the column.

    insert = '''insert into books (book_name, author,genre, rating, num_page, price,publication_date, publisher) 
    values (%s,%s,%s,%s,%s,%s,%s,%s)'''
    values = [('Harry Potter and the Half-Blood Prince','J.K. Rowling','Fantasy',4.2,251,490,'1991/10/09', 'Bloomsbury Publishing'),
              ('Harry Potter and the Order of the Phoenix','J.K. Rowling','Fantasy',4.1,210,460,'1992/04/07','Bloomsbury Publishing'),
              ('Harry Potter and the Chamber of Secrets','J.K. Rowling','Fantasy',4.3,228,540,'1993/10/07','Bloomsbury Publishing'),
              ('Harry Potter and the Prisoner of Azkaban','J.K. Rowling','Fantasy',4.5,241,510,'1994/10/07','Bloomsbury Publishing'),             
            
              ('The Hobbit','J.R.R. Tolkien','Fantasy adventure',4.4,230,580,'1937/09/21','Allen & Unwin'),
              ('The Fellowship of the Ring','J.R.R. Tolkien','Fantasy adventure',4.5,572,880,'1954/07/29','Allen & Unwin'),
              ('The Two Towers','J.R.R. Tolkien','Fantasy adventure',4.6,350,610,'1954/11/11','Allen & Unwin'),
              ('The Return of the King','J.R.R. Tolkien','Fantasy adventure',4.7,416,700,'1955/10/20','Allen & Unwin'),
                           
              ('Angels & Demons','Dan Brown','Mystery-thriller',3.9,489,350,'2006/10/3','Broadway Books'),
              ('The Da Vinci Code','Dan Brown','Mystery-thriller',4.1,467,410,'2007/7/4','Broadway Books'),
            
              ('Think and Grow Rich','Napoleon Hill','Non fiction',4.5,320,300,'2004/7/10','Penguin Books'),             
              ('The Chomsky-Foucault Debate: On Human Nature','Noam Chomsky','Non fiction',3.9,213,200,'2002/3/9','Vintage Classic'),
 
              
              ('Murder on the Orient Express','Agatha Christie','Detective fiction',4.5,266,500,'1934/1/1','Leventhal Publishers'),
              ('The Body in the Library','Agatha Christie','Detective fiction',3.8,245,440,'1945/1/1','Leventhal Publishers'),
            
                         
              ('Sapiens: A Brief History of Humankind','Yuval Noah Harari','Non fiction',4.6,464,1080,'2011/12/10','Dvir Publishing House'),
              ('Into the wild','Jon Krakauer','Non fiction',3.9,224,450,'1996/1/13','Villard'),
              ('Einstein: His Life and Universe','Walter Isaacson','Biography',4.6,704,940,'2007/11/13','Simon & Schuster'),
              ('Norwegian Wood','Haruki Murakami','Novel',4.0,296,260,'1987/8/4','Vintage Books'),
              ('Kafka on the Shore','Haruki Murakami','Novel',4.1,505,840,'2002/9/12','Vintage Books'),
              ('Sherlock Holmes: A Baker Street Dozen','Arthur Conan Doyle','Detective fiction',4.3,660,940,'1903/11/11','HighBridge Company'),
              ('The Complete Adventures and Memoirs of Sherlock Holmes','Arthur Conan Doyle','Detective fiction',4.5,334,750,'1893/8/9','Gramercy Books'),
               
              ('Ready player one','Ernest Cline','Sci-fi',4.2,384,780,'2011/8/16','Crown Publishing Group'),
              ('Dune','Frank Herbert','Sci-fi',4.2,412,800,'1965/8/10','Chilton Books'),
              ('The Martian','Andy Weir','Sci-fi',4.5,369,660,'2011/11/20','Self Published'),
              ('Foundation','Isaac Asimov','Sci-fi',4.5,255,460,'1951/12/20','Gnome Press'),
              ('The Bastard of Istanbul','Elif Shafak','Novel',3.9,368,600,'2006/10/10','Viking Adult'),
              ('The spy','Paulo Coelho','Novel',3.6,192,330,'2016/8/2','Self Published'),
              ('The Old man an the sea','Ernest Hemingway','Novel',3.8,128,290,'1952/11/14','Simon & Schuster')]
             
    for v in values:
        cursor.execute(insert,v)
        
    
    # Partition Part     
    drop_one='drop table if exists partition_one'
    cursor.execute(drop_one)
    drop_two='drop table if exists partition_two'
    cursor.execute(drop_two)
    drop_three='drop table if exists partition_three'
    cursor.execute(drop_three)
    
    conn.commit()
    
    
    # Now we divided the dataset into 3 partitions based on their rating 
    
    partition_one='''create table partition_one as (select * from books where rating > 3 and rating < 4)'''
    cursor.execute(partition_one)
    
    partition_two='''create table partition_two as (select * from books where rating >=4  and rating < 4.5)'''
    cursor.execute(partition_two)
   
    partition_three='''create table partition_three as (select * from books where rating >=4.5 and rating < 5)'''
    cursor.execute(partition_three)   
    
    conn.commit() 
    
    
    # 1. Insertion Part 
    insert = '''insert into partition_one (book_name, author,genre, rating, num_page, price,publication_date, publisher) 
    values (%s,%s,%s,%s,%s,%s,%s,%s)'''
    data = ('Bullet train','Kōtarō Isaka','Mystery-thriller',3.8,465,780,'2010/9/1','Kadokawa Shoten')
    cursor.execute(insert, data) 
    
    cursor.execute('select * from partition_one')
    print('After Insertion.....', '\n')
    for insertion in cursor.fetchall():
        print(insertion, '\n') 
    
    
    
    # 2. Selection Part 
    cursor.execute('select * from partition_two where price >= 500')
    print('After Selection.....', '\n')  
    for selection in cursor.fetchall():
        print(selection, '\n')  
    
    
    # 3. Projection Part
    cursor.execute('select book_name, author, genre from partition_two') 
    print('After Projection.....', '\n')
    for projection in cursor.fetchall():
        print(projection, '\n') 
    
    # 4. Deletion Part 
    cursor.execute("delete from partition_three where genre = 'Biography' ")
    cursor.execute('select * from partition_three')
    print('After Deletion.....', '\n')
    for deletion in cursor.fetchall():
        print(deletion, '\n') 
    
    # 5. Updating Part
    cursor.execute("update partition_three set price = 360 where author = 'Napoleon Hill'")
    cursor.execute('select * from partition_three')
    print('After Update Partition Three.....', '\n')
    for update in cursor.fetchall():
        print(update, '\n')
    
    
    # 6. Ordering Part
    cursor.execute('select book_name,author,price from partition_three order by price desc')
    print('After Ordering.....', '\n')
    for ordering in cursor.fetchall():
        print(ordering, '\n')
    
    
    # 7. Grouping Part
    cursor.execute('select genre , sum(price) from partition_three group by genre')
    print('After Grouping.....', '\n')
    for grouping in cursor.fetchall():
        print(grouping, '\n')
    
    
     
    
    conn.commit()

except (Exception, Error) as error:
    print('The are some problem. The Problem is ', error)

finally:
    if(conn):
        cursor.close()
        conn.close()
        print('The postgresql connection is closed')