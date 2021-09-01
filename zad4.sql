USE nawoj;
-- Uzywamy bazy danych o nazwie 'nawoj'

DROP PROCEDURE IF EXISTS szpital.dodaj_stanowisko;
-- Usuwamy procedur� 'dodaj_stanowisko' je�eli istnieje
GO
-- Sygnalizuje zako�czenie transakcji
CREATE PROCEDURE szpital.dodaj_stanowisko @nazwa NVARCHAR(20), @min_pensja INT, @max_pensja INT AS
INSERT INTO nawoj.szpital.STANOWISKO (NAZWA, MIN_PENSJA, MAX_PENSJA)
VALUES (@nazwa, @min_pensja, @max_pensja);
GO
-- Sygnalizuje zako�czenie transakcji
-- Tworzymy procedur� 'dodaj_stanowisko' w schemacie 'szpital',
-- kt�ra dodaje rekordy do tabeli 'STANOWISKO' z podanymi przez nas parametrami
EXEC szpital.dodaj_stanowisko 'Kierownik', 10000, 20000;
EXEC szpital.dodaj_stanowisko 'Piel�gniarz', 2000, 5000;
EXEC szpital.dodaj_stanowisko 'Internista', 2000, 7000; 
EXEC szpital.dodaj_stanowisko 'Kardiolog', 5000, 10000; 
EXEC szpital.dodaj_stanowisko 'Ginekolog', 5000, 10000; 
EXEC szpital.dodaj_stanowisko 'Neurolog', 6000, 10000; 
-- Dodajemy przyk�adowe stanowiska przy u�yciu procedury

DROP PROCEDURE IF EXISTS szpital.dodaj_pracownik;
-- Usuwamy procedur� 'dodaj_pracownik' je�eli istnieje
GO
-- Sygnalizuje zako�czenie transakcji
CREATE PROCEDURE szpital.dodaj_pracownik @imie NVARCHAR(20), @nazwisko NVARCHAR(40), @id_stanowisko INT, @pensja INT AS
IF EXISTS (SELECT ID, MIN_PENSJA , MAX_PENSJA FROM nawoj.szpital.STANOWISKO WHERE ID LIKE @id_stanowisko AND @pensja >= MIN_PENSJA AND @pensja <= MAX_PENSJA)
BEGIN 
	INSERT INTO nawoj.szpital.PRACOWNIK (IMIE, NAZWISKO, ID_STANOWISKO, PENSJA, DATA_ZATRUDNIENIA)
	VALUES (@imie, @nazwisko, @id_stanowisko, @pensja, GETDATE());
END
ELSE
BEGIN
	PRINT 'B��d! Wprowadzona pensja nie zgadza si� z przedzia�em dla tego stanowiska!'
END
-- Tworzymy procedur� 'dodaj_pracownik' w schemacie 'szpital'
-- ze sprawedzeniem czy wprowadzona pensja mie�ci si� w zdefiniowanym w stanowisku przedziale
-- je�eli �le wpiszemy warto�� pensji rekord nie doda si� i wy�wietli si� widomo�� z b��dem.
-- W przypadku dodania rekordu opr�cz podanych parametr�w w polu DATA_ZATRUDNIENIA zosta�a u�yta funkcja GETDATE(),
-- kt�ra zwraca aktualn� dat� oraz czas w momencie dodania rekordu
GO
-- Sygnalizuje zako�czenie transakcji

EXEC szpital.dodaj_pracownik  'Monika', 'Naw�j', 1, 15000;
EXEC szpital.dodaj_pracownik  'Barbara', 'Kowalska', 2, 3000;
EXEC szpital.dodaj_pracownik  'Jan', 'Kowalski', 3, 4500;
EXEC szpital.dodaj_pracownik  'Gra�yna', 'Nowakowska', 4, 5000;
EXEC szpital.dodaj_pracownik  'Janusz', 'Nowakowski', 5, 7000;
EXEC szpital.dodaj_pracownik  'Anna', 'Nowak', 6, 8000;
-- Dodajemy przyk�adowych pracownik�w przy u�yciu procedury

DROP PROCEDURE IF EXISTS szpital.dodaj_pacjenta;
-- Usuwamy procedur� 'dodaj_pacjenta' je�eli istnieje
GO
-- Sygnalizuje zako�czenie transakcji
CREATE PROCEDURE szpital.dodaj_pacjenta @imie NVARCHAR(20), @nazwisko NVARCHAR(40), @czy_w_placowce BIT AS
INSERT INTO nawoj.szpital.PACJENT (IMIE, NAZWISKO, CZY_W_PLACOWCE)
VALUES (@imie, @nazwisko, @czy_w_placowce);
-- Tworzymy procedur� 'dodaj_pacjenta' w schemacie 'szpital',
-- kt�ra dodaje rekordy do tabeli 'PACJENT' z podanymi przez nas parametrami
EXEC szpital.dodaj_pacjenta 'Tadeusz', 'Kowalski', 0;
EXEC szpital.dodaj_pacjenta 'Jan', 'Nowak', 1;
EXEC szpital.dodaj_pacjenta 'Krzysztof', 'Lipiec', 0;
EXEC szpital.dodaj_pacjenta 'Gra�yna', 'Borowska', 1;
EXEC szpital.dodaj_pacjenta 'Janusz', 'Wiero�skii', 0;
EXEC szpital.dodaj_pacjenta 'Bogumi�a', 'Nowak', 1;
-- Dodajemy przyk�adowych pacjent�w przy u�yciu procedury

