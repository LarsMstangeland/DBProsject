#Imports
import os
import time
from datetime import date, datetime
import sqlite3

#Intializing SQLite
con = sqlite3.connect("")
cursor = con.cursor()

os.system('clear')

#Function for making a reservation
def make_reservation(user):
    #Variables to select the correct tickets:
    show_id = 2
    show_time = '18:30'
    show_date = '03.02.2024'
    customer_group = 'Ordinær'
    number_of_tickets = 9

    #Selects rows that have more than 9 seats that are empty for the spesific show
    cursor.execute("SELECT s.Omraade_ID, s.rad, GROUP_CONCAT(s.Stolnr) AS Tilgjengelige_seter FROM Sete s WHERE s.Omraade_ID IN (1, 2, 3) AND NOT EXISTS (SELECT 1 FROM Billett b JOIN Bestilling o ON b.Bestilling_ID = o.Bestilling_ID WHERE b.Stolnr = s.Stolnr AND b.Rad = s.Rad AND b.Omraade_ID = s.Omraade_ID AND o.Teaterstykke_ID = " + str(show_id) + " AND o.FTid = '" + show_time + "' AND o.FDato = '" + show_date + "') GROUP BY s.Rad, s.Omraade_ID HAVING COUNT(*) >= " + str(number_of_tickets) + " ORDER BY s.Omraade_ID LIMIT 1;")
    row = cursor.fetchone()

    os.system('clear')
    print(str(user[1]) + "´s booking for Størst av alt er kjærligheten 3. february")

    #Returns the user to the main menu if there´s not enough available seats
    if(row == None):
        print("Unsuccseful booking: 9 seats on the same row are not avalible for this show on this date")
        time.sleep(5)
        main()
    #Else, books the 9 seats
    else:
        #Gets the date of the order
        date_now = date.today()
        order_date = date_now.strftime("%d.%m.%Y")
        order_date = "'" + order_date + "'"

        #Gets the time of the order
        current_time = datetime.now()
        order_time = current_time.strftime("%H:%M")
        order_time = "'" + order_time + "'"

        #Makes an order and returnes order_ID
        cursor.execute('INSERT INTO Bestilling(Dato, Tidspunkt, Kunde_ID, Teaterstykke_ID, FDato, FTid) VALUES (?, ?, ? , ?, ?, ?)', (order_date, order_time, user[0], show_id, show_date, show_time))
        con.commit()
        order_id = cursor.lastrowid

        #Buys 9 seats on the given row
        area_number, row_number, chairs = row
        chairs_list = chairs.split(",")[:number_of_tickets]
        
        for chair in chairs_list:
            cursor.execute('INSERT INTO Billett(Bestilling_ID, Kundegruppenavn, Stolnr, Rad, Omraade_ID) VALUES (?, ?, ?, ?, ?)', (order_id, customer_group, chair, row_number, area_number))
            con.commit()
        chairs_list = ', '.join(chairs_list)

        #Gets info about the area and price, then prints outcome
        cursor.execute("SELECT Omraadenavn FROM Omraade WHERE Omraade_ID = " + str(area_number) + " UNION SELECT Pris FROM Kundegruppe_i_teaterstykke WHERE Kundegruppenavn = '" + customer_group + "' AND Teaterstykke_ID = " + str(show_id))
        area_and_price = cursor.fetchall()
        price = area_and_price[0][0]
        area = area_and_price[1][0]
        
        print("Booked seats " + chairs_list + " on row " + str(row_number) + " in " + area)
        print(str(number_of_tickets) + " " + customer_group + " tickets cost: " + str(number_of_tickets * price))


#Function to handle answear about reservations
def answer_reservation(user):

    os.system('clear')
    
    #Lets the user deciede if they want to make a reservation
    print(str(user[1]) + " - would you like to book 9 seats to Størst av alt er kjærligheten 3. february?")
    choice_reservation = input("Answer (Y/N): ")
    if(choice_reservation.upper() == "Y"):
        make_reservation(user)
    elif(choice_reservation.upper() == "N"):
        os.system('clear')
        print("You will be returned to the main menu again in 3 seconds")
        time.sleep(3)
        main()
    else:
        os.system('clear')
        print("Unvalid input, try again in 3 seconds")
        time.sleep(3)
        os.system('clear')
        answer_reservation(user)


