SELECT pseudo_dawcy"Dawca A", rocznik_dawcy"Rocznik" FROM Dawcy WHERE grupa_krwi='A';
SELECT DISTINCT pseudo_dawcy"Dawca" FROM Donacje WHERE data_oddania BETWEEN '20.07.2005' AND '20.08.2005';
SELECT pseudo_dawcy"Dawca", plec_dawcy"Plec" FROM Dawcy WHERE rocznik_dawcy IN ('1977','1971');
SELECT DISTINCT pseudo_dawcy"Dawca" FROM Donacje WHERE MONTHS_BETWEEN('17.05.2006', data_wydania) >= 10;
SELECT pseudo_dawcy"Dawca", ilosc_krwi"Donacja", NVL(TO_CHAR(data_wydania),'Na stanie')"Wydano" FROM Donacje WHERE data_oddania > '10.07.2005';
SELECT COUNT(DISTINCT sprawnosc)"Liczba sprawnosci" FROM Sprawnosci_w WHERE pseudo_wampira IN ('Opoj','Czerwony');
SELECT SUM(ilosc_krwi)"Cieple buleczki" FROM Donacje WHERE data_wydania - data_oddania <= 10;
SELECT pseudo_wampira"Wampir", COUNT(jezyk_obcy_od)"liczba jezykow" FROM Jezyki_obce_w WHERE jezyk_obcy != 'rosyjski' GROUP BY pseudo_wampira; #czy mo¿na dowolny atrybut do counta? - TAK, bo dla ka¿dego jêzyka jest 1 rekord (unikalny)
SELECT pseudo_wampira"Wampir", COUNT(data_oddania)"Liczba konsumpcji" FROM Donacje WHERE pseudo_wampira IS NOT NULL HAVING COUNT(data_oddania) > 1 GROUP BY pseudo_wampira;
SELECT grupa_krwi"Grupa", plec_dawcy"Plec", COUNT(pseudo_dawcy)"Liczba dawcow" FROM Dawcy GROUP BY plec_dawcy,grupa_krwi ORDER BY grupa_krwi ASC; #czy mo¿na zmieniæ kolejnoœæ grupowania - TAK, bo w gruopowaniu kolejnoœæ nie ma znaczenia