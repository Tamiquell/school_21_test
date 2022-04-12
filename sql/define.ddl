DROP TABLE busflight;
DROP TABLE city;
DROP TABLE citytoflight;

CREATE TABLE if NOT EXISTS BusFlight(
  Flight_id INTEGER PRIMARY KEY,
  CityName TEXT NOT NULL,
  Seats INTEGER NOT NULL,
  DepartureDate DATE not NULL,
  ArrivalDate Date NOT NULL,
  Cities TEXT[]
);

INSERT INTO BusFlight (Flight_id, CityName, Seats, DepartureDate, ArrivalDate, Cities)
VALUES (1, 'NYC', 120, '2000-01-01', '2000-01-05', ARRAY [ 'NYC','Boston','Washington','Chicago','Richmond' ]),
(2, 'Washington', 100, '2000-01-03', '2000-01-06', ARRAY [ 'Washington','Chicago','NYC','Philadelphia' ]),
(3, 'Richmond', 80, '2000-01-02', '2000-01-04', ARRAY [ 'Richmond','Miami','Charlotte']),
(4, 'Charlotte', 100, '2000-01-03', '2000-01-06', ARRAY [ 'Charlotte','Indianapolis','Pitsburg','NYC' ]),
(5, 'Boston', 200, '2000-01-05', '2000-01-07', ARRAY [ 'Boston','NYC','Miami' ]),
(6, 'Chicago', 150, '2000-01-04', '2000-01-06', ARRAY ['Chicago','Miami','Indianapolis' ]),
(7, 'Indianapolis', 100, '2000-01-01', '2000-01-05', ARRAY ['Indianapolis', 'Chicago','Miami','NYC','Boston' ]);




CREATE TABLE if NOT EXISTS City(
  City_id INTEGER PRIMARY KEY,
  CityName TEXT NOT NULL
);

INSERT INTO City (City_id, CityName)
VALUES (1, 'NYC'), (2, 'Washington'), (3, 'Boston'), (4, 'Pittsburg'), (5, 'Philadelphia'), 
(6, 'Indianapolis'), (7, 'Richmond'), (8, 'Chicago'), 
(9, 'Miami'), (10, 'Charlotte');



CREATE TABLE if NOT EXISTS CityToFlight(
  CityToFlight_id INTEGER PRIMARY KEY,
  TransitDate DATE,
  Flight_fk INTEGER references busflight(flight_id),
  City_fk INTEGER REFERENCES city(city_id)
);

INSERT INTO CityToFlight (CityToFlight_id, TransitDate, Flight_fk, City_fk)
VALUES (1, '2000-01-01', 1, 1),(2, '2000-01-02', 1, 3),(3, '2000-01-03', 1, 2),(4, '2000-01-04', 1, 8),(5, '2000-01-05', 1, 7),
(6, '2000-01-03', 2, 2),(7, '2000-01-04', 2, 8),(8, '2000-01-05', 2, 1),(9, '2000-01-06', 2, 5),
(10, '2000-01-02', 3, 7),(11, '2000-01-03', 3, 9),(12, '2000-01-04', 3, 10),
(13, '2000-01-03', 4, 10),(14, '2000-01-04', 4, 6),(15, '2000-01-05', 4, 4),(16, '2000-01-06', 4, 1),
(17, '2000-01-05', 5, 3),(18, '2000-01-06', 5, 1),(19, '2000-01-07', 5, 9),
(20, '2000-01-04', 6, 8),(21, '2000-01-05', 6, 9),(22, '2000-01-06', 6, 6),
(23, '2000-01-01', 7, 6),(24, '2000-01-02', 7, 8),(25, '2000-01-03', 7, 9),(26, '2000-01-04', 7, 1),(27, '2000-01-05', 7, 3);


