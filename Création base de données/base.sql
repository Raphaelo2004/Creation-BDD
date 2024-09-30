DROP SCHEMA IF EXISTS transmusicales CASCADE; 
CREATE SCHEMA transmusicales;
SET SCHEMA 'transmusicales';


CREATE TABLE _Groupe_artiste (
    id_Groupe_Artiste     character varying(20)        NOT NULL,
    nom_groupe_artiste    character varying(30)        NOT NULL,
    site_web              character varying(50)        NOT NULL,
    CONSTRAINT Groupe_artiste_pk PRIMARY KEY (id_Groupe_Artiste)
);

CREATE TABLE _Annee (
  an integer NOT NULL,
  CONSTRAINT Annee_pk PRIMARY KEY (an)
);


CREATE TABLE _Formation (
  libelle_formation   character varying(20)        NOT NULL,
  CONSTRAINT Formation_pk PRIMARY KEY (libelle_formation)
);


CREATE TABLE _Representation (
  numero_representation character varying(20)  NOT NULL,
  heure                 character varying(20)  NOT NULL,
  date_representation   date                   NOT NULL,
  CONSTRAINT Representation PRIMARY KEY (numero_representation)
);

CREATE TABLE _Pays (
  nom_p   character varying(20)        NOT NULL,
  CONSTRAINT Pays_pk PRIMARY KEY (nom_p)
);


CREATE TABLE _Ville (
  nom_v character varying(20) NOT NULL,
  CONSTRAINT Ville_pk PRIMARY KEY (nom_v)
);

CREATE TABLE _Edition (
  nom_edition character varying(50) NOT NULL,
  CONSTRAINT Edition_pk PRIMARY KEY (nom_edition)
);

CREATE TABLE _Lieu (
  id_lieu       character varying(20)  NOT NULL,
  nom_lieu      character varying(30)  NOT NULL,
  accesPMR      boolean                NOT NULL,
  capacite_max  integer                NOT NULL,
  type_lieu     character varying(20)  NOT NULL,
  CONSTRAINT Lieu_pk PRIMARY KEY (id_lieu)
);


CREATE TABLE _Concert (
  no_concert character varying(20)      NOT NULL,
  titre      character varying(30)      NOT NULL,
  resume     character varying(20)      NOT NULL,
  duree      integer                    NOT NULL,
  tarif      float                      NOT NULL,
  CONSTRAINT Concert_pk PRIMARY KEY (no_concert)
);

CREATE TABLE _Type_de_musique (
  type_m      character varying(20)      NOT NULL,
  CONSTRAINT Type_de_musique_pk PRIMARY KEY (type_m)
);




