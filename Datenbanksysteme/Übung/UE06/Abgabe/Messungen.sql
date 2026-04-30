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