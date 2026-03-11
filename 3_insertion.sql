USE MiniProject; -- line added by us to make it work if we ever have to recreate the database

-- =========================================================================
-- 1. INDEPENDENT TABLES (No Foreign Keys)
-- =========================================================================

-- WORKER (20 rows)
INSERT INTO Worker (worker_id, worker_pseudo) VALUES
(1, 'CogMaster'), (2, 'SteamWeaver'), (3, 'BrassBaron'), (4, 'IronSmelter'),
(5, 'GearHead'), (6, 'CopperSmith'), (7, 'ZincMiner'), (8, 'AlloyArtisan'),
(9, 'CoalBurner'), (10, 'QuartzGrinder'), (11, 'RedstoneTinker'), (12, 'GoldPresser'),
(13, 'KineticCrafter'), (14, 'FluidPump'), (15, 'RailLayer'), (16, 'BoilerTender'),
(17, 'SpoolWinder'), (18, 'GoggleMaker'), (19, 'FlywheelSpinner'), (20, 'ShaftTurner');

-- SITE (10 rows, coords within +/- 100000)
INSERT INTO Site (site_id, site_name, site_x_coordinate, site_z_coordinate) VALUES
('S-01', 'Copper Caverns', 1500, -2300),
('S-02', 'Brass Bastion', -4500, 8100),
('S-03', 'Iron Gorge', 0, 500),
('S-04', 'Zinc Peaks', 8900, 12000),
('S-05', 'Steamwind Valley', -15000, -8000),
('S-06', 'Andesite Quarry', 200, -100),
('S-07', 'Rose Quartz Oasis', 42000, -65000),
('S-08', 'Crushing Basin', -85000, 92000),
('S-09', 'Obsidian Forge', 12000, 45000),
('S-10', 'Aether Plateau', 0, 0);

-- RESOURCE (30 rows, strict manufacturing materials and components)
INSERT INTO Resource (resource_id, resource_name, resource_type) VALUES
('res_iron_ore', 'Iron Ore', 'Raw Material'),
('res_crushed_iron', 'Crushed Iron', 'Crushed Ore'),
('res_iron_ingot', 'Iron Ingot', 'Ingot'),
('res_iron_sheet', 'Iron Sheet', 'Sheet'),
('res_copper_ore', 'Copper Ore', 'Raw Material'),
('res_crushed_copper', 'Crushed Copper', 'Crushed Ore'),
('res_copper_ingot', 'Copper Ingot', 'Ingot'),
('res_copper_sheet', 'Copper Sheet', 'Sheet'),
('res_zinc_ore', 'Zinc Ore', 'Raw Material'),
('res_crushed_zinc', 'Crushed Zinc', 'Crushed Ore'),
('res_zinc_ingot', 'Zinc Ingot', 'Ingot'),
('res_brass_ingot', 'Brass Ingot', 'Alloy'),
('res_brass_sheet', 'Brass Sheet', 'Sheet'),
('res_andesite', 'Andesite', 'Block'),
('res_andesite_alloy', 'Andesite Alloy', 'Alloy'),
('res_wood_log', 'Wood Log', 'Block'),
('res_wood_planks', 'Wood Planks', 'Block'),
('res_kelp', 'Kelp', 'Plant'),
('res_dried_kelp', 'Dried Kelp', 'Material'),
('res_shaft', 'Shaft', 'Component'),
('res_cogwheel', 'Cogwheel', 'Component'),
('res_large_cogwheel', 'Large Cogwheel', 'Component'),
('res_andesite_casing', 'Andesite Casing', 'Block'),
('res_brass_casing', 'Brass Casing', 'Block'),
('res_copper_casing', 'Copper Casing', 'Block'),
('res_fluid_pipe', 'Fluid Pipe', 'Component'),
('res_mech_belt', 'Mechanical Belt', 'Component'),
('res_gearbox', 'Gearbox', 'Component'),
('res_rose_quartz', 'Rose Quartz', 'Material'),
('res_electron_tube', 'Electron Tube', 'Component');

-- FACTION (4 rows)
INSERT INTO Faction (faction_name, faction_color) VALUES
('Cogwheel Syndicate', '#8B4513'),
('Aether Vanguard', '#00CED1'),
('Obsidian Order', '#4B0082'),
('Brass Republic', '#DAA520');


-- =========================================================================
-- 2. DEPENDENT TABLES (First-level Foreign Keys)
-- =========================================================================

-- ENERGY_SOURCE (10 rows)
INSERT INTO Energy_source (source_id, source_type, source_quantity, site_id) VALUES
('E-01', 'Water Wheel', 256, 'S-01'),
('E-02', 'Steam Engine', 16384, 'S-02'),
('E-03', 'Windmill Bearing', 8192, 'S-03'),
('E-04', 'Water Wheel', 512, 'S-04'),
('E-05', 'Steam Engine', 32768, 'S-05'),
('E-06', 'Hand Crank', 32, 'S-06'),
('E-07', 'Windmill Bearing', 4096, 'S-07'),
('E-08', 'Encased Fan', 64, 'S-08'),
('E-09', 'Diesel Engine', 10000, 'S-09'),
('E-10', 'Electric Motor', 20000, 'S-10');

