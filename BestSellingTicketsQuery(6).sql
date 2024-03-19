 SELECT Teaterstykke.Navn, Forestilling.ForestillingsDato, count(Billett.Billett_ID) as SolgteBilletter
 FROM Forestilling
 OUTER LEFT JOIN Bestilling on (Forestilling.ForestillingsDato,Forestilling.Teaterstykke_ID) = (Bestilling.FDato, Bestilling.Teaterstykke_ID)
 OUTER LEFT JOIN Teaterstykke on Forestilling.Teaterstykke_ID = Teaterstykke.Teaterstykke_ID
 OUTER LEFT JOIN Billett on Bestilling.Bestilling_ID = Billett.Bestilling_ID
 GROUP BY Teaterstykke.Teaterstykke_ID, Forestilling.ForestillingsDato