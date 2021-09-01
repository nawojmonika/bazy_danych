USE master;
-- U¿ywamy domyœlnej bazy danej 'master'
DROP DATABASE IF EXISTS nawoj; 
-- Usuwamy bazê danych 'nawoj' je¿eli ju¿ istnieje
CREATE DATABASE	nawoj;
-- Tworzymy bazê danych 'nawoj'

USE nawoj;
-- u¿ywamy bazy danych 'nawoj'
DROP SCHEMA IF EXISTS szpital;
-- Usuwamy schemat 'szpital' je¿eli ju¿ istnieje
CREATE SCHEMA szpital;
-- tworzymy schemat o nazwie 'szpital'

CREATE TABLE nawoj.szpital.STANOWISKO
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	NAZWA NVARCHAR(20),
	MIN_PENSJA INT,
	MAX_PENSJA INT
);
-- Tworzymy tabelê 'STANOWISKO'z kluczem g³ównym ID z autoinkrementacj¹ zaczynaj¹c od 1, 
-- nazw¹ jako ci¹g zmienny znaków 
-- oraz pensj¹ minimaln¹ i maksymaln¹ jako liczba ca³kowita

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
-- Tworzymy tabelê 'PRACOWNIK'z kluczem g³ównym  ID z autoinkrementacj¹ zaczynaj¹c od 1, 
-- imieniem oraz nazwiskiem jako ci¹g zmienny znaków, pensj¹ jako liczba ca³kowita, dat¹ zatrudnienia
-- oraz ID stanowiska jako klucz obcy z tabeli STANOWISKO

CREATE TABLE nawoj.szpital.PACJENT
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	IMIE NVARCHAR(20),
	NAZWISKO NVARCHAR(40),
	CZY_W_PLACOWCE BIT
);
-- Tworzymy tabelê 'PACJENT'z kluczem g³ównym ID z autoinkrementacj¹ zaczynaj¹c od 1, 
-- imieniem oraz nazwiskiem jako ci¹g zmienny znaków
-- oraz polem CZY_W_PLACOWCE z u¿yciem typu BIT, który ma pos³u¿yæ jako boolean 0, NULL - false, 1 - true

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

-- Tworzymy tabelê 'HISTORIA_PACJENTA'z kluczem g³ównym ID z autoinkrementacj¹ zaczynaj¹c od 1, 
-- kluczem obcym 'ID_PACJENT' jako ID z tabeli 'PACJENT',
-- kluczem obcym 'ID_LEKARZ' jako ID z tabeli 'PRACOWNIK',
-- diagnoz¹ bed¹c¹ ci¹giem znaków oraz dat¹ dodania wpisu

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

-- Tworzymy tabelê 'PACJENT_LEKARZ'z kluczem g³ównym ID z autoinkrementacj¹ zaczynaj¹c od 1, 
-- kluczem obcym 'ID_PACJENT' jako ID z tabeli 'PACJENT',
-- kluczem obcym 'ID_LEKARZ' jako ID z tabeli 'PRACOWNIK'