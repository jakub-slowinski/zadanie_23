-- CREATE SCHEMA `zadanie_23` ;
-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE pracownik (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    wyplata DECIMAL(10,2),
    data_urodzenia DATE,
    stanowisko VARCHAR(50)
);
-- 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO pracownik(imie, nazwisko, wyplata, data_urodzenia, stanowisko)
VALUES ('Marcin', 'Giętki', 67000, '1980-06-13', 'dyrektor'),
('Krystyna', 'Malinowska', 40000, '1981-02-02', 'prezes'),
('Tomasz', 'Siwy', 12000, '1980-04-22', 'szef zmiany'),
('Józef', 'Malinowski', 7000, '1978-12-30', 'sekretarz'),
('Oskar', 'Pietrucha', 6000, '1998-08-05', 'fotograf'),
('Bartosz', 'Warzyński', 6500, '1998-08-05', 'pisarz'),
('Andrzej', 'Samograj', 5800, '1985-09-27', 'technik');
-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM pracownik ORDER BY nazwisko ASC;
-- 4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM pracownik WHERE stanowisko = 'dyrektor';
-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM pracownik WHERE EXTRACT(YEAR FROM CURDATE()) - EXTRACT(YEAR FROM data_urodzenia) > 30;
-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE pracownik SET wyplata = (wyplata * 1.1) WHERE stanowisko = 'fotograf';
-- 7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)
SELECT * FROM pracownik
WHERE data_urodzenia = (SELECT MAX(data_urodzenia) FROM pracownik);
-- 8. Usuwa tabelę pracownik
DROP TABLE zadanie_23.pracownik;
-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE stanowisko (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(50),
    opis VARCHAR(50),
    wyplata DECIMAL(10,2)
);
-- 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE adres (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ulica_numery VARCHAR(80),
    kod VARCHAR(6),
    miejscowosc VARCHAR(50)
);
-- 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE pracownik (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    nazwa_stanowiska BIGINT NOT NULL,
    opis_stanowiska BIGINT NOT NULL,
    wyplata BIGINT NOT NULL,
    adres_ulica BIGINT NOT NULL,
    adres_kod BIGINT NOT NULL,
    adres_miejscowosc BIGINT NOT NULL,
    FOREIGN KEY (nazwa_stanowiska) REFERENCES stanowisko (id),
    FOREIGN KEY (opis_stanowiska) REFERENCES stanowisko (id),
    FOREIGN KEY (wyplata) REFERENCES stanowisko (id),
    FOREIGN KEY (adres_ulica) REFERENCES adres (id),
    FOREIGN KEY (adres_kod) REFERENCES adres (id),
    FOREIGN KEY (adres_miejscowosc) REFERENCES adres (id)
);
-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO adres (ulica_numery, kod, miejscowosc)
VALUES
	('Jeczmienna 30/4', '50-370', 'Wroclaw'),
    ('Orzechowa 24/12', '12-587', 'Krakow'),
    ('Brzozowa 5/4', '32-365', 'Opole'),
    ('Kolarzy 32/1', '32-365', 'Opole'),
    ('Bramkarzy 122/33', '50-540', 'Gdansk'),
    ('Niepodleglosci 1/3', '22-658', 'Radom'),
    ('Balonowa 3/21', '16-158', 'Grudziadz'),
    ('Stalowa 54/7', '38-559', 'Sieradz');
    
INSERT INTO stanowisko 
	(nazwa, opis, wyplata)
VALUES
	('dyrektor', 'dyrektor generalny', 70000),
    ('sekretarz', 'wysyla maile i parzy kawe', 15000),
    ('szef zmiany', 'zarzadza ludzmi na zmianie', 26600),
    ('fotograf', 'robi zdjecia', 7500),
    ('pisarz', 'pisze teksty', 6800),
    ('technik', 'ogarnia technikalia', 8000),
    ('grafik', 'przerabia grafike i zdjecia', 7600),
    ('starszy grafik', 'tworzy szate wydania', 12400);
    
INSERT INTO pracownik 
	(imie, nazwisko,nazwa_stanowiska, opis_stanowiska, wyplata, adres_ulica, adres_kod, adres_miejscowosc)
VALUES
	('Janek', 'Kozioł', 1, 2, 3, 4, 5, 6),
    ('Marta', 'Rycerz', 2, 3, 4, 5, 6, 1),
    ('Robert', 'Zawada', 3, 4, 5, 6, 1, 2),
    ('Jolanta', 'Topacz', 4, 5, 6, 1, 2, 3),
    ('Krzysztof', 'Woda', 5, 6, 1, 2, 3, 4),
    ('Józek', 'Rączka', 6, 1, 2, 3, 4, 5),
    ('Marcin', 'Szopa', 3, 4, 7, 8, 3, 4),
    ('Kinga', 'Głowala', 5, 6, 5, 3, 2, 7);
    
-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT p.imie, p.nazwisko, p.adres_ulica, p.adres_kod, p.adres_miejscowosc, p.nazwa_stanowiska FROM pracownik AS p;
-- 14. Oblicza sumę wypłat dla wszystkich pracownikow w firmie
SELECT SUM(wyplata) AS sum_wyplata FROM pracownik 