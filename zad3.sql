USE master;
-- U�ywamy domy�lnej bazy danej 'master'
DROP DATABASE IF EXISTS nawoj; 
-- Usuwamy baz� danych 'nawoj' je�eli ju� istnieje
CREATE DATABASE	nawoj;
-- Tworzymy baz� danych 'nawoj'

USE nawoj;
-- u�ywamy bazy danych 'nawoj'
DROP SCHEMA IF EXISTS szpital;
-- Usuwamy schemat 'szpital' je�eli ju� istnieje
CREATE SCHEMA szpital;
-- tworzymy schemat o nazwie 'szpital'

CREATE TABLE nawoj.szpital.STANOWISKO
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	NAZWA NVARCHAR(20),
	MIN_PENSJA INT,
	MAX_PENSJA INT
);
-- Tworzymy tabel� 'STANOWISKO'z kluczem g��wnym ID z autoinkrementacj� zaczynaj�c od 1, 
-- nazw� jako ci�g zmienny znak�w 
-- oraz pensj� minimaln� i maksymaln� jako liczba ca�kowita

CREATE TABLE nawoj.szpital.PRACOWNIK
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	IMIE NVARCHAR(20),
	NAZWISKO NVARCHAR(40),
	PENSJA INT,
	DATA_ZATRUDNIENIA DATETIME,
	ID_STANOWISKO INT NOT NULL,
	CONSTRAINT fk_pracownik_stanowisko_id
		FOREIGN KEY (ID_STANOWISKO)
		REFERENCES nawoj.szpital.STANOWISKO (ID)
);
-- Tworzymy tabel� 'PRACOWNIK'z kluczem g��wnym  ID z autoinkrementacj� zaczynaj�c od 1, 
-- imieniem oraz nazwiskiem jako ci�g zmienny znak�w, pensj� jako liczba ca�kowita, dat� zatrudnienia
-- oraz ID stanowiska jako klucz obcy z tabeli STANOWISKO

CREATE TABLE nawoj.szpital.PACJENT
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	IMIE NVARCHAR(20),
	NAZWISKO NVARCHAR(40),
	CZY_W_PLACOWCE BIT
);
-- Tworzymy tabel� 'PACJENT'z kluczem g��wnym ID z autoinkrementacj� zaczynaj�c od 1, 
-- imieniem oraz nazwiskiem jako ci�g zmienny znak�w
-- oraz polem CZY_W_PLACOWCE z u�yciem typu BIT, kt�ry ma pos�u�y� jako boolean 0, NULL - false, 1 - true

CREATE TABLE nawoj.szpital.HISTORIA_PACJENTA
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	ID_PACJENT INT NOT NULL,
	ID_LEKARZ INT NOT NULL,
	DIAGNOZA NVARCHAR(200),
	DATA_WPISU DATETIME,
	CONSTRAINT fk_hp_pacjent_id
		FOREIGN KEY (ID_PACJENT)
		REFERENCES nawoj.szpital.PACJENT (ID),
	CONSTRAINT fk_hp_lekarz_id
		FOREIGN KEY (ID_LEKARZ)
		REFERENCES nawoj.szpital.PRACOWNIK (ID)
);

-- Tworzymy tabel� 'HISTORIA_PACJENTA'z kluczem g��wnym ID z autoinkrementacj� zaczynaj�c od 1, 
-- kluczem obcym 'ID_PACJENT' jako ID z tabeli 'PACJENT',
-- kluczem obcym 'ID_LEKARZ' jako ID z tabeli 'PRACOWNIK',
-- diagnoz� bed�c� ci�giem znak�w oraz dat� dodania wpisu

CREATE TABLE nawoj.szpital.PACJENT_LEKARZ
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	ID_PACJENT INT NOT NULL,
	ID_LEKARZ INT NOT NULL,
	CONSTRAINT fk_pl_pacjent_id
		FOREIGN KEY (ID_PACJENT)
		REFERENCES nawoj.szpital.PACJENT (ID),
	CONSTRAINT fk_pl_lekarz_id
		FOREIGN KEY (ID_LEKARZ)
		REFERENCES nawoj.szpital.PRACOWNIK (ID)
);

-- Tworzymy tabel� 'PACJENT_LEKARZ'z kluczem g��wnym ID z autoinkrementacj� zaczynaj�c od 1, 
-- kluczem obcym 'ID_PACJENT' jako ID z tabeli 'PACJENT',
-- kluczem obcym 'ID_LEKARZ' jako ID z tabeli 'PRACOWNIK'