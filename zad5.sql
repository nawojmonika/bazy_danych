USE nawoj;
-- U�ywamy bazy danych 'nawoj'
DROP VIEW IF EXISTS szpital.pacjenci_przypisani_do_lekarza;
-- Usuwamy widok 'pacjenci_przypisani_do_lekarza' je�eli istnieje

CREATE VIEW szpital.pacjenci_przypisani_do_lekarza AS 
	SELECT CONCAT(p2.NAZWISKO, ' ', p2.IMIE) AS Lekarz, s.NAZWA AS Stanowisko, Liczba_pacjentow FROM 
		(SELECT p.ID AS ID_LEKARZ, COUNT(DISTINCT pl.ID_PACJENT) AS Liczba_pacjentow FROM nawoj.szpital.PACJENT_LEKARZ pl 
		LEFT JOIN nawoj.szpital.PRACOWNIK p ON pl.ID_LEKARZ  = p.ID
		GROUP BY p.ID) lp
	LEFT JOIN nawoj.szpital.PRACOWNIK p2 ON lp.ID_LEKARZ = p2.ID
	LEFT JOIN nawoj.szpital.STANOWISKO s ON p2.ID_STANOWISKO  = s.ID;
-- Tworzymy widok 'pacjenci_przypisani_do_lekarza '
-- Najpierw tworzymy zapytanie, z kt�rego wyci�gamy ID lekarza oraz liczb� przypisanych unikatowych ID pacjent�w z tabeli 'PACJENT_LEKARZ'
-- Nast�pnie ��czymy tabel� 'PRACOWNIK'po ID pracownika zgodnej z ID lekarza z tabeli 'PACJENT_LEKARZ' i grupujemy te wyniki po ID
-- Nast�pnie na tym podzapytaniu tworzymy kolejne zapytanie i na podstawie wyci�gni�tego ID lekarza wy�wietlamy jego imi� i nazwisko z tabeli 'PRACOWNIK'
-- oraz nazw� stanowiska  tabeli 'STANOWISKO'

SELECT * FROM szpital.pacjenci_przypisani_do_lekarza;
-- Wybieramy wszystko z widoku 'pacjenci_przypisani_do_lekarza'

DROP VIEW IF EXISTS	szpital.historie_pacjentow;
-- Usuwamy widok 'historie_pacjentow' je�eli istnieje
	
CREATE VIEW szpital.historie_pacjentow AS
	SELECT CONCAT(p.IMIE,' ',p.NAZWISKO) AS Pacjent, CONCAT(p2.IMIE, ' ',p2.NAZWISKO) AS Lekarz , DIAGNOZA, DATA_WPISU FROM nawoj.szpital.HISTORIA_PACJENTA hp 
	LEFT JOIN nawoj.szpital.PACJENT p ON hp.ID_PACJENT = p.ID 
	LEFT JOIN nawoj.szpital.PRACOWNIK p2 ON hp.ID_LEKARZ  = p2.ID;
-- Tworzymy widok 'historie_pacjentow' ��cz�cy tabele 'HISTORIA_PACJENTA' aby otrzyma� ID_LEKARZ oraz ID_PACJENT,
-- tabel� 'PACJENT' aby po ID otrzymanej z tabeli 'HISTORIA_PACJENTA' znale�� przypisanego pacjenta i wy�wietli� jego imi� oraz nazwisko
-- tabel� 'PRACOWNIK' aby po ID otrzymanej z tabeli 'HISTORIA_PACJENTA' znale�� przypisanego lekarza i wy�wietli� jego imi� oraz nazwisko


SELECT * FROM szpital.historie_pacjentow;
-- Wybieramy wszystko z widoku 'historie_pacjentow'

DROP VIEW IF EXISTS	szpital.pacjenci_w_placowce;
-- Usuwamy widok 'pacjenci_w_placowce' je�eli istnieje

CREATE VIEW szpital.pacjenci_w_placowce AS
	SELECT CONCAT(p.IMIE,' ',p.NAZWISKO) AS Pacjent, CONCAT(p2.IMIE, ' ',p2.NAZWISKO) AS Lekarz FROM szpital.PACJENT_LEKARZ pl 
	LEFT JOIN nawoj.szpital.PACJENT p ON pl.ID_PACJENT = p.ID
	LEFT JOIN  nawoj.szpital.PRACOWNIK p2 ON pl.ID_LEKARZ = p2.ID
	WHERE p.CZY_W_PLACOWCE LIKE 1;
-- Tworzymy widok 'pacjenci_w_placowce' ��cz�cy tabele 'PACJENT_LEKARZ' aby otrzyma� ID_LEKARZ oraz ID_PACJENT,
-- tabel� 'PACJENT' aby po ID otrzymanej z tabeli 'PACJENT_LEKARZ' znale�� przypisanego pacjenta i wy�wietli� jego imi� oraz nazwisko
-- tabel� 'PRACOWNIK' aby po ID otrzymanej z tabeli 'PACJENT_LEKARZ' znale�� przypisanego lekarza i wy�wietli� jego imi� oraz nazwisko
-- Dodany zosta� r�wnie� warunek i� pacjent musi w przebywa� w tym momencie w plac�wce (POLE CZY_W_PLACOWCE musi mie� warto�� 1)


SELECT * FROM szpital.pacjenci_w_placowce;
-- Wybieramy wszystko z widoku 'pacjenci_w_placowce'

USE master;