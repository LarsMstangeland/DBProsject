
SELECT Person.Fornavn, Person.Etternavn, Rolle.Fornavn, Rolle.Etternavn, Teaterstykke.Navn
FROM Teaterstykke
INNER JOIN Akt on Akt.Teaterstykke_ID = Teaterstykke.Teaterstykke_ID
INNER JOIN Rolle_i_akt on (Akt.Teaterstykke_ID,Akt.AktNr) = (Rolle_i_akt.Teaterstykke_ID, Rolle_i_akt.AktNr)
INNER JOIN Rolle on Rolle_i_akt.Rolle_ID = Rolle.Rolle_ID
INNER JOIN Skuespiller_i_rolle on Rolle.Rolle_ID = Skuespiller_i_rolle.Rolle_ID
INNER JOIN Skuespiller on Skuespiller.Ansatt_ID = Skuespiller_i_rolle.Ansatt_ID
INNER JOIN Person on Skuespiller.Ansatt_ID = Person.Ansatt_ID
