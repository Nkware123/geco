-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 06 août 2025 à 17:21
-- Version du serveur :  10.4.11-MariaDB
-- Version de PHP : 7.4.5

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
  `DESC_AGENCE` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `agence`
--

INSERT INTO `agence` (`ID_AGENCE`, `DESC_AGENCE`) VALUES
(1, 'Siège'),
(2, 'Cotebu');

-- --------------------------------------------------------

--
-- Structure de la table `demande_conge`
--

CREATE TABLE `demande_conge` (
  `ID_DEMANDE` int(11) NOT NULL,
  `ID_USER` int(11) NOT NULL,
  `ID_TYPE_CONGE` tinyint(1) NOT NULL,
  `ID_ETAPE_VALIDATION` tinyint(1) NOT NULL,
  `DATE_DEBUT` date NOT NULL,
  `DATE_FIN` date NOT NULL,
  `DATE_INSERTION` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `demande_conge`
--

INSERT INTO `demande_conge` (`ID_DEMANDE`, `ID_USER`, `ID_TYPE_CONGE`, `ID_ETAPE_VALIDATION`, `DATE_DEBUT`, `DATE_FIN`, `DATE_INSERTION`) VALUES
(1, 1, 1, 4, '2025-08-06', '2025-08-09', '2025-08-06');

-- --------------------------------------------------------

--
-- Structure de la table `etape_fonction`
--

CREATE TABLE `etape_fonction` (
  `ei` int(11) NOT NULL,
  `ID_ETAPE_VALIDATION` tinyint(1) NOT NULL,
  `ID_FONCTION` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `etape_fonction`
--

INSERT INTO `etape_fonction` (`ei`, `ID_ETAPE_VALIDATION`, `ID_FONCTION`) VALUES
(1, 1, 1),
(2, 3, 1),
(3, 4, 1);

-- --------------------------------------------------------

--
-- Structure de la table `etape_validation`
--

CREATE TABLE `etape_validation` (
  `ID_ETAPE_VALIDATION` tinyint(1) NOT NULL,
  `ID_ETAPE_SUIVANT` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `etape_validation`
--

INSERT INTO `etape_validation` (`ID_ETAPE_VALIDATION`, `ID_ETAPE_SUIVANT`) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5);

-- --------------------------------------------------------

--
-- Structure de la table `fonction_poste`
--

CREATE TABLE `fonction_poste` (
  `ID_FONCTION` int(11) NOT NULL,
  `DESC_FONCTION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `historique_demande`
--

INSERT INTO `historique_demande` (`HISTO_ID`, `ID_DEMANDE`, `ID_USER`, `ID_ETAPE_VALIDATION`, `OBSERVATION`) VALUES
(1, 1, 1, 1, ''),
(2, 1, 1, 2, 'ok');

-- --------------------------------------------------------

--
-- Structure de la table `type_conge`
--

CREATE TABLE `type_conge` (
  `ID_TYPE_CONGE` tinyint(1) NOT NULL,
  `DESC_TYPE_CONGE` varchar(50) NOT NULL,
  `EST_ACTIVE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `type_conge`
--

INSERT INTO `type_conge` (`ID_TYPE_CONGE`, `DESC_TYPE_CONGE`, `EST_ACTIVE`) VALUES
(1, 'Congé annuel', 1);

-- --------------------------------------------------------

--
-- Structure de la table `type_decision`
--

CREATE TABLE `type_decision` (
  `ID_TYPE_DECISION` tinyint(1) NOT NULL,
  `DESCR_TYPE_DECISION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `type_decision`
--

INSERT INTO `type_decision` (`ID_TYPE_DECISION`, `DESCR_TYPE_DECISION`) VALUES
(1, 'Accepter');

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
  `PHOTO_PROFIL` varchar(100) NOT NULL,
  `EST_ACTIVE` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`USER_ID`, `NOM_USER`, `PRENOM_USER`, `TELEPHONE`, `USERNAME`, `PASSWORD`, `ID_FONCTION`, `ID_AGENCE`, `PHOTO_PROFIL`, `EST_ACTIVE`) VALUES
(1, 'NDERAGAKURA', 'Alain Charbel', '62003522', 'Alain', '12345', 1, 1, 'uploads/profils/689360c3c0762250806020347.jpg', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `agence`
--
ALTER TABLE `agence`
  ADD PRIMARY KEY (`ID_AGENCE`);

--
-- Index pour la table `demande_conge`
--
ALTER TABLE `demande_conge`
  ADD PRIMARY KEY (`ID_DEMANDE`);

--
-- Index pour la table `etape_fonction`
--
ALTER TABLE `etape_fonction`
  ADD PRIMARY KEY (`ei`);

--
-- Index pour la table `etape_validation`
--
ALTER TABLE `etape_validation`
  ADD PRIMARY KEY (`ID_ETAPE_VALIDATION`);

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
  MODIFY `ID_AGENCE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `demande_conge`
--
ALTER TABLE `demande_conge`
  MODIFY `ID_DEMANDE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `etape_fonction`
--
ALTER TABLE `etape_fonction`
  MODIFY `ei` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `etape_validation`
--
ALTER TABLE `etape_validation`
  MODIFY `ID_ETAPE_VALIDATION` tinyint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `fonction_poste`
--
ALTER TABLE `fonction_poste`
  MODIFY `ID_FONCTION` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `historique_demande`
--
ALTER TABLE `historique_demande`
  MODIFY `HISTO_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `type_conge`
--
ALTER TABLE `type_conge`
  MODIFY `ID_TYPE_CONGE` tinyint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `type_decision`
--
ALTER TABLE `type_decision`
  MODIFY `ID_TYPE_DECISION` tinyint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `USER_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