DROP PROCEDURE IF EXISTS szpital.dodaj_historie_pacjenta;
-- Usuwamy procedur� 'dodaj_historie_pacjenta' je�eli istnieje
GO
-- Sygnalizuje zako�czenie transakcji
CREATE PROCEDURE szpital.dodaj_historie_pacjenta @id_pacjent INT, @id_lekarz INT, @diagnoza NVARCHAR(200) AS
INSERT INTO nawoj.szpital.HISTORIA_PACJENTA (ID_PACJENT, ID_LEKARZ, DIAGNOZA, DATA_WPISU)
VALUES (@id_pacjent, @id_lekarz, @diagnoza, GETDATE());
-- Tworzymy procedur� 'dodaj_historie_pacjenta' w schemacie 'szpital',
-- kt�ra dodaje rekordy do tabeli 'HISTORIA_PACJENTA' z podanymi przez nas parametrami oraz dat� i czasem wpisu
GO
-- Sygnalizuje zako�czenie transakcji

EXEC szpital.dodaj_historie_pacjenta 1, 3, 'Niedocukrzenie krwi';
EXEC szpital.dodaj_historie_pacjenta 2, 3, 'Angina';
EXEC szpital.dodaj_historie_pacjenta 3, 3, 'Kwasica ketonowa';
EXEC szpital.dodaj_historie_pacjenta 4, 4, 'Nadci�nienie t�tnicze wt�rne ';
EXEC szpital.dodaj_historie_pacjenta 5, 5, 'Chlamydia Trachomatis';
EXEC szpital.dodaj_historie_pacjenta 6, 6, 'Nerwob�l nerwu tr�jdzielnego';
EXEC szpital.dodaj_historie_pacjenta 6, 3, 'Niedocukrzenie krwi';
EXEC szpital.dodaj_historie_pacjenta 5, 3, 'Angina';
EXEC szpital.dodaj_historie_pacjenta 4, 3, 'Kwasica ketonowa';
EXEC szpital.dodaj_historie_pacjenta 3, 4, 'Nadci�nienie t�tnicze wt�rne ';
EXEC szpital.dodaj_historie_pacjenta 2, 5, 'Chlamydia Trachomatis';
EXEC szpital.dodaj_historie_pacjenta 1, 6, 'Nerwob�l nerwu tr�jdzielnego';
-- Dodajemy przyk�adow� histori� pacjent�w przy u�yciu procedury

DROP PROCEDURE IF EXISTS szpital.dodaj_pacjent_lekarz;
-- Usuwamy procedur� 'dodaj_pacjent_lekarz' je�eli istnieje
GO
-- Sygnalizuje zako�czenie transakcji

CREATE PROCEDURE szpital.dodaj_pacjent_lekarz @id_pacjent INT, @id_lekarz INT AS
INSERT INTO nawoj.szpital.PACJENT_LEKARZ (ID_PACJENT, ID_LEKARZ)
VALUES (@id_pacjent, @id_lekarz);
-- Tworzymy procedur� 'dodaj_pacjent_lekarz' w schemacie 'szpital',
-- kt�ra dodaje rekordy do tabeli 'PACJENT_LEKARZ' z podanymi przez nas parametrami
GO
-- Sygnalizuje zako�czenie transakcji

EXEC szpital.dodaj_pacjent_lekarz 1, 3;
EXEC szpital.dodaj_pacjent_lekarz 2, 3;
EXEC szpital.dodaj_pacjent_lekarz 3, 3;
EXEC szpital.dodaj_pacjent_lekarz 4, 4;
EXEC szpital.dodaj_pacjent_lekarz 5, 5;
EXEC szpital.dodaj_pacjent_lekarz 6, 6;
EXEC szpital.dodaj_pacjent_lekarz 6, 3;
EXEC szpital.dodaj_pacjent_lekarz 5, 3;
EXEC szpital.dodaj_pacjent_lekarz 4, 3;
EXEC szpital.dodaj_pacjent_lekarz 3, 4;
EXEC szpital.dodaj_pacjent_lekarz 2, 5;
EXEC szpital.dodaj_pacjent_lekarz 1, 6;
-- Dodajemy przyk�adowe powi�zania pacjent-lekarz przy u�yciu procedury

USE master;
