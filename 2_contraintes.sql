USE MiniProject;

/*
N.B. : Since the AI didn't give us a lot of validation constraints in the business rules, we added a few by ourselves.
*/

ALTER TABLE Site 
ADD CONSTRAINT chk_site_coords_range 
CHECK (site_x_coordinate >= -100000 AND site_x_coordinate <= 100000 
       AND site_z_coordinate >= -100000 AND site_z_coordinate <= 100000);

ALTER TABLE Site 
ADD CONSTRAINT chk_site_id_prefix 
CHECK (site_id LIKE 'S-%');

ALTER TABLE Station 
ADD CONSTRAINT chk_station_id_prefix 
CHECK (station_id LIKE 'ST-%');

ALTER TABLE Faction 
ADD CONSTRAINT chk_faction_color_format 
CHECK (faction_color LIKE '#%' AND LENGTH(faction_color) <= 7); -- that way we can get a hexadecimal code

ALTER TABLE Station 
ADD CONSTRAINT chk_station_has_purpose 
CHECK (station_supports_fret <> 0 OR station_supports_transport <> 0);

ALTER TABLE Station 
ADD CONSTRAINT chk_station_tracks_logic 
CHECK (station_tracks >= 1 AND station_tracks <= 32);

ALTER TABLE Energy_source 
ADD CONSTRAINT chk_energy_type_list 
CHECK (source_type IN ('Steam Engine', 'Windmill Bearing', 'Water Wheel', 'Encased Fan', 'Hand Crank', 'Diesel Engine', 'Gas Turbine', 'Industrial Steam Turbine', 'Electric Motor', 'Air Engine'));

ALTER TABLE linked_to 
ADD CONSTRAINT chk_no_loopback 
CHECK (station_id <> station_id_1);