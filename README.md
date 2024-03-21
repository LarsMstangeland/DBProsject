# TDT4145 Database Project part II

The database file attached is already created with the necessary tabels and constraints, but we recommend everyone runs the attached setup .sql file (SetupFile.sql) to make sure the tabels match our current mapping of the database. The script also includes needed values that will be used later in queries, as described in user story 1.

### How to setup database in sqlite

    1. Open the teaterstykke.db file in DB browser.

    2. Open the SetupFile.sql file in the tab named "Exectute SQL" within DB browser. Run this to insert the first needed values. Remember to save the database file after running the script.

    3. Run the SetupScript.py file to insert remaining values, such as seats, orders and tickets.

    4. It is now possible to run the QueryScript.py file

When this is done we can run the application from the QueryScript file, here we have implemented the described queries in user story 3,4,7. The interactions are done in the Visual studio code terminal. The user stories mentioned as number 5 and 6 are only represented as .sql scripts, these can also be tested by opening the attached scripts from DB browser. To test userstory number 5 run ActorQuery.sql script, and to run userstory number 6 run the BestSellingTicketsQuery.sql.

### How interact with QueryScript

    1. After setting up the database, open the QueryScript.py file in visual studio code.

## User stories

1. We wish to insert the two halls mentioned above, together with chairs, plays, performances, acts, roles, actors and other actors, as described in the text above. This can be implemented in SQL.

2. With the assignment, some files have been posted that describe which chairs have already been sold for some performances. Here, a Python program will be created that reads the files and inserts which chairs have been sold. It is OK if you insert the chairs as well based on these text files. It is also OK for the buyer of the already sold chairs to be a standard user. i.e. the same preset user.

3. Here you will buy 9 adult tickets for the performance of Størst av alt er kjærligheten on 3 February, where there are 9 tickets available and where the seats are in the same row. The chairs do not have to be next to each other. We want to get a total of what it costs to buy these tickets, but you don't need to take the payment itself into account, we assume it happens on another system that you don't need to create. This function will be implemented in Python and SQL.

4. Here you will implement a Python program (using SQL) that takes in a date and prints out which performances are on this date and lists how many tickets (i.e. seats) have been sold. Also include performances where no tickets have been sold.

5. We want to create a query in SQL that finds which (names of) actors are performing in the various plays. Print the name of the play, the name of the actor and role.

6. We want to create a query in SQL that finds which performances have sold the best. Print the name of the performance and the date and the number of seats sold sorted by the number of seats in descending order.

7. You should create a Python program (and SQL) that takes an actor's name and finds which actors they have played with in the same act. Write the names of both and which play it happened on

## Comments
