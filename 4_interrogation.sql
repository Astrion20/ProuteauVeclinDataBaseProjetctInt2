USE MiniProject ;


-- SUPPLY CHAIN
-- All unique resource types handled by the guild
SELECT DISTINCT resource_type
FROM Resource
ORDER BY resource_type ASC;

-- Factories with "Assembler" or "Casing" in their names
SELECT factory_id, factory_name
FROM Factory
WHERE factory_name LIKE '%Assembler%'
OR factory_name LIKE '%Casing%';

-- Resources demanded by 3 or more factories
SELECT resource_id, COUNT(factory_id) AS factories_requiring_input
FROM input
GROUP BY resource_id
HAVING COUNT(factory_id) >= 3
ORDER BY factories_requiring_input DESC;

-- Resources produced specifically at Brass Bastion
SELECT r.resource_name
FROM Resource r
JOIN output o ON r.resource_id = o.resource_id
JOIN Factory f ON o.factory_id = f.factory_id
JOIN Site s ON f.site_id = s.site_id
WHERE s.site_name = 'Brass Bastion';

-- Factories that do not require any raw inputs to function (=> extraction factories)
SELECT factory_id, factory_name
FROM Factory
WHERE factory_id NOT IN (
    SELECT factory_id
    FROM input
);

-- Manufactured resources that are not used as inputs
SELECT r.resource_name
FROM Resource r
WHERE EXISTS (SELECT 1 FROM output o WHERE o.resource_id = r.resource_id)
AND NOT EXISTS (SELECT 1 FROM input i WHERE i.resource_id = r.resource_id);


-- INFRASTRUCTURE
-- Finding sites within specific coordinates
SELECT site_id, site_name, site_x_coordinate, site_z_coordinate
FROM Site
WHERE site_x_coordinate BETWEEN -10000 AND 10000
AND site_z_coordinate BETWEEN -10000 AND 10000;

-- Sites that contain more than 2 active factories
SELECT site_id, COUNT(factory_id) AS total_factories
FROM Factory
GROUP BY site_id
HAVING COUNT(factory_id) > 2
ORDER BY total_factories DESC;

-- Average track capacity of the factions' stations averaging 10 or more tracks
SELECT p.faction_name, AVG(s.station_tracks) AS avg_station_size
FROM possesses p
JOIN Station s ON p.station_id = s.station_id
GROUP BY p.faction_name
HAVING AVG(s.station_tracks) >= 10
ORDER BY avg_station_size DESC;

-- Matching every factory directly to the name of its geographical site
SELECT f.factory_name, s.site_name
FROM Factory f
JOIN Site s ON f.site_id = s.site_id;

-- Stations links
SELECT s1.station_name AS origin_station, s2.station_name AS destination_station
FROM linked_to l
JOIN Station s1 ON l.station_id = s1.station_id
JOIN Station s2 ON l.station_id_1 = s2.station_id;


-- ENERGY
-- Renewable generators and the quantity they produce
SELECT source_id, source_type, source_quantity
FROM Energy_source
WHERE source_type IN ('Water Wheel', 'Windmill Bearing', 'Hand Crank')
ORDER BY source_quantity DESC;

-- Sites using over 10000 units of energy
SELECT site_id, SUM(source_quantity) AS total_energy_capacity
FROM Energy_source
GROUP BY site_id
HAVING SUM(source_quantity) > 10000
ORDER BY total_energy_capacity DESC;

-- Sites using a steam engine
SELECT site_name
FROM Site s
WHERE EXISTS (
    SELECT 1
    FROM Energy_source e
    WHERE e.site_id = s.site_id
	AND e.source_type = 'Steam Engine'
);


-- WORKERS AND FACTIONS
-- Workers whose name starts with C or S
SELECT worker_id, worker_pseudo
FROM Worker
WHERE worker_pseudo LIKE 'C%'
OR worker_pseudo LIKE 'S%'
ORDER BY worker_id;

-- Factions having 8 or more workers
SELECT faction_name, COUNT(worker_id) AS total_affiliations
FROM affiliation
GROUP BY faction_name
HAVING COUNT(worker_id) >= 8;

-- Factions and the stations they possess
SELECT f.faction_name, p.station_id, s.station_name
FROM Faction f
LEFT JOIN possesses p ON f.faction_name = p.faction_name
LEFT JOIN Station s ON p.station_id = s.station_id;

-- All workers and the faction they work for in the sites where they work
SELECT w.worker_pseudo, a.faction_name, s.site_name
FROM Worker w
JOIN affiliation a ON w.worker_id = a.worker_id
JOIN Site s ON a.site_id = s.site_id
ORDER BY a.faction_name, w.worker_pseudo;

-- Factions controlling a station with more tracks than every station controlled by the Aether Vanguard
SELECT DISTINCT p.faction_name
FROM possesses p
JOIN Station s ON p.station_id = s.station_id
WHERE s.station_tracks > ALL (
    SELECT s2.station_tracks
    FROM Station s2
    JOIN possesses p2 ON s2.station_id = p2.station_id
    WHERE p2.faction_name = 'Aether Vanguard'
);

-- Pseudonyms of workers deployed to sites that manufacture electron tubes
SELECT worker_pseudo
FROM Worker
WHERE worker_id IN (
    SELECT worker_id
    FROM affiliation
    WHERE site_id IN (
        SELECT site_id
        FROM Factory
        WHERE factory_id IN (
            SELECT factory_id
            FROM output
            WHERE resource_id = 'res_electron_tube'
        )
    )
);