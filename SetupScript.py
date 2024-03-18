import sqlite3
from datetime import date, datetime
con = sqlite3.connect("")
cursor = con.cursor()


gamle_scene = open("Resources/gamle-scene.txt")

performance_date = ''

gamle_scene_lines = gamle_scene.read().split('\n')

# retrieves date and rearranges it to norwegian format
for line in gamle_scene_lines:
    if "Dato" in line:
        words = line.split()
        for word in words:
            if len(word) == 10 and word[4] == "-" and word[7] == "-":
                dates = word.split("-")
                performance_date = "'" + dates[2] + '.' + dates[1] + '.' + dates[0] + "'"



# Gets the Teaterstykke_ID for gamle scene
cursor.execute('SELECT Teaterstykke_ID FROM Teaterstykke WHERE Sal_ID = 2')
theatre_show = cursor.fetchone()
show_number = 0
for t in theatre_show:
    show_number = int(t)
    print(show_number)

# get the time of the performance for the related show and date
cursor.execute('SELECT ForestillingsTidspunkt FROM Forestilling WHERE ForestillingsDato={} AND Teaterstykke_ID={}'.format(performance_date, show_number))
performance_time_tuple = cursor.fetchone()
performance_time = performance_time_tuple[0]
performance_time = "'" + performance_time + "'"
print(performance_time)

# This gives the date of the order
date_now = date.today()
order_date = date_now.strftime("%d.%m.%Y")
order_date = "'" + order_date + "'"

# get the time of the order
current_time = datetime.now()
order_time = current_time.strftime("%H:%M")
order_time = "'" + order_time + "'"

# # Insert order for the reserved chairs into the database:
cursor.execute('INSERT INTO Bestilling (Dato, Tidspunkt, Kunde_ID, Teaterstykke_ID, FDato, FTid) VALUES({}, {}, 2, {}, {}, {})'.format(order_date, order_time, show_number, performance_date, performance_time))
con.commit()
bestilling_id = cursor.lastrowid

# Insert all chairs from text- file create ticket for each seat marked with 1 
gamle_scene_row = 1
gamle_scene_chair_nr = 1
gamle_scene_omraade_id = 1

for line in reversed(gamle_scene_lines):
    if line.startswith(('0', '1')):
        for seat in line:
            cursor.execute('INSERT INTO Sete (Rad, Stolnr, Omraade_ID) VALUES ({}, {}, {})'.format(gamle_scene_row, gamle_scene_chair_nr, gamle_scene_omraade_id))
            con.commit()
            if seat == '1':
                cursor.execute('INSERT INTO Billett (Bestilling_ID, Kundegruppenavn, Stolnr, Rad, Omraade_ID) VALUES ({}, "Ordinær", {}, {}, {})'.format(bestilling_id, gamle_scene_chair_nr, gamle_scene_row, gamle_scene_omraade_id))
                con.commit()
            gamle_scene_chair_nr = gamle_scene_chair_nr + 1
        gamle_scene_row = gamle_scene_row + 1
        gamle_scene_chair_nr = 1
    elif line == 'Parkett':
        gamle_scene_omraade_id = 2
        gamle_scene_row = 1
    elif line == 'Balkong':
        gamle_scene_omraade_id = 3
        gamle_scene_row = 1


# Creates order for the seats already bought at hovedscenen

hovedscenen = open("Resources/hovedscenen.txt")
hovedscenen_lines = hovedscenen.read().split('\n')

show_date = ''

for line in hovedscenen_lines:
    if "Dato" in line:
        words = line.split()
        for word in words:
            if len(word) == 10 and word[4] == "-" and word[7] == "-":
                dates = word.split("-")
                show_date = "'" + dates[2] + '.' + dates[1] + '.' + dates[0] + "'"


# Gets the Teaterstykke_ID for hovedscenen
cursor.execute('SELECT Teaterstykke_ID FROM Teaterstykke WHERE Sal_ID = 1')
theatre_show = cursor.fetchone()
show_number = 0
for t in theatre_show:
    show_number = int(t)
    print(show_number)


# get the time of the performance for the related show and date
cursor.execute('SELECT ForestillingsTidspunkt FROM Forestilling WHERE ForestillingsDato={} AND Teaterstykke_ID={}'.format(show_date, show_number))
performance_time_tuple = cursor.fetchone()
performance_time = performance_time_tuple[0]
performance_time = "'" + performance_time + "'"


# This gives the date of the order
date_now = date.today()
order_date = date_now.strftime("%d.%m.%Y")
order_date = "'" + order_date + "'"

# get the time of the order
current_time = datetime.now()
order_time = current_time.strftime("%H:%M")
order_time = "'" + order_time + "'"

# # Insert order for the reserved chairs into the database:
cursor.execute('INSERT INTO Bestilling (Dato, Tidspunkt, Kunde_ID, Teaterstykke_ID, FDato, FTid) VALUES({}, {}, 2, {}, {}, {})'.format(order_date, order_time, show_number, show_date, performance_time))
con.commit()
bestilling_id = cursor.lastrowid


hovedscenen_row = 1
hovedscenen_chair_nr = 1
should_increase_row = False
# The Omraade_ID of 'parkett' in hovedscenen
hovedscenen_omraade_id = 4

# Reads the text-file hovedscenen.txt from the bottom line and inserts each seat into the table 'Sete'.
# Also creates a ticket for all the seats that are represented with a 1
for line in reversed(hovedscenen_lines):
    if(line == 'Parkett'):
        # sets the omraade_id to 5 (galleriet) for the seats above 'parkett' in the text file.
        hovedscenen_omraade_id = 5
    if line.startswith(('0', '1', 'x')):
        for seat in line:
            if seat == '0' or seat == '1':
                print('legg inn', hovedscenen_chair_nr, 'rad', hovedscenen_row, 'omr', hovedscenen_omraade_id)
                cursor.execute('INSERT INTO Sete (Rad, Stolnr, Omraade_ID) VALUES ({}, {}, {})'.format(hovedscenen_row, hovedscenen_chair_nr, hovedscenen_omraade_id))
                con.commit()
                if seat == '1':
                    cursor.execute('INSERT INTO Billett (Bestilling_ID, Kundegruppenavn, Stolnr, Rad, Omraade_ID) VALUES ({}, "Ordinær", {}, {}, {})'.format(bestilling_id, hovedscenen_chair_nr, hovedscenen_row, hovedscenen_omraade_id))
                    con.commit()
            hovedscenen_chair_nr = hovedscenen_chair_nr + 1
            # We decided to give the seats belonging to 'øvre galleriet'(515-524) from the photo of hovedscenen the same row number
            if hovedscenen_chair_nr > 515:
                should_increase_row = False
            elif hovedscenen_chair_nr == 515:
                hovedscenen_row = hovedscenen_row + 1
            # The seats belonging to 'nedre galleriet' (505-514) are given the same row number
            elif hovedscenen_chair_nr == 509:
                should_increase_row = False
            elif hovedscenen_chair_nr < 505:
                should_increase_row = True
        if should_increase_row == True:    
            hovedscenen_row = hovedscenen_row + 1            

