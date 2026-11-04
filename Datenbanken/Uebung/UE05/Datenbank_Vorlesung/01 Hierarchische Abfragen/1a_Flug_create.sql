DROP TABLE Flug;

CREATE TABLE Flug (
  flugnr VARCHAR2(20) PRIMARY KEY,
  abflug VARCHAR2(20),
  ziel VARCHAR2(20),
  preis NUMBER
);

INSERT INTO flug VALUES('LH131', 'Frankfurt', 'Sydney', 1009);
INSERT INTO flug VALUES('BA170', 'Zürich',  'London', 599);
INSERT INTO flug VALUES('AF691', 'Paris', 'New York', 1299);
INSERT INTO flug VALUES('UA103', 'Sydney', 'New York', 1549);
INSERT INTO flug VALUES('SR163', 'Zürich', 'Frankfurt', 499);
INSERT INTO flug VALUES('TK911', 'Paris', 'Istanbul', 799);
INSERT INTO flug VALUES('BA297', 'London', 'Frankfurt', 299);
commit;