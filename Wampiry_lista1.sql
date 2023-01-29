CREATE TABLE Wampiry(
    pseudo_wampira varchar(15) CONSTRAINT wamp_pk PRIMARY KEY, 
    wampir_w_rodzinie date CONSTRAINT wamp_rodz NOT NULL,
    plec_wampira char(1) CONSTRAINT wamp_plec NOT NULL
                 CONSTRAINT wamp_plec_km CHECK (plec_wampira IN ('K','M')),
    pseudo_szefa varchar(15) CONSTRAINT wamp_fk REFERENCES Wampiry(pseudo_wampira)
    );
    
CREATE TABLE Zlecenia(
    nr_zlecenia NUMBER(6) CONSTRAINT zl_pk PRIMARY KEY
                          CONSTRAINT zl_pk_val CHECK(nr_zlecenia>0),
    data_zlecenia date CONSTRAINT zl_dat NOT NULL,
    pseudo_wampira varchar(15) CONSTRAINT zl_ps REFERENCES Wampiry(pseudo_wampira)
    );
    
CREATE TABLE Dawcy(
    pseudo_dawcy varchar(15) CONSTRAINT daw_pk PRIMARY KEY,
    rocznik_dawcy NUMBER(4) CONSTRAINT daw_rd NOT NULL,
    plec_dawcy char(1) CONSTRAINT daw_pd NOT NULL
                 CONSTRAINT daw_pd2 CHECK(plec_dawcy IN ('K','M')),
    grupa_krwi varchar(2) CONSTRAINT daw_gk NOT NULL
                          CONSTRAINT daw_gk2 CHECK(grupa_krwi IN ('0','A','B','AB'))
    );

CREATE TABLE Donacje(
    nr_zlecenia number(6) CONSTRAINT don_fk REFERENCES Zlecenia(nr_zlecenia),
    pseudo_dawcy varchar(15) CONSTRAINT don_fk2 REFERENCES Dawcy(pseudo_dawcy),
    data_oddania date CONSTRAINT don_dat NOT NULL,
    ilosc_krwi number(3) CONSTRAINT don_kr CHECK(ilosc_krwi>0),
    pseudo_wampira varchar(15) CONSTRAINT don_pw REFERENCES Wampiry(pseudo_wampira),
    data_wydania date,
    CONSTRAINT don_wyd CHECK(data_wydania>=data_oddania),
    CONSTRAINT don_pk PRIMARY KEY(nr_zlecenia, pseudo_dawcy)
    );

CREATE TABLE Sprawnosci(
    sprawnosc varchar(15) CONSTRAINT spr_spr PRIMARY KEY
    );
    
CREATE TABLE Sprawnosci_w(
    pseudo_wampira varchar(15) CONSTRAINT sprw_fk REFERENCES Wampiry(pseudo_wampira),
    sprawnosc varchar(20) CONSTRAINT sprw_fk2 REFERENCES Sprawnosci(sprawnosc),
    sprawnosc_od date CONSTRAINT sprw_dat NOT NULL,
    CONSTRAINT sprw_pk PRIMARY KEY(pseudo_wampira, sprawnosc)
    );
    
CREATE TABLE Jezyki_obce(
    jezyk_obcy varchar(20) CONSTRAINT jo_pk PRIMARY KEY
    );
    
CREATE TABLE Jezyki_obce_w(
    pseudo_wampira varchar(15) CONSTRAINT jzw_fk REFERENCES Wampiry(pseudo_wampira),
    jezyk_obcy varchar(20) CONSTRAINT jzw_fk2 REFERENCES Jezyki_obce(jezyk_obcy),
    jezyk_obcy_od date CONSTRAINT jzw_dat NOT NULL,
    CONSTRAINT jzw_pk PRIMARY KEY(pseudo_wampira, jezyk_obcy)
    ); 

INSERT INTO Wampiry 
VALUES('Drakula','12.12.2017','M',NULL);
INSERT INTO Wampiry VALUES
('Opoj','07.11.1777','M','Drakula');
INSERT INTO Wampiry VALUES
('Wicek','11.11.1721','M','Drakula');
INSERT INTO Wampiry VALUES
('Baczek','13.04.1855','M','Opoj');
INSERT INTO Wampiry VALUES
('Bolek','31.05.1945','M','Opoj');
INSERT INTO Wampiry VALUES
('Gacek','21.02.1891','M','Wicek');
INSERT INTO Wampiry VALUES
('Pijawka','03.11.1901','K','Wicek');
INSERT INTO Wampiry VALUES
('Czerwony','13.09.1823','M','Wicek');
INSERT INTO Wampiry VALUES
('Komar','23.07.1911','M','Wicek');
INSERT INTO Wampiry VALUES
('Zyleta','23.09.1911','K','Opoj');
INSERT INTO Wampiry VALUES
('Predka','29.03.1877','K','Drakula');

