SELECT DISTINCT nr_zlecenia"Zlecenia AB" --zad 1
    FROM Donacje
    JOIN Dawcy USING(pseudo_dawcy)
    WHERE grupa_krwi='AB' and data_wydania IS NOT NULL;
    
SELECT W1.pseudo_wampira"PSEUDO WAMPIRA",W1.plec_wampira"PLEC",NVL(W1.pseudo_szefa, ' ')"PSEUDO SZEFA", NVL(W2.plec_wampira,' ')"PLEC SZEFA" /*zad 2*/
    FROM Wampiry W1 LEFT JOIN Wampiry W2 ON W1.pseudo_szefa=W2.pseudo_wampira;
    
SELECT pseudo_dawcy"Dawca przed Slodka", plec_dawcy"Plec" --zad 3
    FROM Dawcy
    WHERE rocznik_dawcy < (SELECT rocznik_dawcy FROM Dawcy WHERE pseudo_dawcy = 'Slodka');
    
SELECT pseudo_dawcy"Pseudonim", 'Ponizej 700'"Pobor" --zad 4 OK
    FROM Donacje
    GROUP BY pseudo_dawcy
    HAVING SUM(ilosc_krwi) < 700
UNION ALL
SELECT pseudo_dawcy"Pseudonim", 'Miedzy 700 a 1000'"Pobor" 
    FROM Donacje
    GROUP BY pseudo_dawcy
    HAVING SUM(ilosc_krwi) >= 700 AND SUM(ilosc_krwi) <= 1000
UNION ALL
SELECT pseudo_dawcy"Pseudonim", 'Powyzej 1000'"Pobor"
    FROM Donacje
    GROUP BY pseudo_dawcy
    HAVING SUM(ilosc_krwi) > 1000;
    
SELECT pseudo_wampira"Wampir", COUNT(DISTINCT sprawnosc)"Liczba" --zad 5
    FROM Jezyki_obce_w NATURAL JOIN Sprawnosci_w
    GROUP BY pseudo_wampira
    HAVING COUNT(DISTINCT sprawnosc) = COUNT(DISTINCT jezyk_obcy);
    
SELECT DISTINCT nr_zlecenia"Zlecenie AB", data_zlecenia"Data wkonania" --zad 6
    FROM Donacje JOIN Zlecenia USING(nr_zlecenia) JOIN Dawcy USING(pseudo_dawcy)
    WHERE grupa_krwi = 'AB';
    
SELECT plec_wampira"Plec", COUNT(*)"Liczba lingwistow" --zad 7
    FROM (SELECT pseudo_wampira, plec_wampira
          FROM Wampiry JOIN Jezyki_obce_w USING(pseudo_wampira)
          GROUP BY pseudo_wampira, plec_wampira
          HAVING COUNT(jezyk_obcy) >= 2)
    GROUP BY plec_wampira;
    
SELECT ilosc_krwi"Objetosc", pseudo_dawcy"Dawca" --zad 8.1 dla kazdej objetosci znalezc liczbe objetosci wiekszych od aktualnej; zrobic skorelowanie
    FROM Donacje D
    WHERE (SELECT COUNT(DISTINCT ilosc_krwi) FROM Donacje WHERE ilosc_krwi > D.ilosc_krwi) < 3
    ORDER BY ilosc_krwi DESC;
    
SELECT D1.ilosc_krwi"Objetosc", D1.pseudo_dawcy"Dawca" --zad 8.2 fetch zwraca krotki i moze tez powtorzenia; wskazowka - cos z having; to samo wyzej
    FROM Donacje D1 JOIN Donacje D2 ON D1.ilosc_krwi<=D2.ilosc_krwi
    GROUP BY D1.pseudo_dawcy, D1.ilosc_krwi
    HAVING (SELECT COUNT(DISTINCT ilosc_krwi) FROM Donacje WHERE ilosc_krwi > D1.ilosc_krwi) < 3
    ORDER BY D1.ilosc_krwi DESC;
    
