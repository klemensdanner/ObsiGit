CREATE TABLE Mitarbeiter (
    PNr NUMBER(9), --PRIMARY KEY (inline constraint)
    vorname varchar(20) not null, -- 20 is max length
    nachname varchar(20) not null, 
    GebDat date default SYSDATE
    --constraint Mitarbeiter_PK primary key(PNr) -- (out of line)

);


alter table Mitarbeiter add (constraint Mitarbeiter_PK primary key (PNr));
-- prim key ist ein constraint weil er das Attribut einschränkt
-- d.h. er ist dann not null und unique



create table Abteilung (
    ANr number(3),
    Bezeichnung varchar(20) not null,
    primary key (ANr)
);

alter table Mitarbeiter add (AbteilungsNr number(3)); -- attribut adden für den foreign key
alter table Mitarbeiter add (
    constraint Mitarbeiter_AbteilungsNr_FK -- constraint anlegen wegen fehlermeldung
        foreign key (AbteilungsNr) -- attribut zum foreign key machen
            references Abteilung(ANr)); -- sagen was es referenziert

describe Mitarbeiter;

alter table Mitarbeiter drop column nachname;
alter table Mitarbeiter drop column Mitarbeiter_AbteilungsNr_FK;


drop table Mitarbeiter;
drop table Abteilung;


