-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 10 mars 2026 à 16:37
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `geco`
--

-- --------------------------------------------------------

--
-- Structure de la table `agence`
--

CREATE TABLE `agence` (
  `ID_AGENCE` int(11) NOT NULL,
  `DESC_AGENCE` varchar(100) NOT NULL,
  `EST_ACTIVE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agence`
--

INSERT INTO `agence` (`ID_AGENCE`, `DESC_AGENCE`, `EST_ACTIVE`) VALUES
(1, 'Agence BUYENZI', 1),
(2, 'Agence KAMENGE', 1),
(3, 'Agence GITEGA', 1),
(4, 'Agence BUBANZA', 1),
(5, 'Agence MUYINGA', 1),
(6, 'Agence GISHUBI', 1),
(7, 'Agence BCM', 1),
(8, 'Agence JENDA', 1),
(9, 'Guichet Boulevard de l\'Uprona', 1),
(10, 'Guichet TORA', 1),
(11, 'Guichet RWEGURA', 1),
(12, 'Guichet COTEBU', 1),
(13, 'Guichet MURAMVYA', 1),
(14, 'Guichet NGOZI', 1),
(15, 'Agence Siège', 1);

-- --------------------------------------------------------

--
-- Structure de la table `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ci_sessions`
--

CREATE TABLE `demande_conge` (
  `ID_DEMANDE` int(11) NOT NULL,
  `ID_USER` int(11) NOT NULL,
  `ID_TYPE_CONGE` tinyint(1) NOT NULL,
  `ID_ETAPE_VALIDATION` tinyint(1) NOT NULL,
  `NOMBRE_JOURS_DEMANDE` tinyint(2) NOT NULL,
  `NOMBRE_JOURS_RESTANT` tinyint(2) NOT NULL,
  `DATE_DEBUT` date NOT NULL,
  `DATE_FIN` date NOT NULL,
  `DATE_INSERTION` datetime NOT NULL DEFAULT current_timestamp(),
  `STATUS_FINAL` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0.En attente 1. Valide 2. Refuse'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `demande_conge`
--

-- --------------------------------------------------------

--
-- Structure de la table `etape_validation`
--

CREATE TABLE `etape_validation` (
  `ID_ETAPE_VALIDATION` tinyint(1) NOT NULL,
  `DESC_ETAPE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `etape_validation`
--

INSERT INTO `etape_validation` (`ID_ETAPE_VALIDATION`, `DESC_ETAPE`) VALUES
(1, 'Initiation de la demande'),
(2, 'Validation par le supérieur hiérarchique'),
(3, 'Correction de la demande'),
(4, 'Rejeter'),
(5, 'Fin');

-- --------------------------------------------------------

--
-- Structure de la table `etape_validation_config`
--

CREATE TABLE `etape_validation_config` (
  `ID_ETAPE_VALIDATION_CONFIG` tinyint(1) NOT NULL,
  `ID_ETAPE_ACTUEL` tinyint(1) NOT NULL,
  `ID_ETAPE_SUIVANT` tinyint(1) NOT NULL,
  `IS_CORRECTION` tinyint(1) NOT NULL COMMENT '0.Pas correction 1.Correction\r\n2.Rejet'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `etape_validation_config`
--

INSERT INTO `etape_validation_config` (`ID_ETAPE_VALIDATION_CONFIG`, `ID_ETAPE_ACTUEL`, `ID_ETAPE_SUIVANT`, `IS_CORRECTION`) VALUES
(1, 1, 2, 0),
(2, 2, 5, 0),
(3, 2, 3, 1),
(4, 3, 2, 0),
(5, 2, 4, 2);

-- --------------------------------------------------------

--
-- Structure de la table `fonction_poste`
--

CREATE TABLE `fonction_poste` (
  `ID_FONCTION` int(11) NOT NULL,
  `DESC_FONCTION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `fonction_poste`
--

INSERT INTO `fonction_poste` (`ID_FONCTION`, `DESC_FONCTION`) VALUES
(1, 'Administrateur système'),
(2, 'Caissier');

-- --------------------------------------------------------

--
-- Structure de la table `historique_demande`
--

CREATE TABLE `historique_demande` (
  `HISTO_ID` int(11) NOT NULL,
  `ID_DEMANDE` int(11) NOT NULL,
  `ID_USER` int(11) NOT NULL,
  `ID_ETAPE_VALIDATION` int(11) NOT NULL,
  `OBSERVATION` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_demande`
--

-- --------------------------------------------------------

--
-- Structure de la table `type_conge`
--

CREATE TABLE `type_conge` (
  `ID_TYPE_CONGE` tinyint(1) NOT NULL,
  `DESC_TYPE_CONGE` varchar(50) NOT NULL,
  `NOMBRE_JOURS_BASE` tinyint(2) NOT NULL,
  `HAS_JOURS_BASE` tinyint(2) NOT NULL COMMENT '0.Pas de jour de base 1.Possede des jours de base',
  `EST_ACTIVE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_conge`
--

INSERT INTO `type_conge` (`ID_TYPE_CONGE`, `DESC_TYPE_CONGE`, `NOMBRE_JOURS_BASE`, `HAS_JOURS_BASE`, `EST_ACTIVE`) VALUES
(1, 'Congé annuel', 20, 1, 1),
(2, 'Congé de circonstance', 20, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `type_decision`
--

CREATE TABLE `type_decision` (
  `ID_TYPE_DECISION` tinyint(1) NOT NULL,
  `DESCR_TYPE_DECISION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_decision`
--

INSERT INTO `type_decision` (`ID_TYPE_DECISION`, `DESCR_TYPE_DECISION`) VALUES
(1, 'Accepter'),
(2, 'Retour pour correction'),
(3, 'Refuser');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `USER_ID` int(11) NOT NULL,
  `NOM_USER` varchar(50) NOT NULL,
  `PRENOM_USER` varchar(50) NOT NULL,
  `TELEPHONE` varchar(30) NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `ID_FONCTION` int(11) NOT NULL,
  `ID_AGENCE` int(11) NOT NULL,
  `USER_ID_HIERARCHI` int(11) NOT NULL,
  `PHOTO_PROFIL` varchar(100) NOT NULL,
  `EST_ACTIVE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`USER_ID`, `NOM_USER`, `PRENOM_USER`, `TELEPHONE`, `USERNAME`, `PASSWORD`, `ID_FONCTION`, `ID_AGENCE`, `USER_ID_HIERARCHI`, `PHOTO_PROFIL`, `EST_ACTIVE`) VALUES
(1, 'NDERAGAKURA', 'Alain Charbel', '62003522', 'Alain', '12345', 1, 1, 2, 'uploads/profils/689360c3c0762250806020347.jpg', 1),
(2, 'Augustin', 'NKURUNZIZA', '62003522', 'Augustin', '12345', 1, 2, 1, 'uploads/profils/689360c3c0762250806020347.jpg', 1),
(3, 'test', 'test', '252555', 'test', '1234', 2, 1, 1, '', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `agence`
--
ALTER TABLE `agence`
  ADD PRIMARY KEY (`ID_AGENCE`);

--
-- Index pour la table `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `demande_conge`
--
ALTER TABLE `demande_conge`
  ADD PRIMARY KEY (`ID_DEMANDE`);

--
-- Index pour la table `etape_validation`
--
ALTER TABLE `etape_validation`
  ADD PRIMARY KEY (`ID_ETAPE_VALIDATION`);

--
-- Index pour la table `etape_validation_config`
--
ALTER TABLE `etape_validation_config`
  ADD PRIMARY KEY (`ID_ETAPE_VALIDATION_CONFIG`);

--
-- Index pour la table `fonction_poste`
--
ALTER TABLE `fonction_poste`
  ADD PRIMARY KEY (`ID_FONCTION`);

--
-- Index pour la table `historique_demande`
--
ALTER TABLE `historique_demande`
  ADD PRIMARY KEY (`HISTO_ID`);

--
-- Index pour la table `type_conge`
--
ALTER TABLE `type_conge`
  ADD PRIMARY KEY (`ID_TYPE_CONGE`);

--
-- Index pour la table `type_decision`
--
ALTER TABLE `type_decision`
  ADD PRIMARY KEY (`ID_TYPE_DECISION`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`USER_ID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `agence`
--
ALTER TABLE `agence`
  MODIFY `ID_AGENCE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `demande_conge`
--
ALTER TABLE `demande_conge`
  MODIFY `ID_DEMANDE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `etape_validation`
--
ALTER TABLE `etape_validation`
  MODIFY `ID_ETAPE_VALIDATION` tinyint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `etape_validation_config`
--
ALTER TABLE `etape_validation_config`
  MODIFY `ID_ETAPE_VALIDATION_CONFIG` tinyint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `fonction_poste`
--
ALTER TABLE `fonction_poste`
  MODIFY `ID_FONCTION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `historique_demande`
--
ALTER TABLE `historique_demande`
  MODIFY `HISTO_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `type_conge`
--
ALTER TABLE `type_conge`
  MODIFY `ID_TYPE_CONGE` tinyint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `type_decision`
--
ALTER TABLE `type_decision`
  MODIFY `ID_TYPE_DECISION` tinyint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `USER_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