INSERT INTO Zlecenia Values
(221,'04.07.2005','Opoj');
INSERT INTO Zlecenia VALUES
(222,'04.07.2005','Baczek');
INSERT INTO Zlecenia VALUES
(223,'17.07.2005','Bolek');
INSERT INTO Zlecenia VALUES
(224,'22.07.2005','Opoj');
INSERT INTO Zlecenia VALUES
(225,'01.08.2005','Pijawka');
INSERT INTO Zlecenia VALUES
(226,'07.08.2005','Gacek');

INSERT INTO Dawcy VALUES
('Slodka',1966,'K','AB');
INSERT INTO Dawcy VALUES
('Miodzio',1983,'M','B');
INSERT INTO Dawcy VALUES
('Gorzka',1958,'K','0');
INSERT INTO Dawcy VALUES
('Lolita',1987,'K','0');
INSERT INTO Dawcy VALUES
('Wytrawny',1971,'M','A');
INSERT INTO Dawcy VALUES
('Okocim',1966,'M','B');
INSERT INTO Dawcy VALUES
('Adonis',1977,'M','AB');
INSERT INTO Dawcy VALUES
('Zywiec',1969,'M','A');
INSERT INTO Dawcy VALUES
('Eliksir',1977,'M','0');
INSERT INTO Dawcy VALUES
('Zenek',1959,'M','B');
INSERT INTO Dawcy VALUES
('Zoska',1963,'K','0');
INSERT INTO Dawcy VALUES
('Czerwonka',1953,'M','A');

INSERT INTO Donacje VALUES
(221,'Slodka','04.07.2005',455,'Drakula','06.08.2005');
INSERT INTO Donacje VALUES
(221,'Miodzio','04.07.2005',680,'Gacek','15.08.2005');
INSERT INTO Donacje VALUES
(221,'Gorzka','05.07.2005',471,'Pijawka','11.08.2005');
INSERT INTO Donacje VALUES
(221,'Lolita','05.07.2005',340,'Czerwony','21.08.2005');
INSERT INTO Donacje VALUES
(222,'Wytrawny','07.07.2005',703,'Drakula','17.07.2005');
INSERT INTO Donacje VALUES
(222,'Okocim','07.07.2005',530,'Komar','01.09.2005');
INSERT INTO Donacje VALUES
(222,'Adonis','08.07.2005',221,'Zyleta','11.09.2005');
INSERT INTO Donacje VALUES
(223,'Zywiec','17.07.2005',587,'Wicek','18.09.2005');
INSERT INTO Donacje VALUES
(224,'Gorzka','22.07.2005',421,'Drakula','23.08.2005');
INSERT INTO Donacje VALUES
(224,'Eliksir','25.07.2005',377,'Predka','26.07.2005');
INSERT INTO Donacje VALUES
(225,'Zenek','04.08.2005',600,'Opoj','15.08.2005');
INSERT INTO Donacje VALUES
(225,'Zoska','06.08.2005',450,NULL,NULL);
INSERT INTO Donacje VALUES
(226,'Czerwonka','10.08.2005',517,'Pijawka','30.09.2005');
INSERT INTO Donacje VALUES
(226,'Miodzio','11.08.2005',644,NULL,NULL);

INSERT INTO Sprawnosci VALUES
('podryw');
INSERT INTO Sprawnosci VALUES
('gorzala');
INSERT INTO Sprawnosci VALUES
('kasa');
INSERT INTO Sprawnosci VALUES
('przymus');
INSERT INTO Sprawnosci VALUES
('niesmiertelnosc');