-- STATION (10 rows)
INSERT INTO Station (station_id, station_name, station_tracks, station_supports_fret, station_supports_transport, site_id) VALUES
('ST-01', 'Copper Depths Terminal', 4, TRUE, FALSE, 'S-01'),
('ST-02', 'Brass Central', 12, TRUE, TRUE, 'S-02'),
('ST-03', 'Iron Gorge Hub', 8, TRUE, FALSE, 'S-03'),
('ST-04', 'Zinc Peaks Transit', 2, FALSE, TRUE, 'S-04'),
('ST-05', 'Steamwind Station', 16, TRUE, TRUE, 'S-05'),
('ST-06', 'Andesite Loading Bay', 6, TRUE, FALSE, 'S-06'),
('ST-07', 'Oasis Post', 1, FALSE, TRUE, 'S-07'),
('ST-08', 'Basin Freight Hub', 10, TRUE, FALSE, 'S-08'),
('ST-09', 'Obsidian Nexus', 24, TRUE, TRUE, 'S-09'),
('ST-10', 'Aether Spire Station', 4, FALSE, TRUE, 'S-10');

-- FACTORY (25 rows - expanded list mapped across 10 sites)
INSERT INTO Factory (factory_id, factory_name, site_id) VALUES
('F-01', 'Iron Extraction Outpost', 'S-03'),
('F-02', 'Copper & Zinc Mine', 'S-01'),
('F-03', 'Andesite Quarry', 'S-06'),
('F-04', 'Logging Camp', 'S-05'),
('F-05', 'Deep Sea Kelp Farm', 'S-08'),
('F-06', 'Quartz Mine', 'S-07'),
('F-07', 'Heavy Ore Crusher', 'S-08'),
('F-08', 'Industrial Smeltery', 'S-09'),
('F-09', 'Timber Sawmill', 'S-05'),
('F-10', 'Kelp Drying Kiln', 'S-08'),
('F-11', 'Brass Alloy Foundry', 'S-02'),
('F-12', 'Andesite Mixer', 'S-06'),
('F-13', 'Sheet Metal Press', 'S-09'),
('F-14', 'Shaft Extruder', 'S-06'),
('F-15', 'Cogwheel Workshop', 'S-05'),
('F-16', 'Heavy Cog Assembler', 'S-05'),
('F-17', 'Andesite Casing Factory', 'S-06'),
('F-18', 'Brass Casing Factory', 'S-02'),
('F-19', 'Copper Casing Factory', 'S-01'),
('F-20', 'Plumbing Workshop', 'S-01'),
('F-21', 'Belt Weaving Loom', 'S-08'),
('F-22', 'Gearbox Assembler', 'S-02'),
('F-23', 'Precision Tube Crafter', 'S-07'),
('F-24', 'Advanced Logistics Hub', 'S-10'),
('F-25', 'Automated Mechanism Plant', 'S-10');


-- =========================================================================
-- 3. INTERSECTION & MAPPING TABLES (Multi-level Foreign Keys)
-- =========================================================================

-- OUTPUT (Maps multiple coherent outputs to factories)
INSERT INTO output (factory_id, resource_id) VALUES
('F-01', 'res_iron_ore'),
('F-02', 'res_copper_ore'), ('F-02', 'res_zinc_ore'),
('F-03', 'res_andesite'),
('F-04', 'res_wood_log'),
('F-05', 'res_kelp'),
('F-06', 'res_rose_quartz'),
('F-07', 'res_crushed_iron'), ('F-07', 'res_crushed_copper'), ('F-07', 'res_crushed_zinc'),
('F-08', 'res_iron_ingot'), ('F-08', 'res_copper_ingot'), ('F-08', 'res_zinc_ingot'),
('F-09', 'res_wood_planks'),
('F-10', 'res_dried_kelp'),
('F-11', 'res_brass_ingot'),
('F-12', 'res_andesite_alloy'),
('F-13', 'res_iron_sheet'), ('F-13', 'res_copper_sheet'), ('F-13', 'res_brass_sheet'),
('F-14', 'res_shaft'),
('F-15', 'res_cogwheel'),
('F-16', 'res_large_cogwheel'),
('F-17', 'res_andesite_casing'),
('F-18', 'res_brass_casing'),
('F-19', 'res_copper_casing'),
('F-20', 'res_fluid_pipe'),
('F-21', 'res_mech_belt'),
('F-22', 'res_gearbox'),
('F-23', 'res_electron_tube'),
('F-24', 'res_mech_belt'), ('F-24', 'res_fluid_pipe'),
('F-25', 'res_electron_tube'), ('F-25', 'res_cogwheel');

