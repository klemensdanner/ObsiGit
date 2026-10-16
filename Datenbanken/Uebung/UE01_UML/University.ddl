CREATE TABLE Assistent (
  ID          number(10) GENERATED AS IDENTITY, 
  ProfessorID number(10) NOT NULL, 
  Name        varchar2(255), 
  Fachgebiet  varchar2(255), 
  PRIMARY KEY (ID));
CREATE TABLE Professor (
  ID   number(10) GENERATED AS IDENTITY, 
  Name varchar2(255), 
  Rang varchar2(255), 
  Raum varchar2(255), 
  PRIMARY KEY (ID));
CREATE TABLE Student (
  ID       number(10) GENERATED AS IDENTITY, 
  Name     varchar2(255), 
  Semester number(10) NOT NULL, 
  PRIMARY KEY (ID));
CREATE TABLE Prüfung (
  ID2       number(10) GENERATED AS IDENTITY, 
  StudentID number(10) NOT NULL, 
  ID        number(10) NOT NULL, 
  Note      number(10) NOT NULL, 
  Datum     date, 
  PRIMARY KEY (ID2));
CREATE TABLE Teilname (
  ID2          number(10) GENERATED AS IDENTITY, 
  ID           number(10) NOT NULL, 
  Leitungstyp  varchar2(255), 
  LerngruppeID number(10) NOT NULL, 
  StudentID    number(10) NOT NULL, 
  PRIMARY KEY (ID2));
CREATE TABLE Lerngruppe (
  ID   number(10) GENERATED AS IDENTITY, 
  Fach varchar2(255), 
  PRIMARY KEY (ID));
CREATE TABLE Professor_Student (
  ProfessorID number(10) NOT NULL, 
  StudentID   number(10) NOT NULL, 
  PRIMARY KEY (ProfessorID, 
  StudentID));
ALTER TABLE Assistent ADD CONSTRAINT arbeitetFuer FOREIGN KEY (ProfessorID) REFERENCES Professor (ID);
ALTER TABLE Prüfung ADD CONSTRAINT FKPrüfung967267 FOREIGN KEY (StudentID) REFERENCES Student (ID);
ALTER TABLE Professor_Student ADD CONSTRAINT unterrichtet FOREIGN KEY (ProfessorID) REFERENCES Professor (ID);
ALTER TABLE Professor_Student ADD CONSTRAINT unterrichtet2 FOREIGN KEY (StudentID) REFERENCES Student (ID);
ALTER TABLE Teilname ADD CONSTRAINT nimmtTeil FOREIGN KEY (LerngruppeID) REFERENCES Lerngruppe (ID);
ALTER TABLE Teilname ADD CONSTRAINT nimmtTeil2 FOREIGN KEY (StudentID) REFERENCES Student (ID);
