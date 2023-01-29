--zad 1 - tworzenie tabel
CREATE TABLE Koty(
    pseudonim VARCHAR(15) CONSTRAINT kt_pk PRIMARY KEY, 
    szef VARCHAR(15) CONSTRAINT kt_fk1 REFERENCES Koty(pseudonim), 
    przydzial_myszy NUMBER(2) CONSTRAINT kt_pm CHECK(przydzial_myszy >= 0), 
    plec CHAR(1) CONSTRAINT kt_p1 NOT NULL CONSTRAINT kt_p2 CHECK (plec IN ('K','M')),
    wstapil DATE CONSTRAINT kt_d NOT NULL
    );
CREATE TABLE Bandy(
    numer NUMBER(2) CONSTRAINT bd_pk PRIMARY KEY,
    nazwa VARCHAR(15) CONSTRAINT bd_nz NOT NULL,
    dowodca VARCHAR(15) CONSTRAINT bd_dw REFERENCES Koty(pseudonim),
    teren VARCHAR(15) CONSTRAINT bd_tr NOT NULL);
CREATE TABLE Funkcje(
    nazwa VARCHAR(15) CONSTRAINT fk_nz PRIMARY KEY,
    mini NUMBER(2) CONSTRAINT fk_mn NOT NULL,
    maxi NUMBER(2) CONSTRAINT fk_mx NOT NULL);
CREATE TABLE Incydenty(
    pseudonim VARCHAR(15) CONSTRAINT inc_pw REFERENCES Koty(pseudonim),
    pseudonim_wroga VARCHAR (15),
    wrogosc NUMBER(2) CONSTRAINT inc_wr NOT NULL,
    opis VARCHAR(100),
    data DATE CONSTRAINT inc_dt NOT NULL,
    CONSTRAINT inc_pk PRIMARY KEY(pseudonim, pseudonim_wroga)
);
CREATE TABLE Wrogowie(
    pseudonim_wroga VARCHAR(15) CONSTRAINT wr_ps PRIMARY KEY,
    gatunek VARCHAR(15) CONSTRAINT ws_gt NOT NULL);
CREATE TABLE Myszy(
    id NUMBER(15) CONSTRAINT m_id PRIMARY KEY,
    data_upolowania DATE CONSTRAINT m_du NOT NULL,
    data_wydania DATE,
    waga NUMBER(5) CONSTRAINT m_w NOT NULL CONSTRAINT m_w2 CHECK(waga >= 10),
    dlugosc NUMBER(5) CONSTRAINT m_d NOT NULL CONSTRAINT m_d2 CHECK(dlugosc >= 5),
    lowca VARCHAR(15) CONSTRAINT m_l REFERENCES Koty(pseudonim),
    pobierajacy VARCHAR(15) CONSTRAINT m_p REFERENCES Koty(pseudonim));
CREATE TABLE Gratyfikacje(
    gratyfikacja VARCHAR(15) CONSTRAINT g_pk PRIMARY KEY);
CREATE TABLE Lapowki_wrogow(
    pseudo_wroga VARCHAR(15) CONSTRAINT lw_pw REFERENCES Wrogowie(pseudonim_wroga),
    gratyfikacja VARCHAR(15) CONSTRAINT lw_g REFERENCES Gratyfikacje(gratyfikacja),
    CONSTRAINT lw_pk PRIMARY KEY(pseudo_wroga, gratyfikacja));
ALTER TABLE Koty ADD nr_bandy NUMBER(2) CONSTRAINT kt_bd REFERENCES Bandy(numer); 
ALTER TABLE Koty ADD funkcja VARCHAR(15) CONSTRAINT kt_f REFERENCES Funkcje(nazwa);

--zad 2 - uzupelnianie tabel
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('bimber');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('czekolada');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('kurczak');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('krawat');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('kwiatek');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('kosc');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('kasa');

INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Salazar', 'czlowiek');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Antonio', 'czlowiek');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Henio', 'czlowiek');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Pimpek', 'pies');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Augustus', 'kon');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Czarny', 'kruk');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Ala', 'krowa');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Gienia', 'czlowiek');

INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Salazar', 'bimber');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Henio', 'czekolada');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Pimpek', 'kosc');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Ala', 'kwiatek');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Czarny', 'kurczak');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Augustus', 'krawat');

INSERT INTO Funkcje(nazwa, mini, maxi) VALUES('szef', 20, 25);
INSERT INTO Funkcje(nazwa, mini, maxi) VALUES('manager', 15, 20);
INSERT INTO Funkcje(nazwa, mini, maxi) VALUES('lapacz', 10, 15);
INSERT INTO Funkcje(nazwa, mini, maxi) VALUES('wydawacz', 8, 12);
INSERT INTO Funkcje(nazwa, mini, maxi) VALUES('ksiegowy', 5, 15);
INSERT INTO Funkcje(nazwa, mini, maxi) VALUES('magazynier', 10, 14);
INSERT INTO Funkcje(nazwa, mini, maxi) VALUES('spawacz', 12, 20);