#Function to handle the choice of user for the reservation
def user_for_reservation():
    #Gets info of all users except admin user
    cursor.execute("Select Kunde_ID, Fornavn, Etternavn from Kunde where Kunde_ID != 2")
    customers = cursor.fetchall()

    os.system('clear')
    customer_counter = 0

    #Prints the different users and lets us choose one
    print("Select user:")
    for customer in customers:
        customer_counter += 1
        user_ID, name, surname = customer
        print(str(customer_counter) + " - " + name + " " + surname)
    choice_user = input("Select your user by number: ")
    answer_reservation(customers[int(choice_user) - 1])

#Function to handle sales user story
def sales():
    print("Choose a date to look at")
    DateInput =input()
    print(DateInput)


    sporring = """
    SELECT Teaterstykke.Navn, count(Bestilling.Bestilling_ID) as AntallSolgteBilleter
    From Teaterstykke
    INNER JOIN Forestilling on Forestilling.Teaterstykke_ID = Teaterstykke.Teaterstykke_ID
    INNER JOIN Bestilling on Bestilling.Teaterstykke_ID = Forestilling.Teaterstykke_ID
    INNER JOIN Billett on Billett.Bestilling_ID = Bestilling.Bestilling_ID
    Where Forestilling.ForestillingsDato =?
    GROUP by Teaterstykke.Navn
    """


    cursor.execute(sporring, [DateInput])
    rows = cursor.fetchall()

    for row in rows:
        print(row)


#Function to handle actor user story
def actors():

    print("Choose a name to look at")
    print("Firstname: ")
    FirstNameInput =input()
    print("Lastname: ")
    LastNameInput =input()

    sporring ="""
    SELECT DISTINCT Person.Etternavn, Person.Fornavn, Teaterstykke.Navn 
    FROM Person 
    INNER JOIN Skuespiller on Person.Ansatt_ID = Skuespiller.Ansatt_ID
    INNER JOIN Skuespiller_i_rolle on Skuespiller_i_rolle.Ansatt_ID = Skuespiller.Ansatt_ID
    INNER JOIN Rolle on Skuespiller_i_rolle.Rolle_ID = Rolle.Rolle_ID
    INNER JOIN Rolle_i_akt on Rolle.Rolle_ID = Rolle_i_akt.Rolle_ID
    INNER JOIN Akt on (akt.AktNr, akt.Teaterstykke_ID) = (Rolle_i_akt.AktNr, Rolle_i_akt.Teaterstykke_ID)
    INNER JOIN Teaterstykke on Teaterstykke.Teaterstykke_ID = Akt.Teaterstykke_ID
    WHERE Akt.AktNr IN (SELECT Akt.AktNr From Person as p1 INNER JOIN Skuespiller on Skuespiller.Ansatt_ID = p1.Ansatt_ID INNER JOIN Skuespiller_i_rolle on Skuespiller.Ansatt_ID = Skuespiller_i_rolle.Ansatt_ID INNER JOIN Rolle on Rolle.Rolle_ID = Skuespiller_i_rolle.Rolle_ID INNER JOIN Rolle_i_akt on Rolle_i_akt.Rolle_ID = Rolle.Rolle_ID INNER JOIN Akt on (Rolle_i_akt.AktNr, Rolle_i_akt.Teaterstykke_ID) = (Akt.AktNr, Rolle_i_akt.Teaterstykke_ID) INNER JOIN Teaterstykke on Teaterstykke.Teaterstykke_ID = Akt.Teaterstykke_ID WHERE (p1.Fornavn, p1.Etternavn) = (?,?))"""

    
    cursor.execute(sporring, [FirstNameInput, LastNameInput])
    rows = cursor.fetchall()

    print(FirstNameInput+ " "+LastNameInput+ " har spilt i samme stykke som: ")
    for row in rows:
        print(row)


#Main function
def main():
    os.system('clear')
    #Lets the user choose a user story to complete
    print("Welcome! Select your desired action:")
    print("1 - Make reservation (user story 3)")
    print("2 - Overview sales (user story 4)")
    print("3 - Find actors who have played togheter (user story 7)")
    choice1 = input("Make your choice by number: ")

    os.system('clear')

    #Refrences the chosen function
    if(choice1 == "1"):
        user_for_reservation()
    elif(choice1 == "2"):
        sales()
    elif(choice1 == "3"):
        actors()
    else:
        os.system('clear')
        print("Unvalid input, try again in 3 seconds")
        time.sleep(3)
        os.system('clear')
        main()

main()