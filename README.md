# TDT4145 Databse Project part II

The database file attached is already created with the necessary tabels and constraints, but we recommend everyone runs the attached setup to make sure the tabels match our current mapping of the database. The script also includes needed values that will be used later in queries.

    To run an sql script, simply open it in DB Browser's exectute SQL tab. ![Guiding image](/DBProsject/Resources/image.png)

## User stories

1. We wish to insert the two halls mentioned above, together with chairs, plays, performances,
   acts, roles, actors and other actors, as described in the text above. This can be implemented
   in SQL.

2. With the assignment, some files have been posted that describe which chairs have already been sold for some performances. Here, a Python program will be created that reads the files and inserts which chairs have been sold. It is OK if you insert the chairs as well based on these text files. It is also OK for the buyer of the already sold chairs to be a standard user. i.e. the same preset user.

3. Here you will buy 9 adult tickets for the performance of Størst av alt er kjærligheten on 3 February, where there are 9 tickets available and where the seats are in the same row. The chairs do not have to be next to each other. We want to get a total of what it costs to buy these tickets, but you don't need to take the payment itself into account, we assume it happens on another system that you don't need to create. This function will be implemented in Python and SQL.

4. Here you will implement a Python program (using SQL) that takes in a date and prints out which performances are on this date and lists how many tickets (i.e. seats) have been sold. Also include performances where no tickets have been sold.

5. We want to create a query in SQL that finds which (names of) actors are performing in the various plays. Print the name of the play, the name of the actor and role.

6. We want to create a query in SQL that finds which performances have sold the best. Print the name of the performance and the date and the number of seats sold sorted by the number of seats in descending order.

7. You should create a Python program (and SQL) that takes an actor's name and finds which actors they have played with in the same act. Write the names of both and which play it happened on

## Comments

## Tips

Noen tips til prosjektet

Det er enklest å lage hele prosjektet for bruk av terminalen til å lage input
til programmet ditt.

Her er et eksempel kjørt på ubuntu. Vi leser inn og kjører skjemaet og
innsetting av initielle data ved hjelp av .read-kommandoen i sqlite3.

sveinbra@mersey:~/fag/tdt4145/2024/prosjekt$ sqlite3 teater.db
SQLite version 3.37.2 2022-01-06 13:25:41
Enter ".help" for usage hints.
sqlite> .read schema.sql
sqlite> .read insert-db.sql
sqlite> .q

Her er vi sensorer avhengig av å få levert en tom database, evt. en beskrivelse av hva databasefilen heter i dokumentet.

For kjøring av Python for innsetting av allerede solgte seter:
sveinbra@mersey:~/fag/tdt4145/2024/prosjekt$ python3 scan-seats-hovedscenen.py hovedscenen.txt
sveinbra@mersey:~/fag/tdt4145/2024/prosjekt$ python3 scan-seats-gamle-scene.py gamle-scene.txt

osv.

Noen Python-tips:

Når du pakker ut en linje fra tekstinput, kan du fjerne newline-merket, ved å gjøre følgende:

    stringlength=len(myline)
        slicedline=myline[stringlength::-1]
        for c in slicedline:

For å lese Dato fra input:

    if "Dato" in myline:
        words = myline.split()
        for word in words:
            if len(word) == 10 and word[4] == "-" and word[7] == "-":
                dato =  word
