-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 30 août 2024 à 12:08
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_evenements`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `getEventsByIdUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEventsByIdUser` (IN `userId` INT)   BEGIN
SELECT 
e.idEvenement AS id,
e.titreEvenement,
lieu.libelle_lieu,
organisateur.nomOrganisateur,
participer.idUser,
(nbPlacesEvenement - (SELECT COUNT(*) FROM participer WHERE participer.idEvenement=id)) as nbPlacesDispo
 FROM evenement e
JOIN lieu ON e.id_lieu=lieu.id_lieu
JOIN organisateur ON e.idOrganisateur=organisateur.idOrganisateur
LEFT JOIN participer ON e.idEvenement=participer.idEvenement AND participer.idUser=userId;
END$$

DROP PROCEDURE IF EXISTS `test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `test` ()   BEGIN
SELECT e.idEvenement FROM evenement e
JOIN lieu ON e.id_lieu=lieu.id_lieu
JOIN organisateur ON e.idOrganisateur=organisateur.idOrganisateur
LEFT JOIN participer ON e.idEvenement=participer.idEvenement AND participer.idUser=2;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

DROP TABLE IF EXISTS `evenement`;
CREATE TABLE IF NOT EXISTS `evenement` (
  `idEvenement` int NOT NULL AUTO_INCREMENT,
  `titreEvenement` varchar(255) NOT NULL,
  `dateEvenement` date NOT NULL,
  `descriptionEvenement` text NOT NULL,
  `imageEvenement` varchar(255) NOT NULL,
  `nbPlacesEvenement` int NOT NULL,
  `idOrganisateur` int NOT NULL,
  `id_lieu` int NOT NULL,
  PRIMARY KEY (`idEvenement`),
  KEY `Evenement_Organisateur_FK` (`idOrganisateur`),
  KEY `Evenement_Lieu0_FK` (`id_lieu`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `evenement`
--

INSERT INTO `evenement` (`idEvenement`, `titreEvenement`, `dateEvenement`, `descriptionEvenement`, `imageEvenement`, `nbPlacesEvenement`, `idOrganisateur`, `id_lieu`) VALUES
(2, 'Concert Blues. Blues 64.', '2024-08-31', 'Un concert de blues.', '', 1500, 2, 1),
(3, 'Les idées mènent le monde', '2024-11-22', 'Echanges philosophiques', '', 500, 3, 2),
(4, 'pas d\'inscrit', '2024-08-30', 'personne', '', 0, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `lieu`
--

DROP TABLE IF EXISTS `lieu`;
CREATE TABLE IF NOT EXISTS `lieu` (
  `id_lieu` int NOT NULL AUTO_INCREMENT,
  `libelle_lieu` varchar(255) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `capacite` int NOT NULL,
  PRIMARY KEY (`id_lieu`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `lieu`
--

INSERT INTO `lieu` (`id_lieu`, `libelle_lieu`, `latitude`, `longitude`, `capacite`) VALUES
(1, 'Zenith', 43, 0, 2000),
(2, 'Palais Beaumont', 43, 0, 200);

-- --------------------------------------------------------

--
-- Structure de la table `organisateur`
--

DROP TABLE IF EXISTS `organisateur`;
CREATE TABLE IF NOT EXISTS `organisateur` (
  `idOrganisateur` int NOT NULL AUTO_INCREMENT,
  `nomOrganisateur` varchar(255) NOT NULL,
  PRIMARY KEY (`idOrganisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `organisateur`
--

INSERT INTO `organisateur` (`idOrganisateur`, `nomOrganisateur`) VALUES
(1, 'Helioparc'),
(2, 'Ampli'),
(3, 'Pau Agglo');

-- --------------------------------------------------------

--
-- Structure de la table `participer`
--

DROP TABLE IF EXISTS `participer`;
CREATE TABLE IF NOT EXISTS `participer` (
  `idUser` int NOT NULL,
  `idEvenement` int NOT NULL,
  PRIMARY KEY (`idUser`,`idEvenement`),
  KEY `participer_Evenement0_FK` (`idEvenement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `participer`
--

INSERT INTO `participer` (`idUser`, `idEvenement`) VALUES
(1, 2),
(2, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `test`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `test`;
CREATE TABLE IF NOT EXISTS `test` (
`idEvenement` int
,`titreEvenement` varchar(255)
,`nomOrganisateur` varchar(255)
,`libelle_lieu` varchar(255)
,`idUser` int
);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `emailUser` varchar(255) NOT NULL,
  `mdpUser` varchar(255) NOT NULL,
  `nomUser` varchar(255) NOT NULL,
  `prenomUser` varchar(255) NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`idUser`, `emailUser`, `mdpUser`, `nomUser`, `prenomUser`) VALUES
(1, 'toto@toto.fr', 'sfgds', 'TOTO', 'Toto'),
(2, 'tata@tata.fr', 'dfgsd', 'TATA', 'Tata');

-- --------------------------------------------------------

--
-- Structure de la vue `test`
--
DROP TABLE IF EXISTS `test`;

DROP VIEW IF EXISTS `test`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `test`  AS SELECT `e`.`idEvenement` AS `idEvenement`, `e`.`titreEvenement` AS `titreEvenement`, `organisateur`.`nomOrganisateur` AS `nomOrganisateur`, `lieu`.`libelle_lieu` AS `libelle_lieu`, `participer`.`idUser` AS `idUser` FROM (((`evenement` `e` join `lieu` on((`e`.`id_lieu` = `lieu`.`id_lieu`))) join `organisateur` on((`e`.`idOrganisateur` = `organisateur`.`idOrganisateur`))) left join `participer` on(((`e`.`idEvenement` = `participer`.`idEvenement`) and (`participer`.`idUser` = 2)))) ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `Evenement_Lieu0_FK` FOREIGN KEY (`id_lieu`) REFERENCES `lieu` (`id_lieu`),
  ADD CONSTRAINT `Evenement_Organisateur_FK` FOREIGN KEY (`idOrganisateur`) REFERENCES `organisateur` (`idOrganisateur`);

--
-- Contraintes pour la table `participer`
--
ALTER TABLE `participer`
  ADD CONSTRAINT `participer_Evenement0_FK` FOREIGN KEY (`idEvenement`) REFERENCES `evenement` (`idEvenement`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `participer_User_FK` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
