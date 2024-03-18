SELECT Count(Billett.Billett_ID) AS AntallSolgteBilleter
FROM Teaterstykke
INNER JOIN Forestilling on Teaterstykke.Teaterstykke_ID = Forestilling.Teataterstykke_ID 
INNER JOIN Bestilling on Bestilling.Teaterstykke_ID = Teaterstykke.Teaterstykke_ID
INNER JOIN Billett on Billett.Bestilling_ID = Bestilling.Bestilling_ID
GROUP By Teaterstykke.Teaterstykke_ID
Order by AntallSolgteBilleter ASC