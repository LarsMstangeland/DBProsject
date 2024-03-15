import sqlite3
con = sqlite3.connect("TeaterStykke(4).db")


def sales():
    cursor = con.cursor()

    print("Choose a date to look at")
    DateInput ="'"+input()+"'"
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

    cursor.execute(sporring, (DateInput,))

    rows = cursor.fetchall()
    print(rows)

    con.close()


sales()