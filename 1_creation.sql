CREATE DATABASE MiniProject;
USE MiniProject;

CREATE TABLE Worker(
   worker_id INT,
   worker_pseudo VARCHAR(16),
   PRIMARY KEY(worker_id)
);

CREATE TABLE Site(
   site_id VARCHAR(10),
   site_name VARCHAR(50),
   site_x_coordinate INT,
   site_z_coordinate INT,
   PRIMARY KEY(site_id)
);

CREATE TABLE Resource(
   resource_id VARCHAR(50),
   resource_name VARCHAR(50),
   resource_type VARCHAR(20),
   PRIMARY KEY(resource_id)
);

CREATE TABLE Faction(
   faction_name VARCHAR(50),
   faction_color VARCHAR(30),
   PRIMARY KEY(faction_name)
);

CREATE TABLE Energy_source(
   source_id VARCHAR(10),
   source_type VARCHAR(30),
   source_quantity INT,
   site_id VARCHAR(10) NOT NULL,
   PRIMARY KEY(source_id),
   FOREIGN KEY(site_id) REFERENCES Site(site_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Station(
   station_id VARCHAR(10),
   station_name VARCHAR(50),
   station_tracks INT,
   station_supports_fret BOOL,
   station_supports_transport BOOL,
   site_id VARCHAR(10) NOT NULL,
   PRIMARY KEY(station_id),
   UNIQUE(site_id),
   FOREIGN KEY(site_id) REFERENCES Site(site_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Factory(
   factory_id VARCHAR(10),
   factory_name VARCHAR(50),
   site_id VARCHAR(10) NOT NULL,
   PRIMARY KEY(factory_id),
   FOREIGN KEY(site_id) REFERENCES Site(site_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE output(
   factory_id VARCHAR(10) NOT NULL,
   resource_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(factory_id, resource_id),
   FOREIGN KEY(factory_id) REFERENCES Factory(factory_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(resource_id) REFERENCES Resource(resource_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE affiliation(
   worker_id INT,
   site_id VARCHAR(10),
   faction_name VARCHAR(50),
   PRIMARY KEY(worker_id, site_id, faction_name),
   FOREIGN KEY(worker_id) REFERENCES Worker(worker_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(site_id) REFERENCES Site(site_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(faction_name) REFERENCES Faction(faction_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE input(
   factory_id VARCHAR(10) NOT NULL,
   resource_id VARCHAR(50),
   PRIMARY KEY(factory_id, resource_id),
   FOREIGN KEY(factory_id) REFERENCES Factory(factory_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(resource_id) REFERENCES Resource(resource_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE possesses(
   faction_name VARCHAR(50),
   station_id VARCHAR(10),
   PRIMARY KEY(faction_name, station_id),
   FOREIGN KEY(faction_name) REFERENCES Faction(faction_name) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(station_id) REFERENCES Station(station_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE linked_to(
   station_id VARCHAR(10) NOT NULL,
   station_id_1 VARCHAR(10) NOT NULL,
   PRIMARY KEY(station_id, station_id_1),
   FOREIGN KEY(station_id) REFERENCES Station(station_id) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(station_id_1) REFERENCES Station(station_id) ON DELETE CASCADE ON UPDATE CASCADE
);