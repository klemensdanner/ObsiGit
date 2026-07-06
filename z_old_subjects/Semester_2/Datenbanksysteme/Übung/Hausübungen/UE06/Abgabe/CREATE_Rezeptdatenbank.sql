CREATE TABLE Zutat (
    ZutatID NUMBER(9), --primary key
    Name VARCHAR(50) NOT NULL,
    VorbVariante VARCHAR(50),
    ZEinheitID NUMBER(9) NOT NULL,
    CONSTRAINT Zutat_PK PRIMARY KEY (ZutatID)
);

CREATE TABLE Rezept (
    RezeptID NUMBER(9), --primary and foreign key
    Beschreibung VARCHAR(1000) NOT NULL,
    Anzahl NUMBER(3) DEFAULT 4 NOT NULL,
    VerfasserID NUMBER(9) NOT NULL,
    CONSTRAINT Rezept_PK PRIMARY KEY (RezeptID)
);

CREATE TABLE Materialzutat (
    MaterialID NUMBER(9),
    Preis NUMBER(8,2) NOT NULL,
    CONSTRAINT Material_PK PRIMARY KEY (MaterialID)
);

CREATE TABLE Person (
    PersonID NUMBER(9),
    vorname VARCHAR(30),
    nachname VARCHAR(30),
    CONSTRAINT Person_PK PRIMARY KEY (PersonID)
);

CREATE TABLE Label (
    LabelID NUMBER(9),
    Wort VARCHAR(30) NOT NULL,
    CONSTRAINT Label_PK PRIMARY KEY (LabelID)
);

CREATE TABLE Bewertung (
    BewertungsID NUMBER(9),
    BRezeptID NUMBER(9) NOT NULL,
    Einfachheit NUMBER(1) NOT NULL, -- 1-5, zwingend, wenn man eine Bewertung erstellt
    Geschmack NUMBER(1) NOT NULL, -- analog zur Einfachheit
    Datum DATE NOT NULL,
    Kommentar VARCHAR(1000),
    BewerterID NUMBER(9) NOT NULL,
    CONSTRAINT Bewertung_PK PRIMARY KEY (BewertungsID),
    CONSTRAINT range_check_Einfachheit CHECK (Einfachheit >= 1 AND Einfachheit <= 5),
    CONSTRAINT range_check_Geschmack CHECK (Geschmack >= 1 AND Geschmack <= 5)
);

CREATE TABLE Einheit (
    EinheitID NUMBER(9),
    Bezeichnung VARCHAR(30) NOT NULL,
    CONSTRAINT Einheit_PK PRIMARY KEY (EinheitID)
);

CREATE TABLE Bild (
    BildID NUMBER(9),
    DateiName VARCHAR(50) NOT NULL,
    Verzeichnis VARCHAR(100) NOT NULL,
    CONSTRAINT Bild_PK PRIMARY KEY (BildID)
);

CREATE TABLE Kochanweisung (
    AnweisungsID NUMBER(9),
    Zeit NUMBER(5) NOT NULL, -- kann in min gespeichert werden
    Text VARCHAR(1000),
    CONSTRAINT Kochanweisung_PK PRIMARY KEY (AnweisungsID)
);


-- Tabellen für die m:n Beziehungen


CREATE TABLE vergibt (
    RezeptID NUMBER(9),
    PersonID NUMBER(9),
    LabelID NUMBER(9),
    CONSTRAINT vergibt_PK PRIMARY KEY (RezeptID, PersonID, LabelID)
);

CREATE TABLE verwendet (
    ZutatID NUMBER(9),
    RezeptID NUMBER(9),
    Menge NUMBER(4) NOT NULL,
    CONSTRAINT verwendet_PK PRIMARY KEY (ZutatID, RezeptID)
);


CREATE TABLE entspricht (
    EinheitID1 NUMBER(9),
    EinheitID2 NUMBER(9),
    Faktor NUMBER(12,6) NOT NULL, -- genug Nachkommerstellen für präzise Umrechnung
    CONSTRAINT entspricht_PK PRIMARY KEY (EinheitID1, EinheitID2)
);

CREATE TABLE Rezept_zeigt (
    RezeptID NUMBER(9),
    BildID NUMBER(9),
    Reihenfolge NUMBER(4) NOT NULL,
    CONSTRAINT Rezept_zeigt_PK PRIMARY KEY (RezeptID, BildID)

);

CREATE TABLE besteht_aus (
    RezeptID NUMBER(9),
    AnweisungsID NUMBER(9),
    Reihenfolge NUMBER(4) NOT NULL,
    CONSTRAINT bestehtAus_PK PRIMARY KEY (RezeptID, AnweisungsID)

);


CREATE TABLE Anweisung_zeigt (
    AnweisungsID NUMBER(9),
    BildID NUMBER(9),
    Reihenfolge NUMBER(4) NOT NULL,
    CONSTRAINT Anweisung_zeigt_PK PRIMARY KEY (AnweisungsID, BildID)

);