/*
--
-- Base de données d'un commerce avec comptes utilisateurs en ligne
--

-- Initialisation du schéma
DROP SCHEMA IF EXISTS commerce CASCADE; 
CREATE SCHEMA commerce;
SET SCHEMA 'commerce';

--
-- Table client
--

CREATE TABLE client (
    num_cli     numeric(3,0)            NOT NULL,
    nom_cli     character varying(20)   NOT NULL,
    adresse_cli character varying(20)   NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY (num_cli)
);

--
-- Table stock
--

CREATE TABLE stock (
    num_art         numeric(3,0)            NOT NULL,
    nom_art         character varying(40)   NOT NULL,
    type_art        character varying(20)   NOT NULL,
    prix_art        numeric(6,2)            NOT NULL,
    quantite_art    numeric(5,0)            NOT NULL,
    CONSTRAINT stock_pk PRIMARY KEY (num_art)
);

--
-- Table commande
--

CREATE TABLE commande (
    date_com        date            NOT NULL,
    num_art_c       numeric(3,0)    NOT NULL,
    num_cli_c       numeric(3,0)    NOT NULL,
    quantite_art_c  numeric(5,0)    NOT NULL,
    CONSTRAINT commande_pk PRIMARY KEY (date_com, num_art_c, num_cli_c),
    CONSTRAINT commande_fk_stock FOREIGN KEY (num_art_c) REFERENCES stock(num_art),
    CONSTRAINT commande_fk_client FOREIGN KEY (num_cli_c) REFERENCES client(num_cli)
);

--
-- Table compteweb
--

CREATE TABLE compteweb (
    login_cw        character varying(20)   NOT NULL,
    password_cw     character varying(32)   NOT NULL,
    email_cw        character varying(40)   NOT NULL,
    num_cli_cw      numeric(3,0)            NOT NULL,
    CONSTRAINT compteweb_pk PRIMARY KEY(login_cw),
    CONSTRAINT compteweb_uk UNIQUE(num_cli_cw),
    CONSTRAINT compteweb_fk_client FOREIGN KEY(num_cli_cw) REFERENCES client(num_cli)
);


--
-- Table grossiste
--

CREATE TABLE grossiste (
  num_gross   numeric(3,0)            NOT NULL,
  nom_gross   character varying(20)   NOT NULL,
  ville       character varying(20)   NOT NULL,
  CONSTRAINT grossiste_pk PRIMARY KEY(num_gross)
);


--
-- Table fournir
--
CREATE TABLE fournir (
  num_gross_f   numeric(3,0)    NOT NULL,
  num_art_f     numeric(3,0)    NOT NULL,
  tarif_ht      numeric(6,2)    NOT NULL,
  CONSTRAINT fournir_pk PRIMARY KEY(num_gross_f, num_art_f),
  CONSTRAINT fournir_fk_stock FOREIGN KEY (num_art_f) REFERENCES stock(num_art),
  CONSTRAINT fournir_fk_grossiste FOREIGN KEY (num_gross_f) REFERENCES grossiste(num_gross)
);


--
-- Data pour clients
--

INSERT INTO client (num_cli, nom_cli, adresse_cli) VALUES
(1,'Arniel','Servel Lannion'),
(2,'Legudec','Brel. Lannion'),
(3,'Bolin','Ker Huel Lannion'),
(4,'Durand','Bd dArmor Lannion'),
(5,'Mazer','Bd Guilloux Lannion'),
(6,'Murton','Ker Huel Lannion'),
(7,'Legros','La Clarte Perros'),
(8,'Duchemin','Brel. Lannion'), 
(9,'Guidroc','Ker Huel Lannion'),
(10,'Podrez','Kerdouka Tonquedec');

--
-- Data pour stock
--

INSERT INTO stock (num_art, nom_art, type_art, prix_art, quantite_art) VALUES
(1,'Mathematiques : Algebre','Sciences',40.00,20),
(2,'Mathematiques : Analyse','Sciences',12.00,20),
(3,'Perception et Realite','Philosophie',23.00,400),
(4,'Le moi','Philosophie',2.00,900),
(5,'Vie de Zograffi','Litterature',20.00,400),
(6,'Terre des Hommes','Litterature',19.00,40),
(7,'Voyages Imaginaires','Litterature',18.00,300),
(8,'1984','Litterature',8.00,80),
(9,'Germinal','Litterature',40.00,20),
(10,'La Programmation','Sciences',40.00,0);

--
-- Data pour commande
--

INSERT INTO commande (date_com, num_art_c, num_cli_c, quantite_art_c) VALUES
('2013-11-30',1,5,10),
('2013-06-22',3,6,10),
('2013-06-04',4,6,20),
('2013-06-08',5,6,20),
('2014-01-01',2,5,40),
('2014-01-03',4,2,1),
('2014-01-09',4,4,2),
('2014-01-15',3,1,10),
('2014-01-27',1,3,10),
('2014-03-03',8,1,30),
('2014-03-04',8,4,5),
('2014-03-08',5,2,10),
('2014-03-17',1,4,10),
('2014-03-18',3,7,20),
('2014-03-22',4,7,10),
('2014-03-22',3,8,20),
('2014-04-02',2,7,55),
('2014-04-03',2,5,90),
('2014-04-12',3,1,2),
('2014-04-19',7,2,8),
('2014-04-19',4,2,3);

--
-- Data pour compteweb

INSERT INTO compteweb (login_cw,password_cw,email_cw,num_cli_cw) VALUES
('arniel22','G65ziKimd9WkKmzzYwgv','jacques.arniel@gamail.com',1),
('legudu','8wSy6U59zSTiKS97ta','yvan.legudec@thepost.uk',2),
('bolino','pSfyhAWVP2hiSuwg2bVM','obolin@gamail.com',3),
('durandm','eCLAsm7','marcdurand@chouette.fr',4),
('yourwall','EpZuwVm2EBVMYEkGWqEo','franck.murton@caramel.fr',6),
('fatboy','BbcgwSGiT9dFx8qXo5SLC2Vn6bRKThUu','thierry.legros@gamail.com',7),
('duduche56','s7J5Y','gerard.duchemin@gamail.com',8)
;

--
-- Data pour grossiste
--

INSERT INTO grossiste (num_gross,nom_gross,ville) VALUES
  (1,'Expodif','Courbevoie'),
  (2,'Comptoir du livre','Portet sur Garonne'),
  (3,'SAS Stockover','Carvin');
  
--
-- Data pour fournir
--

INSERT INTO fournir (num_gross_f,num_art_f,tarif_ht) VALUES
  (3,1,35.00),
  (3,2,10.00),
  (3,10,35.00),
  (1,3,17.50),
  (1,4,1.20),
  (2,4,1.20),
  (1,5,17.00),
  (3,5,16.90),
  (2,6,16.00),
  (2,7,15.50),
  (3,7,15.50),
  (2,8,7.20),
  (2,9,36.00);
*/