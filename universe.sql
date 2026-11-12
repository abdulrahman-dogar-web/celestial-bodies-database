--
-- Celestial Bodies Database
-- freeCodeCamp Relational Database project
-- Rebuild script for the universe database (PostgreSQL).
-- These are the statements used to build the database;
-- running them with psql rebuilds it with the same tables and data.
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

\connect universe

CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  type VARCHAR NOT NULL,
  is_barred BOOLEAN NOT NULL,
  num_stars NUMERIC NOT NULL,
  diameter_in_light_years NUMERIC
);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  spectral_type VARCHAR NOT NULL,
  age_in_millions_of_years INT,
  is_spherical BOOLEAN NOT NULL,
  distance_from_earth_in_light_years NUMERIC
);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  star_id INT NOT NULL REFERENCES star(star_id),
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  type VARCHAR NOT NULL,
  has_life BOOLEAN NOT NULL,
  num_moons INT,
  diameter_in_km NUMERIC
);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  has_water BOOLEAN,
  is_spherical BOOLEAN NOT NULL,
  orbital_period_in_days INT,
  diameter_in_km NUMERIC
);

CREATE TABLE asteroid (
  asteroid_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  description TEXT,
  diameter_in_km NUMERIC,
  is_dwarf_planet BOOLEAN NOT NULL
);

INSERT INTO galaxy (name, description, type, is_barred, num_stars, diameter_in_light_years) VALUES
('Milky Way', 'The galaxy containing our Solar System', 'spiral', TRUE, 100000000000, 105700),
('Andromeda', 'The nearest large spiral galaxy to the Milky Way', 'spiral', FALSE, 1000000000000, 220000),
('Triangulum', 'The third largest member of the Local Group', 'spiral', FALSE, 40000000000, 60000),
('Whirlpool', 'An interacting grand-design spiral galaxy', 'spiral', FALSE, 300000000000, 76000),
('Sombrero', 'An unbarred spiral galaxy with a bright nucleus', 'spiral', FALSE, 800000000000, 50000),
('Large Magellanic Cloud', 'A satellite galaxy of the Milky Way', 'irregular', FALSE, 30000000000, 14000),
('Small Magellanic Cloud', 'A dwarf irregular galaxy near the Milky Way', 'irregular', FALSE, 7000000000, 7000);

INSERT INTO star (galaxy_id, name, description, spectral_type, age_in_millions_of_years, is_spherical, distance_from_earth_in_light_years) VALUES
(1, 'Sun', 'The star at the centre of our Solar System', 'G2V', 4600, TRUE, 0),
(1, 'Proxima Centauri', 'The closest star to the Solar System', 'M5.5V', 4850, TRUE, 4.2465),
(1, 'Alpha Centauri A', 'The brightest component of the Alpha Centauri system', 'G2V', 5500, TRUE, 4.37),
(1, 'Alpha Centauri B', 'The second brightest component of the Alpha Centauri system', 'K1V', 5500, TRUE, 4.37),
(1, 'Betelgeuse', 'A red supergiant in the constellation Orion', 'M2Iab', 10, TRUE, 642.5),
(1, 'Rigel', 'A blue supergiant in the constellation Orion', 'B8Ia', 8, TRUE, 863),
(1, 'Polaris', 'The North Star, a yellow supergiant', 'F7Ib', 70, TRUE, 433),
(1, 'Sirius', 'The brightest star in the night sky', 'A1V', 242, TRUE, 8.6),
(1, 'Vega', 'A bright blue-white star in the constellation Lyra', 'A0V', 455, TRUE, 25.04),
(1, 'Kepler-452', 'A Sun-like star in the constellation Cygnus', 'G2V', 6000, TRUE, 1400),
(1, 'TRAPPIST-1', 'An ultra-cool red dwarf with seven Earth-sized planets', 'M8V', 7600, TRUE, 39.46),
(1, 'HD 40307', 'An orange dwarf star in the constellation Pictor', 'K2.5V', 1200, TRUE, 41.6);