SELECT pseudo_dawcy, grupa_krwi -- zad 9.1 ???
;
                                                                       
SELECT Da.pseudo_dawcy, Da.grupa_krwi, Z.pseudo_wampira --zad 9.2
    FROM Jezyki_obce_w J, Zlecenia Z, Donacje Do, Dawcy Da
    WHERE J.jezyk_obcy = 'polski' AND J.pseudo_wampira = Z.pseudo_wampira AND  Z.nr_zlecenia = Do.nr_zlecenia AND Da.pseudo_dawcy = Do.pseudo_dawcy;

SELECT pseudo_wampira"Wampir", EXTRACT(YEAR FROM wampir_w_rodzinie) --zad 10
    FROM Wampiry
    WHERE EXTRACT(YEAR FROM wampir_w_rodzinie) IN (SELECT EXTRACT(YEAR FROM wampir_w_rodzinie)
                                                  FROM Wampiry
                                                  GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie)
                                                  HAVING COUNT(*) > 1);
    
SELECT TO_CHAR(EXTRACT(YEAR FROM wampir_w_rodzinie))"ROK", COUNT(*)"LICZBA WSTAPIEN" --zad 11
    FROM Wampiry
    GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie)
    HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
                       FROM Wampiry 
                       GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie) 
                       HAVING COUNT(*) < (SELECT(COUNT(pseudo_wampira)/COUNT(DISTINCT EXTRACT(YEAR FROM wampir_w_rodzinie))) FROM Wampiry))
UNION ALL
SELECT 'Srednia'"ROK", COUNT(pseudo_wampira)/COUNT(DISTINCT EXTRACT(YEAR FROM wampir_w_rodzinie))"LICZBA WSTAPIEN"
    FROM Wampiry
UNION ALL
SELECT TO_CHAR(EXTRACT(YEAR FROM wampir_w_rodzinie))"ROK", COUNT(*)"LICZBA WSTAPIEN"
    FROM Wampiry
    GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie)
    HAVING COUNT(*) = (SELECT MIN(COUNT(*)) 
                       FROM Wampiry 
                       GROUP BY EXTRACT(YEAR FROM wampir_w_rodzinie) 
                       HAVING COUNT(*) > (SELECT(COUNT(pseudo_wampira)/COUNT(DISTINCT EXTRACT(YEAR FROM wampir_w_rodzinie))) FROM Wampiry));
    
SELECT pseudo_dawcy"Dawczyni", grupa_krwi"Grupa krwi", (SELECT SUM(ilosc_krwi) --zad 12.a)
                                                        FROM Donacje 
                                                        WHERE D.pseudo_dawcy=pseudo_dawcy 
                                                        GROUP BY pseudo_dawcy)"W sumie oddala", (SELECT ROUND(AVG(SUM(ilosc_krwi)), 0)
                                                                                                 FROM Donacje NATURAL JOIN Dawcy WHERE D.grupa_krwi=Dawcy.grupa_krwi AND plec_dawcy = 'K'
                                                                                                 GROUP BY pseudo_dawcy)"Srednia suma w jej grupie"
    FROM Dawcy D
    WHERE plec_dawcy = 'K';
    
SELECT * --zad 12.b)
FROM (SELECT D1.pseudo_dawcy, grupa_krwi,SUM(D2.ilosc_krwi)"W sumie oddala"
      FROM Dawcy D1 JOIN Donacje D2 ON D1.pseudo_dawcy = D2.pseudo_dawcy
      WHERE plec_dawcy = 'K'
      GROUP BY D1.pseudo_dawcy, grupa_krwi) JOIN
     (SELECT ROUND(AVG("Suma indywidualna"), 0) "Srednia suma w jej grupie", grupa_krwi
      FROM (SELECT SUM(D6.ilosc_krwi) "Suma indywidualna", D5.pseudo_dawcy, grupa_krwi
            FROM Dawcy D5 JOIN Donacje D6 ON D5.pseudo_dawcy = D6.pseudo_dawcy
            WHERE plec_dawcy = 'K'
            GROUP BY D5.pseudo_dawcy, grupa_krwi)
      GROUP BY grupa_krwi) USING(grupa_krwi);