INSERT INTO Bandy(numer, nazwa, dowodca, teren) VALUES(1, 'Druzyna A', NULL, 'wzgorza');
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Lapka', NULL, 25, 'M', TO_DATE('01/01/1998', 'DD/MM/YYYY'), 'szef', NULL);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Beczka', 'Lapka', 18, 'M', TO_DATE('13/05/1999', 'DD/MM/YYYY'), 'manager', 1);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Karol', 'Lapka', 19, 'M', TO_DATE('09/07/1998', 'DD/MM/YYYY'), 'manager', 1);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Puszek', 'Lapka', 15, 'M', TO_DATE('21/09/2000', 'DD/MM/YYYY'), 'manager', 1);
INSERT INTO Bandy(numer, nazwa, dowodca, teren) VALUES(2, 'Plaszczaki', 'Beczka', 'plaskowyz');
INSERT INTO Bandy(numer, nazwa, dowodca, teren) VALUES(3, 'Doliniaki', 'Karol', 'dolina');
INSERT INTO Bandy(numer, nazwa, dowodca, teren) VALUES(4, 'Lasiaki', 'Puszek', 'las');
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Anka', 'Beczka', 10, 'K', TO_DATE('06/12/2002', 'DD/MM/YYYY'), 'lapacz', 2);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Smiglo', 'Beczka', 25, 'M', TO_DATE('29/10/1999', 'DD/MM/YYYY'), 'lapacz', 2);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Rysiek', 'Beczka', 5, 'M', TO_DATE('01/01/1999', 'DD/MM/YYYY'), NULL, 2);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Konewka', 'Beczka', 10, 'M', TO_DATE('13/06/2003', 'DD/MM/YYYY'), 'ksiegowy', NULL);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Nowka', NULL, 5, 'K', TO_DATE('10/03/2005', 'DD/MM/YYYY'), NULL, NULL);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Hiena', 'Karol', 15, 'M', TO_DATE('09/07/2007', 'DD/MM/YYYY'), 'lapacz', 4);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Wariatka', 'Karol', 14, 'K', TO_DATE('28/12/2000', 'DD/MM/YYYY'), 'magazynier', 4);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Meduza', 'Puszek', 9, 'K', TO_DATE('17/11/1998', 'DD/MM/YYYY'), 'wydawacz', 4);

INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Lapka', 'Henio', 3,NULL,TO_DATE('05/01/1998', 'DD/MM/YYYY'));
INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Karol', 'Henio', 2,NULL,TO_DATE('05/01/2001', 'DD/MM/YYYY'));
INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Nowka', 'Ala', 7,NULL,TO_DATE('05/01/2006', 'DD/MM/YYYY'));
INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Nowka', 'Gienia', 5,NULL,TO_DATE('12/06/2006', 'DD/MM/YYYY'));
INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Smiglo', 'Czarny', 9,NULL,TO_DATE('29/08/2000', 'DD/MM/YYYY'));
INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Hiena', 'Antonio', 2,NULL,TO_DATE('09/07/2007', 'DD/MM/YYYY'));
INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Lapka', 'Augustus', 6,NULL,TO_DATE('21/01/1998', 'DD/MM/YYYY'));
INSERT INTO Incydenty(pseudonim, pseudonim_wroga, wrogosc, opis, data) VALUES('Lapka', 'Salazar', 5,NULL,TO_DATE('12/01/1999', 'DD/MM/YYYY'));

INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(1, TO_DATE('05/01/2010', 'DD/MM/YYYY'), NULL, 10, 15, 'Lapka', NULL);
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(2, TO_DATE('05/01/2010', 'DD/MM/YYYY'),TO_DATE('20/01/2010', 'DD/MM/YYYY') , 12, 15, 'Karol', 'Lapka');
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(3, TO_DATE('07/01/2010', 'DD/MM/YYYY'),TO_DATE('14/01/2010', 'DD/MM/YYYY') , 15, 17, 'Smiglo', 'Puszek');
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(4, TO_DATE('12/01/2010', 'DD/MM/YYYY'), TO_DATE('27/01/2010', 'DD/MM/YYYY'), 22, 10, 'Smiglo', 'Puszek');
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(5, TO_DATE('01/02/2010', 'DD/MM/YYYY'),TO_DATE('05/02/2010', 'DD/MM/YYYY') , 50, 20, 'Smiglo', 'Konewka');
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(6, TO_DATE('08/02/2010', 'DD/MM/YYYY'), NULL, 30, 15, 'Meduza', NULL);
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(7, TO_DATE('23/03/2010', 'DD/MM/YYYY'), NULL, 19, 13, 'Hiena', NULL);
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(8, TO_DATE('27/05/2010', 'DD/MM/YYYY'),TO_DATE('2/06/2010', 'DD/MM/YYYY') , 28, 18, 'Karol', 'Meduza');
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(9, TO_DATE('09/06/2010', 'DD/MM/YYYY'), TO_DATE('09/06/2010', 'DD/MM/YYYY'), 15, 17, 'Beczka', 'Anka');
INSERT INTO Myszy(id, data_upolowania, data_wydania, waga, dlugosc, lowca, pobierajacy) VALUES(10, TO_DATE('12/06/2010', 'DD/MM/YYYY'),TO_DATE('15/06/2010', 'DD/MM/YYYY') , 11, 21, 'Lapka', 'Lapka');

INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Hiacynt', 'kon');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Rumi', 'wrona');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Tekla', 'czlowiek');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Wladymir', 'czlowiek');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Szczekacz', 'pies');
INSERT INTO Wrogowie(pseudonim_wroga, gatunek) VALUES ('Dobromir', 'czlowiek');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('jablko');
INSERT INTO Gratyfikacje(gratyfikacja) VALUES('wino');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Hiacynt', 'jablko');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Tekla', 'wino');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Wladymir', 'bimber');
INSERT INTO Lapowki_wrogow(pseudo_wroga, gratyfikacja) VALUES ('Dobromir', 'krawat');
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Jerzy', 'Anka', 18, 'M', TO_DATE('06/12/2003', 'DD/MM/YYYY'), 'spawacz', 2);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Jack', 'Anka', 15, 'M', TO_DATE('29/10/1999', 'DD/MM/YYYY'), 'lapacz', 2);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Milosz', 'Beczka', 5, 'M', TO_DATE('01/09/1999', 'DD/MM/YYYY'), NULL, 2);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Agrafka', 'Konewka', 14, 'K', TO_DATE('13/06/2005', 'DD/MM/YYYY'), 'magazynier', NULL);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Wilczek', 'Konewka', 5, 'M', TO_DATE('10/03/2002', 'DD/MM/YYYY'), NULL, NULL);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Jarzebina', 'Konewka', 12, 'K', TO_DATE('14/03/2002', 'DD/MM/YYYY'), 'magazynier', 4);
INSERT INTO Koty(pseudonim, szef, przydzial_myszy, plec, wstapil, funkcja, nr_bandy) VALUES('Koralka', 'Wilczek', 14, 'K', TO_DATE('21/06/2005', 'DD/MM/YYYY'), 'wydawacz', 4);

--zad 3 - queries
--zad 3.1 - srednia masa myszy grupujac wedlug lowcy ktorzy zlapali wiecej niz jedna mysz PROSTE GRUPOWANIE
SELECT lowca, AVG(waga) FROM Myszy GROUP BY lowca HAVING COUNT(id) > 1 ORDER BY AVG(waga) DESC;
--zad 3.2 - koty ktore zarabiaja powyzej sredniej PODZAPYTANIE
SELECT pseudonim, przydzial_myszy FROM Koty WHERE przydzial_myszy > (SELECT AVG(przydzial_myszy) FROM Koty) UNION ALL SELECT 'srednia',AVG(przydzial_myszy) FROM Koty;
--zad 3.3 - wrogowie niemajacy gratyfikacji ZLACZENIE
SELECT pseudonim_wroga FROM Wrogowie FULL JOIN Lapowki_wrogow ON Wrogowie.pseudonim_wroga=Lapowki_wrogow.pseudo_wroga WHERE gratyfikacja IS NULL;
--zad 3.4 -  wyznacz wszystkich szefow PROSTE
SELECT DISTINCT szef FROM Koty WHERE szef IS NOT NULL;
--zad 3.5 znajdz myszy upolowane przez najczestszego lowce-  PODZAPYTANIE  GRUPOWANIE
SELECT id, lowca 
    FROM Myszy
    WHERE lowca = (SELECT lowca 
                   FROM (SELECT lowca, 
                         COUNT(id)"l" 
                         FROM Myszy 
                         GROUP BY lowca) 
                    WHERE "l"=(SELECT MAX(COUNT(id)) FROM Myszy GROUP BY lowca));
--zad 3.6 ile jest mezczyzn PROSTE
SELECT COUNT(pseudonim) FROM Koty WHERE plec='M';
--zad 3.7 znajdz koty ktore dolaczyly przed puszkiem- PODZAPYTANIE
SELECT pseudonim, wstapil FROM Koty WHERE wstapil < (SELECT wstapil FROM Koty WHERE pseudonim='Puszek');
--zad 3.8 znajdz funckcje ktore nie sa wykonywane przez nikogo - ZLACZENIE
SELECT nazwa FROM Funkcje FULL JOIN Koty ON Funkcje.nazwa=Koty.funkcja WHERE pseudonim IS NULL;
--zad 3.9 wypisz liczbe czlonkow band - ZLACZENIE GRUPOWANIE
SELECT COUNT(*), nazwa FROM Bandy JOIN Koty ON numer=nr_bandy GROUP BY nazwa;
--zad 3.10 ktore koty nie uczestniczyly w incydentach
SELECT pseudonim FROM Koty WHERE pseudonim NOT IN (SELECT pseudonim FROM Incydenty);
--zad 3.11 ktore gratyfikacje nie sa przyjmowane przez zadnego wroga
SELECT Gratyfikacje.gratyfikacja FROM Gratyfikacje FULL JOIN Lapowki_wrogow ON Gratyfikacje.gratyfikacja=Lapowki_wrogow.gratyfikacja WHERE pseudo_wroga IS NULL;