INSERT INTO planet (star_id, name, description, type, has_life, num_moons, diameter_in_km) VALUES
(1, 'Mercury', 'The smallest planet and closest to the Sun', 'terrestrial', FALSE, 0, 4879),
(1, 'Venus', 'The hottest planet in the Solar System', 'terrestrial', FALSE, 0, 12104),
(1, 'Earth', 'The only known planet to harbour life', 'terrestrial', TRUE, 1, 12742),
(1, 'Mars', 'The Red Planet, home of Olympus Mons', 'terrestrial', FALSE, 2, 6779),
(1, 'Jupiter', 'The largest planet in the Solar System', 'gas giant', FALSE, 95, 139820),
(1, 'Saturn', 'The sixth planet from the Sun, famous for its rings', 'gas giant', FALSE, 146, 116460),
(1, 'Uranus', 'An ice giant that rotates on its side', 'ice giant', FALSE, 28, 50724),
(1, 'Neptune', 'The most distant planet from the Sun', 'ice giant', FALSE, 16, 49244),
(10, 'Kepler-452b', 'An exoplanet sometimes called Earth 2.0', 'terrestrial', FALSE, 0, 18600),
(2, 'Proxima Centauri b', 'An exoplanet in the habitable zone of Proxima Centauri', 'terrestrial', FALSE, 0, 11000),
(11, 'TRAPPIST-1b', 'The innermost planet of the TRAPPIST-1 system', 'terrestrial', FALSE, 0, 11700),
(11, 'TRAPPIST-1e', 'A rocky planet in the TRAPPIST-1 habitable zone', 'terrestrial', FALSE, 0, 12000),
(1, 'Pluto', 'A dwarf planet in the Kuiper belt', 'dwarf', FALSE, 5, 2377),
(12, 'HD 40307 g', 'An exoplanet in the habitable zone of HD 40307', 'terrestrial', FALSE, 0, 19000);

INSERT INTO moon (planet_id, name, description, has_water, is_spherical, orbital_period_in_days, diameter_in_km) VALUES
(3, 'Moon', 'Earths only natural satellite', FALSE, TRUE, 27, 3474),
(5, 'Europa', 'An icy moon of Jupiter with a subsurface ocean', TRUE, TRUE, 4, 3122),
(5, 'Ganymede', 'The largest moon in the Solar System', TRUE, TRUE, 7, 5268),
(5, 'Callisto', 'A heavily cratered moon of Jupiter', TRUE, TRUE, 17, 4821),
(5, 'Io', 'A volcanically active moon of Jupiter', FALSE, TRUE, 2, 3643),
(6, 'Titan', 'The largest moon of Saturn, with a thick atmosphere', TRUE, TRUE, 16, 5149),
(6, 'Enceladus', 'An icy moon of Saturn with geysers at its south pole', TRUE, TRUE, 1, 504),
(6, 'Rhea', 'The second largest moon of Saturn', FALSE, TRUE, 5, 1528),
(6, 'Iapetus', 'A two-toned moon of Saturn', FALSE, TRUE, 79, 1470),
(6, 'Dione', 'A moon of Saturn with bright wispy terrain', FALSE, TRUE, 3, 1123),
(6, 'Tethys', 'A moon of Saturn with a giant crater', FALSE, TRUE, 2, 1062),
(4, 'Phobos', 'The larger and closer of the two moons of Mars', FALSE, FALSE, 1, 22),
(4, 'Deimos', 'The smaller of the two moons of Mars', FALSE, FALSE, 1, 12),
(8, 'Triton', 'The largest moon of Neptune, orbiting backwards', TRUE, TRUE, 6, 2707),
(13, 'Charon', 'The largest moon of Pluto', FALSE, TRUE, 6, 1212),
(13, 'Nix', 'A small moon of Pluto', FALSE, FALSE, 25, 50),
(13, 'Hydra', 'A small moon of Pluto', FALSE, FALSE, 38, 51),
(13, 'Styx', 'A small moon of Pluto', FALSE, FALSE, 20, 16),
(13, 'Kerberos', 'A small moon of Pluto', FALSE, FALSE, 32, 19),
(5, 'Amalthea', 'A small irregular moon of Jupiter', FALSE, FALSE, 1, 250),
(5, 'Metis', 'The innermost moon of Jupiter', FALSE, FALSE, 1, 60);

INSERT INTO asteroid (name, description, diameter_in_km, is_dwarf_planet) VALUES
('Ceres', 'The largest object in the asteroid belt', 939, TRUE),
('Pallas', 'The second asteroid ever discovered', 568, FALSE),
('Juno', 'The third asteroid ever discovered', 234, FALSE),
('Vesta', 'The brightest asteroid in the night sky', 525, FALSE);

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);
SELECT pg_catalog.setval('public.star_star_id_seq', 12, true);
SELECT pg_catalog.setval('public.planet_planet_id_seq', 14, true);
SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);
SELECT pg_catalog.setval('public.asteroid_asteroid_id_seq', 4, true);