SELECT W.pseudo_wampira"Wampir", D.pseudo_dawcy"Zrodlo", (SELECT SUM(ilosc_krwi) FROM Donacje WHERE pseudo_wampira = W.pseudo_wampira AND pseudo_dawcy = D.pseudo_dawcy)"Wypil ml" --zad 13
    FROM Wampiry W JOIN Donacje D ON W.pseudo_wampira = D.pseudo_wampira
    WHERE W.pseudo_wampira NOT IN (SELECT pseudo_wampira FROM ZLECENIA WHERE W.pseudo_wampira = pseudo_wampira) AND D.pseudo_dawcy IN (SELECT pseudo_dawcy FROM Donacje JOIN Dawcy USING(pseudo_dawcy) WHERE plec_dawcy = 'K' GROUP BY pseudo_dawcy HAVING SUM(ilosc_krwi)>800)
    AND W.plec_wampira = 'M';

--zad 14

--zad 15 lepsze bylyby 3 lewe zlaczenia
SELECT *
FROM(SELECT W1.pseudo_wampira"Pseudo wampira", W1.pseudo_szefa"Pseudo szefa", TO_CHAR(W2.wampir_w_rodzinie)"W Rodzinie s", W2.pseudo_szefa"Pseudo szefa szefa", TO_CHAR(W3.wampir_w_rodzinie)"W Rodzinie ss"
     FROM Wampiry W1, Wampiry W2, Wampiry W3
     WHERE W1.plec_wampira = 'M' AND W1.pseudo_szefa = W2.pseudo_wampira AND W3.pseudo_wampira = W2.pseudo_szefa
     ORDER BY W2.wampir_w_rodzinie ASC)
UNION ALL
    SELECT pseudo_wampira"Pseudo wampira",' '"Pseudo szefa",' '"W Rodzinie s", ' '"Pseduo szefa szefa", ' '"W Rodzinie ss"
    FROM Wampiry 
    WHERE pseudo_szefa IS NULL
UNION ALL
    SELECT *
    FROM(SELECT W1.pseudo_wampira"Pseudo wampira", W1.pseudo_szefa"Pseudo szefa", TO_CHAR(W2.wampir_w_rodzinie)"W Rodzinie s", ' '"Pseduo szefa szefa",' '"W Rodzinie ss"
         FROM Wampiry W1, Wampiry W2
         WHERE W1.plec_wampira = 'M' AND W1.pseudo_szefa = W2.pseudo_wampira AND W2.pseudo_szefa IS NULL
         ORDER BY W2.wampir_w_rodzinie ASC);
         
SELECT W1.pseudo_wampira"Pseudo wampira", W1.pseudo_szefa"Pseudo szefa", W2.wampir_w_rodzinie"W rodzinie s", W2.pseudo_szefa"Pseudo szefa szefa", W3.wampir_w_rodzinie"W Rodzinie ss"
    FROM Wampiry W1 LEFT JOIN Wampiry W2 ON W1.pseudo_szefa = W2.pseudo_wampira LEFT JOIN Wampiry W3 ON W2.pseudo_szefa = W3.pseudo_wampira
    WHERE W1.plec_wampira ='M';
    
SELECT W.plec_wampira, SUM(DECODE(W.pseudo_szefa, 'Drakula', D.ilosc_krwi, 0)) "Pod Drakula", --zad 16 OK
       SUM(DECODE(W.pseudo_szefa, 'Opoj', D.ilosc_krwi, 0)) "Pod Opojem",
       SUM(DECODE(W.pseudo_szefa, 'Wicek', D.ilosc_krwi, 0)) "Pod Wickiem"
FROM Wampiry W NATURAL JOIN Donacje D
GROUP BY plec_wampira;
    
    
    