-- phpMyAdmin SQL Dump
-- version 4.2.13.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas generowania: 27 Mar 2018, 12:39
-- Wersja serwera: 5.5.50-MariaDB
-- Wersja PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `pz2017_10`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`pz2017_10`@`localhost` PROCEDURE `sp_createUser`(IN `p_login` VARCHAR(20), IN `p_email` VARCHAR(20), IN `p_haslo` VARCHAR(20))
BEGIN
    if ( select exists (select 1 from gracze where login = p_login) ) THEN
     
        select 'Uzytkownik Istnieje !!';
     
    ELSE
     
        insert into gracze
        (
            login,
            email,
            haslo
        )
        values
        (
            p_login,
            p_email,
            p_haslo
        );
     
    END IF;
END$$

CREATE DEFINER=`pz2017_10`@`localhost` PROCEDURE `sp_getMecz`(IN `p_login` VARCHAR(45))
    NO SQL
BEGIN
	select * from mecze where gracz1_id=p_login or gracz2_id=p_login;
END$$

CREATE DEFINER=`pz2017_10`@`localhost` PROCEDURE `sp_getPunkty`(IN `p_mecze_id` INT)
    NO SQL
BEGIN
	select * from punkty where mecze_id=p_mecze_id;
END$$

CREATE DEFINER=`pz2017_10`@`localhost` PROCEDURE `sp_validateLogin`(IN `p_login` VARCHAR(20))
BEGIN
    select * from gracze where login = p_login;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `gracze`
--

CREATE TABLE IF NOT EXISTS `gracze` (
  `login` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `haslo` varchar(200) COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `gracze`
--

INSERT INTO `gracze` (`login`, `email`, `haslo`) VALUES
('test1', 'test1@gmail.com', 'test1'),
('test2', 'test2@gmail.com', 'test2'),
('test2424', 'test23323@gmail.com', 'test2test');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mecze`
--

CREATE TABLE IF NOT EXISTS `mecze` (
`mecze_id` int(11) unsigned NOT NULL,
  `turnieje_id` int(11) unsigned DEFAULT NULL,
  `gracz1_id` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `gracz2_id` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `data` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `mecze`
--

INSERT INTO `mecze` (`mecze_id`, `turnieje_id`, `gracz1_id`, `gracz2_id`, `data`) VALUES
(1, NULL, 'test1', 'test2', '2018-03-20'),
(3, NULL, 'test1', 'test2', '0000-00-00'),
(4, NULL, 'test1', 'test2', '2018-03-20');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `punkty`
--

CREATE TABLE IF NOT EXISTS `punkty` (
  `numer_setu` int(11) NOT NULL,
  `punkt` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `mecze_id` int(11) unsigned NOT NULL,
`punkty_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `punkty`
--

INSERT INTO `punkty` (`numer_setu`, `punkt`, `mecze_id`, `punkty_id`) VALUES
(1, 'test1', 1, 1),
(1, 'test1', 1, 2),
(1, 'test1', 1, 3),
(1, 'test2', 1, 4),
(1, 'test1', 1, 5),
(1, 'test2', 1, 6),
(1, 'test1', 1, 7),
(1, 'test2', 1, 8),
(1, 'test1', 1, 9),
(1, 'test1', 1, 10),
(2, 'test1', 1, 11),
(2, 'test2', 1, 12),
(2, 'test2', 1, 13),
(2, 'test1', 1, 14),
(2, 'test1', 1, 15),
(2, 'test1', 1, 16),
(2, 'test1', 1, 17),
(2, 'test1', 1, 18),
(2, 'test2', 1, 19),
(2, 'test1', 1, 20),
(1, 'test1', 3, 21);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `turnieje`
--

CREATE TABLE IF NOT EXISTS `turnieje` (
`turnieje_id` int(11) unsigned NOT NULL,
  `do_ilu_punkty` int(2) NOT NULL DEFAULT '11',
  `do_ilu_sety` int(1) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `gracze`
--
ALTER TABLE `gracze`
 ADD PRIMARY KEY (`login`);

--
-- Indexes for table `mecze`
--
ALTER TABLE `mecze`
 ADD PRIMARY KEY (`mecze_id`), ADD UNIQUE KEY `turnieje_id` (`turnieje_id`), ADD KEY `gracz1_id` (`gracz1_id`), ADD KEY `gracz2_id` (`gracz2_id`);

--
-- Indexes for table `punkty`
--
ALTER TABLE `punkty`
 ADD PRIMARY KEY (`punkty_id`,`mecze_id`), ADD KEY `punkty_mecze_fk` (`mecze_id`), ADD KEY `punkty_gracze_fk` (`punkt`);

--
-- Indexes for table `turnieje`
--
ALTER TABLE `turnieje`
 ADD PRIMARY KEY (`turnieje_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `mecze`
--
ALTER TABLE `mecze`
MODIFY `mecze_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT dla tabeli `punkty`
--
ALTER TABLE `punkty`
MODIFY `punkty_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT dla tabeli `turnieje`
--
ALTER TABLE `turnieje`
MODIFY `turnieje_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `mecze`
--
ALTER TABLE `mecze`
ADD CONSTRAINT `mecze_gracze_fk` FOREIGN KEY (`gracz1_id`) REFERENCES `gracze` (`login`),
ADD CONSTRAINT `mecze_gracze_fk2` FOREIGN KEY (`gracz2_id`) REFERENCES `gracze` (`login`),
ADD CONSTRAINT `mecze_turnieje_fk` FOREIGN KEY (`turnieje_id`) REFERENCES `turnieje` (`turnieje_id`);

--
-- Ograniczenia dla tabeli `punkty`
--
ALTER TABLE `punkty`
ADD CONSTRAINT `punkty_gracze_fk` FOREIGN KEY (`punkt`) REFERENCES `gracze` (`login`),
ADD CONSTRAINT `punkty_mecze_fk` FOREIGN KEY (`mecze_id`) REFERENCES `mecze` (`mecze_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
