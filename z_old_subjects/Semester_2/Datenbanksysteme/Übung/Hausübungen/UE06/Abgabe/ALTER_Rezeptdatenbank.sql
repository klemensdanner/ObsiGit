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