-- INPUT (Logic: F-01 through F-06 are extractors/farms and require no inputs)
INSERT INTO input (factory_id, resource_id) VALUES
('F-07', 'res_iron_ore'), ('F-07', 'res_copper_ore'), ('F-07', 'res_zinc_ore'),
('F-08', 'res_crushed_iron'), ('F-08', 'res_crushed_copper'), ('F-08', 'res_crushed_zinc'),
('F-09', 'res_wood_log'),
('F-10', 'res_kelp'),
('F-11', 'res_zinc_ingot'), ('F-11', 'res_copper_ingot'),
('F-12', 'res_andesite'), ('F-12', 'res_iron_ingot'),
('F-13', 'res_iron_ingot'), ('F-13', 'res_copper_ingot'), ('F-13', 'res_brass_ingot'),
('F-14', 'res_andesite_alloy'),
('F-15', 'res_shaft'), ('F-15', 'res_wood_planks'),
('F-16', 'res_cogwheel'), ('F-16', 'res_wood_planks'),
('F-17', 'res_andesite_alloy'), ('F-17', 'res_wood_log'),
('F-18', 'res_brass_sheet'), ('F-18', 'res_wood_log'),
('F-19', 'res_copper_sheet'), ('F-19', 'res_wood_log'),
('F-20', 'res_copper_sheet'),
('F-21', 'res_dried_kelp'),
('F-22', 'res_andesite_casing'), ('F-22', 'res_cogwheel'),
('F-23', 'res_rose_quartz'), ('F-23', 'res_iron_sheet'),
('F-24', 'res_dried_kelp'), ('F-24', 'res_copper_sheet'),
('F-25', 'res_rose_quartz'), ('F-25', 'res_iron_sheet'), ('F-25', 'res_shaft'), ('F-25', 'res_wood_planks');

-- AFFILIATION (40 rows mapping workers to sites and factions)
INSERT INTO affiliation (worker_id, site_id, faction_name) VALUES
(1, 'S-01', 'Cogwheel Syndicate'), (1, 'S-02', 'Cogwheel Syndicate'),
(2, 'S-05', 'Aether Vanguard'), (2, 'S-10', 'Aether Vanguard'),
(3, 'S-02', 'Brass Republic'), (3, 'S-04', 'Brass Republic'),
(4, 'S-03', 'Obsidian Order'), (4, 'S-09', 'Obsidian Order'),
(5, 'S-06', 'Cogwheel Syndicate'), (5, 'S-08', 'Cogwheel Syndicate'),
(6, 'S-01', 'Brass Republic'), (6, 'S-07', 'Brass Republic'),
(7, 'S-04', 'Obsidian Order'), (7, 'S-05', 'Obsidian Order'),
(8, 'S-02', 'Brass Republic'), (8, 'S-06', 'Brass Republic'),
(9, 'S-09', 'Obsidian Order'), (9, 'S-03', 'Obsidian Order'),
(10, 'S-07', 'Aether Vanguard'), (10, 'S-10', 'Aether Vanguard'),
(11, 'S-07', 'Cogwheel Syndicate'), (11, 'S-08', 'Cogwheel Syndicate'),
(12, 'S-02', 'Brass Republic'), (12, 'S-01', 'Brass Republic'),
(13, 'S-06', 'Aether Vanguard'), (13, 'S-05', 'Aether Vanguard'),
(14, 'S-01', 'Obsidian Order'), (14, 'S-08', 'Obsidian Order'),
(15, 'S-09', 'Cogwheel Syndicate'), (15, 'S-04', 'Cogwheel Syndicate'),
(16, 'S-05', 'Brass Republic'), (16, 'S-03', 'Brass Republic'),
(17, 'S-10', 'Obsidian Order'), (17, 'S-02', 'Obsidian Order'),
(18, 'S-04', 'Aether Vanguard'), (18, 'S-07', 'Aether Vanguard'),
(19, 'S-08', 'Brass Republic'), (19, 'S-09', 'Brass Republic'),
(20, 'S-03', 'Cogwheel Syndicate'), (20, 'S-06', 'Cogwheel Syndicate');

-- POSSESSES (10 rows assigning stations)
INSERT INTO possesses (faction_name, station_id) VALUES
('Cogwheel Syndicate', 'ST-01'),
('Brass Republic', 'ST-02'),
('Obsidian Order', 'ST-03'),
('Aether Vanguard', 'ST-04'),
('Brass Republic', 'ST-05'),
('Cogwheel Syndicate', 'ST-06'),
('Aether Vanguard', 'ST-07'),
('Cogwheel Syndicate', 'ST-08'),
('Obsidian Order', 'ST-09'),
('Aether Vanguard', 'ST-10');

-- LINKED_TO (Connections ensuring everyone is mapped without loopbacks)
INSERT INTO linked_to (station_id, station_id_1) VALUES
('ST-01', 'ST-02'), ('ST-02', 'ST-01'),
('ST-02', 'ST-03'), ('ST-03', 'ST-04'),
('ST-04', 'ST-05'), ('ST-05', 'ST-06'),
('ST-06', 'ST-07'), ('ST-07', 'ST-08'),
('ST-08', 'ST-09'), ('ST-09', 'ST-10'),
('ST-10', 'ST-01'), ('ST-05', 'ST-02');