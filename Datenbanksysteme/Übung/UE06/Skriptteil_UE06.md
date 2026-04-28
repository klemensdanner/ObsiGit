
# 2. Rezeptdatenbank – Physisches Modell

```sql
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
```


### 2.1 Ausgabe / Ausführung auf der Datenbank
Aus Gründen der Übersichtlichkeit kopiert und nicht gescreenshottet.

```
Table ZUTAT created.
Table REZEPT created.
Table MATERIALZUTAT created.
Table PERSON created.
Table LABEL created.
Table BEWERTUNG created.
Table EINHEIT created.
Table BILD created.
Table KOCHANWEISUNG created.
Table VERGIBT created.
Table VERWENDET created.
Table ENTSPRICHT created.
Table REZEPT_ZEIGT created.
Table BESTEHT_AUS created.
Table ANWEISUNG_ZEIGT created.
```


# 3. Rezeptdatenbank – Schemaevolution

```sql
ALTER TABLE Zutat ADD (
    CONSTRAINT Zutat_ZEinheitID_FK FOREIGN KEY (ZEinheitID)
        REFERENCES Einheit(EinheitID)
);

ALTER TABLE Rezept ADD (
    CONSTRAINT Rezept_VerfasserID_FK FOREIGN KEY (VerfasserID)
        REFERENCES Person(PersonID),
    CONSTRAINT Rezept_RezeptID_FK FOREIGN KEY (RezeptID)
        REFERENCES Zutat(ZutatID)
);

ALTER TABLE Materialzutat ADD (
    CONSTRAINT Materialzutat_MaterialID_FK FOREIGN KEY (MaterialID)
        REFERENCES Zutat(ZutatID)  
);

-- Person passt bereits
-- Label passt bereits

ALTER TABLE Bewertung ADD (
    CONSTRAINT Bewertung_BRezeptID_FK FOREIGN KEY (BRezeptID)
        REFERENCES Rezept(RezeptID),
    CONSTRAINT Bewertung_BewerterID_FK FOREIGN KEY (BewerterID)
        REFERENCES Person(PersonID)
);

-- Einheit passt
-- Bild passt
-- Kochanweisung passt

------- N:M Relationen updaten

ALTER TABLE vergibt ADD (
    CONSTRAINT vergibt_RezeptID_FK FOREIGN KEY (RezeptID)
        REFERENCES Rezept(RezeptID),
    CONSTRAINT vergibt_PersonID_FK FOREIGN KEY (PersonID)
        REFERENCES Person(PersonID),
    CONSTRAINT vergibt_LabelID_FK FOREIGN KEY (LabelID)
        REFERENCES Label(LabelID)
);

ALTER TABLE verwendet ADD (
    CONSTRAINT verwendet_ZutatID_FK FOREIGN KEY (ZutatID)
        REFERENCES Zutat(ZutatID),
    CONSTRAINT verwendet_RezeptID_FK FOREIGN KEY (RezeptID)
        REFERENCES Rezept(RezeptID)
);

ALTER TABLE entspricht ADD (
    CONSTRAINT entspricht_EinheitID1_FK FOREIGN KEY (EinheitID1)
        REFERENCES Einheit(EinheitID),
    CONSTRAINT entspricht_EinheitID2_FK FOREIGN KEY (EinheitID2)
        REFERENCES Einheit(EinheitID)
);

ALTER TABLE Rezept_zeigt ADD (
    CONSTRAINT Rezept_zeigt_RezeptID_FK FOREIGN KEY (RezeptID)
        REFERENCES Rezept(RezeptID),
    CONSTRAINT Rezept_zeigt_BildID_FK FOREIGN KEY (BildID)
        REFERENCES Bild(BildID)
);

ALTER TABLE besteht_aus ADD (
    CONSTRAINT besteht_aus_RezeptID FOREIGN KEY (RezeptID)
        REFERENCES Rezept(RezeptID),
    CONSTRAINT besteht_aus_AnweisungsID FOREIGN KEY (AnweisungsID)
        REFERENCES Kochanweisung(AnweisungsID)
);


ALTER TABLE anweisung_zeigt ADD (
    CONSTRAINT anweisung_zeigt_BildID FOREIGN KEY (BildID)
        REFERENCES Bild(BildID),
    CONSTRAINT anweisung_zeigt_AnweisungsID FOREIGN KEY (AnweisungsID)
        REFERENCES Kochanweisung(AnweisungsID)
);

ALTER TABLE Bewertung DROP COLUMN Geschmack;

ALTER TABLE Rezept ADD CONSTRAINT Rezept_Anzahl_range_check CHECK (Anzahl >= 1 AND Anzahl <= 12);
```