INSERT INTO Sprawnosci_w VALUES
('Drakula','podryw','12.12.1217');
INSERT INTO Sprawnosci_w VALUES
('Drakula','gorzala','12.12.1217');
INSERT INTO Sprawnosci_w VALUES
('Wicek','kasa','11.11.1721');
INSERT INTO Sprawnosci_w VALUES
('Wicek','przymus','07.01.1771');
INSERT INTO Sprawnosci_w VALUES
('Opoj','podryw','07.11.1777');
INSERT INTO Sprawnosci_w VALUES
('Czerwony','niesmiertelnosc','13.09.1823');
INSERT INTO Sprawnosci_w VALUES
('Drakula','kasa','13.09.1823');
INSERT INTO Sprawnosci_w VALUES
('Opoj','gorzala','11.12.1844');
INSERT INTO Sprawnosci_w VALUES
('Baczek','gorzala','13.04.1855');
INSERT INTO Sprawnosci_w VALUES
('Drakula','przymus','14.06.1857');
INSERT INTO Sprawnosci_w VALUES
('Drakula','niesmiertelnosc','21.08.1858');
INSERT INTO Sprawnosci_w VALUES
('Opoj','przymus','15.07.1861');
INSERT INTO Sprawnosci_w VALUES
('Wicek','gorzala','19.01.1866');
INSERT INTO Sprawnosci_w VALUES
('Predka','podryw','29.03.1877');
INSERT INTO Sprawnosci_w VALUES
('Czerwony','kasa','03.02.1891');
INSERT INTO Sprawnosci_w VALUES
('Gacek','kasa','21.02.1891');
INSERT INTO Sprawnosci_w VALUES
('Pijawka','podryw','03.11.1901');
INSERT INTO Sprawnosci_w VALUES
('Komar','gorzala','23.07.1911');
INSERT INTO Sprawnosci_w VALUES
('Zyleta','przymus','23.09.1911');
INSERT INTO Sprawnosci_w VALUES
('Bolek','gorzala','31.05.1945');

INSERT INTO Jezyki_obce VALUES
('niemiecki');
INSERT INTO Jezyki_obce VALUES
('wegierski');
INSERT INTO Jezyki_obce VALUES
('bulgarski');
INSERT INTO Jezyki_obce VALUES
('rosyjski');
INSERT INTO Jezyki_obce VALUES
('portugalski');
INSERT INTO Jezyki_obce VALUES
('francuski');
INSERT INTO Jezyki_obce VALUES
('angielski');
INSERT INTO Jezyki_obce VALUES
('polski');
INSERT INTO Jezyki_obce VALUES
('hiszpanski');
INSERT INTO Jezyki_obce VALUES
('czeski');
INSERT INTO Jezyki_obce VALUES
('wloski');
INSERT INTO Jezyki_obce VALUES
('szwedzki');

INSERT INTO Jezyki_obce_w VALUES
('Drakula','niemiecki','12.12.1217');
INSERT INTO Jezyki_obce_w VALUES
('Drakula','wegierski','12.12.1217');
INSERT INTO Jezyki_obce_w VALUES
('Drakula','bulgarski','03.04.1455');
INSERT INTO Jezyki_obce_w VALUES
('Wicek','rosyjski','11.11.1721');
INSERT INTO Jezyki_obce_w VALUES
('Opoj','portugalski','07.11.1777');
INSERT INTO Jezyki_obce_w VALUES
('Czerwony','francuski','13.09.1823');
INSERT INTO Jezyki_obce_w VALUES
('Drakula','angielski','13.09.1823');
INSERT INTO Jezyki_obce_w VALUES
('Wicek','polski','18.08.1835');
INSERT INTO Jezyki_obce_w VALUES
('Opoj','hiszpanski','12.03.1851');
INSERT INTO Jezyki_obce_w VALUES
('Baczek','czeski','13.04.1855');
INSERT INTO Jezyki_obce_w VALUES
('Wicek','niemiecki','11.06.1869');
INSERT INTO Jezyki_obce_w VALUES
('Wicek','wloski','14.03.1873');
INSERT INTO Jezyki_obce_w VALUES
('Predka','czeski','29.03.1877');
INSERT INTO Jezyki_obce_w VALUES
('Opoj','polski','13.09.1883');
INSERT INTO Jezyki_obce_w VALUES
('Czerwony','rosyjski','23.11.1888');
INSERT INTO Jezyki_obce_w VALUES
('Gacek','polski','21.02.1891');
INSERT INTO Jezyki_obce_w VALUES
('Predka','niemiecki','07.06.1894');
INSERT INTO Jezyki_obce_w VALUES
('Baczek','angielski','04.12.1899');
INSERT INTO Jezyki_obce_w VALUES
('Pijawka','angielski','03.11.1901');
INSERT INTO Jezyki_obce_w VALUES
('Komar','szwedzki','23.07.1911');
INSERT INTO Jezyki_obce_w VALUES
('Zyleta','angielski','23.09.1911');
INSERT INTO Jezyki_obce_w VALUES
('Bolek','francuski','31.05.1945');




    
