BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Kundegruppe" (
	"Kundegruppenavn"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("Kundegruppenavn")
);
CREATE TABLE IF NOT EXISTS "Sete" (
	"Stolnr"	INTEGER NOT NULL,
	"Rad"	INTEGER NOT NULL,
	"Omraade_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Omraade_ID") REFERENCES "Omraade"("Omraade_ID"),
	PRIMARY KEY("Stolnr","Rad")
);
CREATE TABLE IF NOT EXISTS "Forestilling" (
	"ForestillingsDato"	INTEGER NOT NULL,
	"ForestillingsTidspunkt"	INTEGER NOT NULL,
	"Teataterstykke_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Teataterstykke_ID") REFERENCES "Teaterstykke"("Teaterstykke_ID"),
	PRIMARY KEY("ForestillingsDato","ForestillingsTidspunkt","Teataterstykke_ID")
);
CREATE TABLE IF NOT EXISTS "Bestilling" (
	"Bestilling_ID"	INTEGER NOT NULL,
	"Dato"	INTEGER,
	"Tidspunkt"	INTEGER,
	"Kunde_ID"	INTEGER NOT NULL,
	"Teaterstykke_ID"	INTEGER NOT NULL,
	"FDato"	INTEGER NOT NULL,
	"FTid"	INTEGER NOT NULL,
	FOREIGN KEY("FDato") REFERENCES "Forestilling"("ForestillingsDato"),
	FOREIGN KEY("FTid") REFERENCES "Forestilling"("ForestillingsTidspunkt"),
	PRIMARY KEY("Bestilling_ID")
);
CREATE TABLE IF NOT EXISTS "Stottepersonell" (
	"Ansatt_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Ansatt_ID") REFERENCES "Person"("Ansatt_ID"),
	PRIMARY KEY("Ansatt_ID")
);
CREATE TABLE IF NOT EXISTS "Skuespiller" (
	"Ansatt_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Ansatt_ID") REFERENCES "Skuespiller"("Ansatt_ID"),
	PRIMARY KEY("Ansatt_ID")
);
CREATE TABLE IF NOT EXISTS "Akt" (
	"AktNr"	INTEGER NOT NULL,
	"Aktnavn"	TEXT,
	"Teaterstykke_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Teaterstykke_ID") REFERENCES "Teaterstykke"("Teaterstykke_ID"),
	PRIMARY KEY("AktNr","Teaterstykke_ID")
);
CREATE TABLE IF NOT EXISTS "Oppgave_i_teaterstykke" (
	"Oppgave_ID"	INTEGER NOT NULL,
	"Ansatt_ID"	INTEGER NOT NULL,
	"Teaterstykke_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Oppgave_ID") REFERENCES "Oppgave"("Oppgave_ID"),
	FOREIGN KEY("Teaterstykke_ID") REFERENCES "Teaterstykke"("Teaterstykke_ID"),
	FOREIGN KEY("Ansatt_ID") REFERENCES "Person"("Ansatt_ID"),
	PRIMARY KEY("Oppgave_ID","Ansatt_ID","Teaterstykke_ID")
);
CREATE TABLE IF NOT EXISTS "Skuespiller_i_rolle" (
	"Ansatt_ID"	INTEGER NOT NULL,
	"Rolle_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Rolle_ID") REFERENCES "Rolle"("Rolle_ID"),
	FOREIGN KEY("Ansatt_ID") REFERENCES "Person"("Ansatt_ID"),
	PRIMARY KEY("Ansatt_ID","Rolle_ID")
);
CREATE TABLE IF NOT EXISTS "Rolle_i_akt" (
	"Rolle_ID"	INTEGER NOT NULL,
	"Teaterstykke_ID"	INTEGER NOT NULL,
	"AktNr"	INTEGER NOT NULL,
	FOREIGN KEY("AktNr") REFERENCES "Akt"("AktNr"),
	FOREIGN KEY("Teaterstykke_ID") REFERENCES "Teaterstykke"("Teaterstykke_ID"),
	FOREIGN KEY("Rolle_ID") REFERENCES "Rolle"("Rolle_ID"),
	PRIMARY KEY("Rolle_ID","Teaterstykke_ID","AktNr")
);
CREATE TABLE IF NOT EXISTS "Kunde" (
	"Kunde_ID"	INTEGER NOT NULL,
	"Fornavn"	TEXT,
	"Etternavn"	TEXT,
	"Adresse"	TEXT,
	"Mobilnummer"	INTEGER UNIQUE,
	PRIMARY KEY("Kunde_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Person" (
	"Ansatt_ID"	INTEGER NOT NULL,
	"Fornavn"	TEXT,
	"Etternavn"	TEXT,
	"Ansattstatus"	TEXT,
	"E-post"	TEXT UNIQUE,
	PRIMARY KEY("Ansatt_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Oppgave" (
	"Oppgave_ID"	INTEGER NOT NULL,
	"Oppgavenavn"	TEXT UNIQUE,
	PRIMARY KEY("Oppgave_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Kundegruppe_i_teaterstykke" (
	"Kundegruppenavn"	TEXT NOT NULL,
	"Teaterstykke_ID"	INTEGER NOT NULL,
	"Pris"	INTEGER NOT NULL,
	FOREIGN KEY("Kundegruppenavn") REFERENCES "Kundegruppe"("Kundegruppenavn"),
	FOREIGN KEY("Teaterstykke_ID") REFERENCES "Teaterstykke"("Teaterstykke_ID"),
	PRIMARY KEY("Kundegruppenavn","Teaterstykke_ID")
);
CREATE TABLE IF NOT EXISTS "Omraade" (
	"Omraade_ID"	INTEGER NOT NULL,
	"Omraadenavn"	TEXT NOT NULL,
	"Sal_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Sal_ID") REFERENCES "Sal"("Sal_ID"),
	PRIMARY KEY("Omraade_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Rolle" (
	"Rolle_ID"	INTEGER NOT NULL,
	"Fornavn"	TEXT NOT NULL,
	"Etternavn"	TEXT,
	PRIMARY KEY("Rolle_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Sal" (
	"Sal_ID"	INTEGER NOT NULL,
	"Kapastitet"	INTEGER,
	"Salnavn"	TEXT NOT NULL,
	PRIMARY KEY("Sal_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Teaterstykke" (
	"Teaterstykke_ID"	INTEGER NOT NULL,
	"Navn"	TEXT NOT NULL,
	"Sal_ID"	INTEGER NOT NULL,
	FOREIGN KEY("Sal_ID") REFERENCES "Sal"("Sal_ID"),
	PRIMARY KEY("Teaterstykke_ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Billett" (
	"Billett_ID"	INTEGER NOT NULL,
	"Bestilling_ID"	INTEGER NOT NULL,
	"Kundegruppenavn"	TEXT NOT NULL,
	FOREIGN KEY("Kundegruppenavn") REFERENCES "Kundegruppe"("Kundegruppenavn"),
	FOREIGN KEY("Bestilling_ID") REFERENCES "Bestilling"("Bestilling_ID"),
	PRIMARY KEY("Billett_ID" AUTOINCREMENT)
);
INSERT INTO "Kundegruppe" VALUES ('Ordinær');
INSERT INTO "Kundegruppe" VALUES ('Honnør');
INSERT INTO "Kundegruppe" VALUES ('Student');
INSERT INTO "Kundegruppe" VALUES ('Barn');
INSERT INTO "Stottepersonell" VALUES (13);
INSERT INTO "Stottepersonell" VALUES (14);
INSERT INTO "Stottepersonell" VALUES (15);
INSERT INTO "Stottepersonell" VALUES (16);
INSERT INTO "Stottepersonell" VALUES (24);
INSERT INTO "Stottepersonell" VALUES (25);
INSERT INTO "Stottepersonell" VALUES (26);
INSERT INTO "Stottepersonell" VALUES (27);
INSERT INTO "Stottepersonell" VALUES (28);
INSERT INTO "Skuespiller" VALUES (1);
INSERT INTO "Skuespiller" VALUES (2);
INSERT INTO "Skuespiller" VALUES (3);
INSERT INTO "Skuespiller" VALUES (4);
INSERT INTO "Skuespiller" VALUES (5);
INSERT INTO "Skuespiller" VALUES (6);
INSERT INTO "Skuespiller" VALUES (7);
INSERT INTO "Skuespiller" VALUES (8);
INSERT INTO "Skuespiller" VALUES (9);
INSERT INTO "Skuespiller" VALUES (10);
INSERT INTO "Skuespiller" VALUES (11);
INSERT INTO "Skuespiller" VALUES (12);
INSERT INTO "Skuespiller" VALUES (17);
INSERT INTO "Skuespiller" VALUES (18);
INSERT INTO "Skuespiller" VALUES (19);
INSERT INTO "Skuespiller" VALUES (20);
INSERT INTO "Skuespiller" VALUES (21);
INSERT INTO "Skuespiller" VALUES (22);
INSERT INTO "Skuespiller" VALUES (23);
INSERT INTO "Akt" VALUES (1,NULL,1);
INSERT INTO "Akt" VALUES (2,NULL,1);
INSERT INTO "Akt" VALUES (3,NULL,1);
INSERT INTO "Akt" VALUES (4,NULL,1);
INSERT INTO "Akt" VALUES (5,NULL,1);
INSERT INTO "Akt" VALUES (1,NULL,2);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (1,13,1);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (6,13,1);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (2,14,1);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (3,14,1);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (4,15,1);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (5,16,1);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (1,24,2);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (2,25,2);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (3,25,2);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (6,26,2);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (4,27,2);
INSERT INTO "Oppgave_i_teaterstykke" VALUES (5,28,2);
INSERT INTO "Skuespiller_i_rolle" VALUES (1,1);
INSERT INTO "Skuespiller_i_rolle" VALUES (2,2);
INSERT INTO "Skuespiller_i_rolle" VALUES (8,3);
INSERT INTO "Skuespiller_i_rolle" VALUES (3,7);
INSERT INTO "Skuespiller_i_rolle" VALUES (9,4);
INSERT INTO "Skuespiller_i_rolle" VALUES (10,5);
INSERT INTO "Skuespiller_i_rolle" VALUES (11,6);
INSERT INTO "Skuespiller_i_rolle" VALUES (4,8);
INSERT INTO "Skuespiller_i_rolle" VALUES (5,9);
INSERT INTO "Skuespiller_i_rolle" VALUES (6,10);
INSERT INTO "Skuespiller_i_rolle" VALUES (12,11);
INSERT INTO "Skuespiller_i_rolle" VALUES (6,12);
INSERT INTO "Skuespiller_i_rolle" VALUES (9,13);
INSERT INTO "Skuespiller_i_rolle" VALUES (10,13);
INSERT INTO "Skuespiller_i_rolle" VALUES (11,14);
INSERT INTO "Skuespiller_i_rolle" VALUES (7,15);
INSERT INTO "Skuespiller_i_rolle" VALUES (17,16);
INSERT INTO "Skuespiller_i_rolle" VALUES (18,17);
INSERT INTO "Skuespiller_i_rolle" VALUES (19,18);
INSERT INTO "Skuespiller_i_rolle" VALUES (20,19);
INSERT INTO "Skuespiller_i_rolle" VALUES (21,20);
INSERT INTO "Skuespiller_i_rolle" VALUES (22,21);
INSERT INTO "Skuespiller_i_rolle" VALUES (23,22);
INSERT INTO "Kunde" VALUES (2,'Admin',NULL,NULL,NULL);
INSERT INTO "Kunde" VALUES (3,'Sebastian','Våge','Weidemanns vei 9A',95727440);
INSERT INTO "Kunde" VALUES (4,'Vetle','Ekern','Ragnhildsgate 8',98435120);
INSERT INTO "Kunde" VALUES (5,'Lars Magne','Stangeland','Sandnesveien 420',94121454);
INSERT INTO "Oppgave" VALUES (1,'Regi');
INSERT INTO "Oppgave" VALUES (2,'Scenografi');
INSERT INTO "Oppgave" VALUES (3,'Kostymer');
INSERT INTO "Oppgave" VALUES (4,'Lysdesign');
INSERT INTO "Oppgave" VALUES (5,'Dramaturg');
INSERT INTO "Oppgave" VALUES (6,'Musikalsk ansvarlig');
INSERT INTO "Oppgave" VALUES (7,'Direktør');
INSERT INTO "Kundegruppe_i_teaterstykke" VALUES ('Ordinær',1,450);
INSERT INTO "Kundegruppe_i_teaterstykke" VALUES ('Honnør',1,380);
INSERT INTO "Kundegruppe_i_teaterstykke" VALUES ('Student',1,280);
INSERT INTO "Kundegruppe_i_teaterstykke" VALUES ('Ordinær',2,350);
INSERT INTO "Kundegruppe_i_teaterstykke" VALUES ('Honnør',2,300);
INSERT INTO "Kundegruppe_i_teaterstykke" VALUES ('Student',2,220);
INSERT INTO "Kundegruppe_i_teaterstykke" VALUES ('Barn',2,220);
INSERT INTO "Omraade" VALUES (1,'Parkett',2);
INSERT INTO "Omraade" VALUES (2,'Balkong',2);
INSERT INTO "Omraade" VALUES (3,'Galleri',2);
INSERT INTO "Omraade" VALUES (4,'Parkett',1);
INSERT INTO "Omraade" VALUES (5,'Galleri',1);
INSERT INTO "Rolle" VALUES (1,'Haakon','Haakonssønn');
INSERT INTO "Rolle" VALUES (2,'Inga',NULL);
INSERT INTO "Rolle" VALUES (3,'Gregorius','Jonssønn');
INSERT INTO "Rolle" VALUES (4,'Paal','Flida');
INSERT INTO "Rolle" VALUES (5,'Baard','Bratte');
INSERT INTO "Rolle" VALUES (6,'Jatgeir','Skald');
INSERT INTO "Rolle" VALUES (7,'Skule','Jarl');
INSERT INTO "Rolle" VALUES (8,'Fru Ragnhild',NULL);
INSERT INTO "Rolle" VALUES (9,'Margrete',NULL);
INSERT INTO "Rolle" VALUES (10,'Sigrid',NULL);
INSERT INTO "Rolle" VALUES (11,'Peter',NULL);
INSERT INTO "Rolle" VALUES (12,'Ingebjørg',NULL);
INSERT INTO "Rolle" VALUES (13,'Trønder',NULL);
INSERT INTO "Rolle" VALUES (14,'Dagfinn','Bonde');
INSERT INTO "Rolle" VALUES (15,'Biskop Nikolas',NULL);
INSERT INTO "Rolle" VALUES (16,'Sunniva','Du Mond Nordal');
INSERT INTO "Rolle" VALUES (17,'Jo','Saberniak');
INSERT INTO "Rolle" VALUES (18,'Marte','M. Steinholt');
INSERT INTO "Rolle" VALUES (19,'Tor Ivar','Hagen');
INSERT INTO "Rolle" VALUES (20,'Trond-Ove','Skrødal');
INSERT INTO "Rolle" VALUES (21,'Natalie','Grøndahl Tangen');
INSERT INTO "Rolle" VALUES (22,'Ã…smund','Flaten');
INSERT INTO "Sal" VALUES (1,516,'Hovedscenen');
INSERT INTO "Sal" VALUES (2,332,'Gamle scene');
INSERT INTO "Teaterstykke" VALUES (1,'Kongsemnene',1);
INSERT INTO "Teaterstykke" VALUES (2,'Størst av alt er kjærligheten',2);
INSERT INTO "Person" VALUES (1,'Arturo','Scotti','Fast','arturo.scotti@gmail.com');
INSERT INTO "Person" VALUES (2,'Ingunn Beate','Strige øyen','Fast','ingunn.oyen@gmail.com');
INSERT INTO "Person" VALUES (3,'Hans Petter','Nilsen','Fast','hans.petter.nilsen@gmail.com');
INSERT INTO "Person" VALUES (4,'Madeleine','Bradtzæg Nilsen','Fast','madeleine.nilsen@gmail.com');
INSERT INTO "Person" VALUES (5,'Synnøve','Fossum Eriksen','Fast','synnove.eriksen@gmail.com');
INSERT INTO "Person" VALUES (6,'Emma Caroline','Deichmann','Fast','emma.deichmann@gmail.com');
INSERT INTO "Person" VALUES (7,'Thomas','Jensen Takyi','Fast','thomas.takyi@gmail.com');
INSERT INTO "Person" VALUES (8,'Per','Bogestad Gulliksen','Fast','per.gulliksen@gmail.com');
INSERT INTO "Person" VALUES (9,'Isak','Holmen Sørensen','Fast','isak.sorensen@gmail.com');
INSERT INTO "Person" VALUES (10,'Fabian','Heidelberg Lunde','Fast','fabian.lunde@gmail.com');
INSERT INTO "Person" VALUES (11,'Emil','Olafsson','Fast','emil.olafsson@gmail.com');
INSERT INTO "Person" VALUES (12,'Snorre','Ryen Tøndel','Fast','snorre.tondel@gmail.com');
INSERT INTO "Person" VALUES (13,'Yury','Butusov','Fast','yury.butusov@gmail.com');
INSERT INTO "Person" VALUES (14,'Aleksandr','Shishkin-Hokusai','Fast','aleksandr.shishkin-hokusai@gmail.com');
INSERT INTO "Person" VALUES (15,'Eivind','Myren','Fast','eivind.myren@gmail.com');
INSERT INTO "Person" VALUES (16,'Mina','Rype Stokke','Fast','mina.stokke@gmail.com');
INSERT INTO "Person" VALUES (17,'Sunniva','Du Mond Nordal','Fast','sunniva.nordal@gmail.com');
INSERT INTO "Person" VALUES (18,'Jo','Saberniak','Fast','jo.saberniak@gmail.com');
INSERT INTO "Person" VALUES (19,'Marte','M. Steinholt','Fast','marte.steinholt@gmail.com');
INSERT INTO "Person" VALUES (20,'Tor Ivar','Hagen','Fast','tor.ivar.hagen@gmail.com');
INSERT INTO "Person" VALUES (21,'Trond-Ove','Skrødal','Fast','trond-ove.skroedal@gmail.com');
INSERT INTO "Person" VALUES (22,'Natalie','Grøndahl Tangen','Fast','natalie.tangen@gmail.com');
INSERT INTO "Person" VALUES (23,'Ã…smund','Flaten','Fast','aasmund.flaten@gmail.com');
INSERT INTO "Person" VALUES (24,'Jonas','Corell Petersen','Fast','jonas.petersen@gmail.com');
INSERT INTO "Person" VALUES (25,'David','Gehrt','Fast','david.gehrt@gmail.com');
INSERT INTO "Person" VALUES (26,'Gaute','Tønder','Fast','gaute.toender@gmail.com');
INSERT INTO "Person" VALUES (27,'Magnus','Mikaelsen','Fast','magnus.mikaelsen@gmail.com');
INSERT INTO "Person" VALUES (28,'Kristoffer','Spender','Fast','kristoffer.spender@gmail.com');
INSERT INTO "Person" VALUES (29,'Berit','Tiller','Fast','berit.tiller@gmail.com');
INSERT INTO "Forestilling" VALUES ('01.02.2024','19:00',1);
INSERT INTO "Forestilling" VALUES ('02.02.2024','19:00',1);
INSERT INTO "Forestilling" VALUES ('03.02.2024','19:00',1);
INSERT INTO "Forestilling" VALUES ('04.02.2024','19:00',1);
INSERT INTO "Forestilling" VALUES ('05.02.2024','19:00',1);
INSERT INTO "Forestilling" VALUES ('06.02.2024','19:00',1);
INSERT INTO "Forestilling" VALUES ('03.02.2024','18:30',2);
INSERT INTO "Forestilling" VALUES ('06.02.2024','18:30',2);
INSERT INTO "Forestilling" VALUES ('07.02.2024','18:30',2);
INSERT INTO "Forestilling" VALUES ('12.02.2024','18:30',2);
INSERT INTO "Forestilling" VALUES ('13.02.2024','18:30',2);
INSERT INTO "Forestilling" VALUES ('14.02.2024','18:30',2);
INSERT INTO "Rolle_i_akt" VALUES (1,1,1);
INSERT INTO "Rolle_i_akt" VALUES (1,1,2);
INSERT INTO "Rolle_i_akt" VALUES (1,1,3);
INSERT INTO "Rolle_i_akt" VALUES (1,1,4);
INSERT INTO "Rolle_i_akt" VALUES (1,1,5);
INSERT INTO "Rolle_i_akt" VALUES (2,1,1);
INSERT INTO "Rolle_i_akt" VALUES (2,1,3);
INSERT INTO "Rolle_i_akt" VALUES (14,1,1);
INSERT INTO "Rolle_i_akt" VALUES (14,1,2);
INSERT INTO "Rolle_i_akt" VALUES (14,1,3);
INSERT INTO "Rolle_i_akt" VALUES (14,1,4);
INSERT INTO "Rolle_i_akt" VALUES (14,1,5);
INSERT INTO "Rolle_i_akt" VALUES (6,1,4);
INSERT INTO "Rolle_i_akt" VALUES (10,1,1);
INSERT INTO "Rolle_i_akt" VALUES (10,1,2);
INSERT INTO "Rolle_i_akt" VALUES (10,1,5);
INSERT INTO "Rolle_i_akt" VALUES (12,1,4);
INSERT INTO "Rolle_i_akt" VALUES (7,1,4);
INSERT INTO "Rolle_i_akt" VALUES (7,1,1);
INSERT INTO "Rolle_i_akt" VALUES (7,1,2);
INSERT INTO "Rolle_i_akt" VALUES (7,1,3);
INSERT INTO "Rolle_i_akt" VALUES (7,1,5);
INSERT INTO "Rolle_i_akt" VALUES (4,1,5);
INSERT INTO "Rolle_i_akt" VALUES (4,1,1);
INSERT INTO "Rolle_i_akt" VALUES (4,1,2);
INSERT INTO "Rolle_i_akt" VALUES (4,1,3);
INSERT INTO "Rolle_i_akt" VALUES (4,1,4);
INSERT INTO "Rolle_i_akt" VALUES (8,1,1);
INSERT INTO "Rolle_i_akt" VALUES (8,1,5);
INSERT INTO "Rolle_i_akt" VALUES (3,1,5);
INSERT INTO "Rolle_i_akt" VALUES (3,1,1);
INSERT INTO "Rolle_i_akt" VALUES (3,1,2);
INSERT INTO "Rolle_i_akt" VALUES (3,1,3);
INSERT INTO "Rolle_i_akt" VALUES (3,1,4);
INSERT INTO "Rolle_i_akt" VALUES (9,1,1);
INSERT INTO "Rolle_i_akt" VALUES (9,1,2);
INSERT INTO "Rolle_i_akt" VALUES (9,1,3);
INSERT INTO "Rolle_i_akt" VALUES (9,1,4);
INSERT INTO "Rolle_i_akt" VALUES (9,1,5);
INSERT INTO "Rolle_i_akt" VALUES (15,1,1);
INSERT INTO "Rolle_i_akt" VALUES (15,1,2);
INSERT INTO "Rolle_i_akt" VALUES (15,1,3);
INSERT INTO "Rolle_i_akt" VALUES (11,1,3);
INSERT INTO "Rolle_i_akt" VALUES (11,1,4);
INSERT INTO "Rolle_i_akt" VALUES (11,1,5);
INSERT INTO "Rolle_i_akt" VALUES (16,2,1);
INSERT INTO "Rolle_i_akt" VALUES (17,2,1);
INSERT INTO "Rolle_i_akt" VALUES (18,2,1);
INSERT INTO "Rolle_i_akt" VALUES (19,2,1);
INSERT INTO "Rolle_i_akt" VALUES (20,2,1);
INSERT INTO "Rolle_i_akt" VALUES (21,2,1);
INSERT INTO "Rolle_i_akt" VALUES (22,2,1);
COMMIT;