### 3.1 Ausgabe / Ausführung auf der Datenbank

```
Table ZUTAT altered.
Table REZEPT altered.
Table MATERIALZUTAT altered.
Table BEWERTUNG altered.
Table VERGIBT altered.
Table VERWENDET altered.
Table ENTSPRICHT altered.
Table REZEPT_ZEIGT altered.
Table BESTEHT_AUS altered.
Table ANWEISUNG_ZEIGT altered.
Table BEWERTUNG altered.
Table REZEPT altered.
```


Der Befehl (von Prof. Niklas im Moodle-Forum zum Testen zur Verfügung gestellt, noch nicht wirklich gelernt)
```
SELECT * FROM TAB;
```
gibt folgendes aus.
![[Pasted image 20260428201759.png|350]]


## 4. Rezeptdatenbank – Löschen von Tabellen


```
DROP TABLE Anweisung_zeigt;
DROP TABLE besteht_aus;
DROP TABLE rezept_zeigt;
DROP TABLE entspricht;
DROP TABLE verwendet;
DROP TABLE vergibt;

DROP TABLE Bewertung;
DROP TABLE Rezept;
DROP TABLE Materialzutat;
DROP TABLE Person;
DROP TABLE Zutat;
DROP TABLE Label;
DROP TABLE Einheit;
DROP TABLE Bild;
DROP TABLE Kochanweisung;
```


### 4.1 Ausgabe / Ausführung auf der Datenbank

```
Table ANWEISUNG_ZEIGT dropped.
Table BESTEHT_AUS dropped.
Table REZEPT_ZEIGT dropped.
Table ENTSPRICHT dropped.
Table VERWENDET dropped.
Table VERGIBT dropped.
Table BEWERTUNG dropped.
Table REZEPT dropped.
Table MATERIALZUTAT dropped.
Table PERSON dropped.
Table ZUTAT dropped.
Table LABEL dropped.
Table EINHEIT dropped.
Table BILD dropped.
Table KOCHANWEISUNG dropped.
```

![[Pasted image 20260428205844.png|350]]

--> kein Output, weil gelöscht



## 5. Erstellung DDL für gegebene Daten


```sql
CREATE TABLE Einheit (
    EinheitID NUMBER(9),
    Einheit VARCHAR(20),
    CONSTRAINT Einheit_PK PRIMARY KEY (EinheitID)
);


CREATE TABLE Gerät (
    GeräteID NUMBER(9),
    Geräte_Bezeichnung VARCHAR(30) NOT NULL,
    Einbau_Datum DATE, -- kann null sein, vll wird das Gerät vor dem Einbau im System registriert
    Unterer_Grenzwert NUMBER(5,2), -- vll gibts noch keine Grenzwert, deshalb NULL erlaubt
    Oberer_Grenzwert NUMBER(5,2),
    Laufende_Kosten NUMBER(6,2), -- vll sind Kosten noch nicht verfügbar
    EinheitID NUMBER(9) NOT NULL, -- FK
    CONSTRAINT Gerät_PK PRIMARY KEY (GeräteID),
    CONSTRAINT Laufende_Kosten_check CHECK (Laufende_Kosten >= 0),
    CONSTRAINT Gerät_EinheitID_FK FOREIGN KEY (EinheitID)
        REFERENCES Einheit(EinheitID)
);

CREATE TABLE Messungen (
    LogID NUMBER(9),
    GeräteID NUMBER(9), -- PK und FK
    Messwert NUMBER(5,2),
    Messzeit DATE NOT NULL, -- date speichert auch Uhrzeit
    StatusID NUMBER(1) NOT NULL, -- es gibt nur 3 Status
    Aktiv NUMBER(1) DEFAULT 1 NOT NULL, -- false := 0, true := 1 | hier keine eigene Tabelle, effizienter
    CONSTRAINT Messungen_PK PRIMARY KEY (LogID),
    CONSTRAINT Messungen_GeräteID_FK FOREIGN KEY (GeräteID)
        REFERENCES Gerät(GeräteID)
        ON DELETE CASCADE,
    CONSTRAINT StatusID_check CHECK (StatusID >= 0 AND StatusID <= 3),
    CONSTRAINT Aktiv_check CHECK (Aktiv >= 0 AND Aktiv <= 1),
    CONSTRAINT Messwert_check CHECK (Messwert IS NOT NULL OR StatusID = 2)  
)
```


### 4.1 Ausgabe / Ausführung auf der Datenbank

```

Table EINHEIT created.
Table GERÄT created.
Table MESSUNGEN created.
```
