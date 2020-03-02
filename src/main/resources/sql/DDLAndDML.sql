CREATE TABLE `migration`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `educationRankingsByPopulation` DECIMAL(16,8) NULL,
  PRIMARY KEY (`id`));  
ALTER TABLE `migration`.`country` 
CHANGE COLUMN `educationRankingsByPopulation` `educationRankingsByPopulation` DECIMAL(16,8) NULL ,
ADD UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
ADD UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE;
  
INSERT INTO country (name, educationRankingsByPopulation)
VALUES
('Sweden', 1486),
('Brazil', 1203),
('Macedonia', 1298.75),
('Germany', 1530),
('Netherlands', 1556),
('Portugal', 1469),
('Spain', 1452),
('Canada', 1580),
('United Kingdom', 1500),
('United States', 1489),
('Australia', 1556),
('France', 1491),
('Austria', 1460),
('Italy', 1458),
('Switzerland', 1552),
('Seychelles', 1398.206349),
('Malta', 1398.206349),
('Ireland', 1491);

INSERT INTO country (name)
VALUES
('Afghanistan'),
('Albania'),
('Algeria'),
('Andorra'),
('Angola'),
('Antigua and Barbuda'),
('Argentina'),
('Armenia'),
('Azerbaijan'),
('Bahamas'),
('Bahrain'),
('Bangladesh'),
('Barbados'),
('Belarus'),
('Belgium'),
('Belize'),
('Benin'),
('Bhutan'),
('Bolivia'),
('Bosnia and Herzegovina'),
('Botswana'),
('Brunei'),
('Bulgaria'),
('Burkina Faso'),
('Burundi'),
('Cabo Verde'),
('Cambodia'),
('Cameroon'),
('Central African Republic'),
('Chad'),
('Chile'),
('China'),
('Chinese Taipei'),
('Colombia'),
('Comoros'),
('Congo'),
('Costa Rica'),
('Croatia'),
('Cuba'),
('Cyprus'),
('Czech Republic'),
('Democratic Republic of the Congo'),
('Denmark'),
('Djibouti'),
('Dominica'),
('Dominican Republic'),
('Ecuador'),
('Egypt'),
('El Salvador'),
('Equatorial Guinea'),
('Eritrea'),
('Estonia'),
('Ethiopia'),
('Fiji'),
('Finland'),
('Gabon'),
('Gambia'),
('Georgia'),
('Ghana'),
('Greece'),
('Grenada'),
('Guatemala'),
('Guinea'),
('Guinea-Bissau'),
('Guyana'),
('Haiti'),
('Honduras'),
('Hungary'),
('Iceland'),
('India'),
('Indonesia'),
('Iran'),
('Iraq'),
('Israel'),
('Ivory Coast'),
('Jamaica'),
('Japan'),
('Jordan'),
('Kazakhstan'),
('Kenya'),
('Kiribati'),
('Kuwait'),
('Kyrgyzstan'),
('Laos'),
('Latvia'),
('Lebanon'),
('Lesotho'),
('Liberia'),
('Libya'),
('Lithuania'),
('Luxembourg'),
('Madagascar'),
('Malawi'),
('Malaysia'),
('Maldives'),
('Mali'),
('Marshall Islands'),
('Mauritania'),
('Mauritius'),
('Mexico'),
('Micronesia'),
('Mongolia'),
('Montenegro'),
('Morocco'),
('Mozambique'),
('Myanmar'),
('Namibia'),
('Nepal'),
('New Zealand'),
('Nicaragua'),
('Niger'),
('Nigeria'),
('North Korea'),
('Norway'),
('Oman'),
('Pakistan'),
('Panama'),
('Papua New Guinea'),
('Paraguay'),
('Peru'),
('Philippines'),
('Poland'),
('Qatar'),
('Republic of Moldova'),
('Romania'),
('Russian Federation'),
('Rwanda'),
('Saint Lucia'),
('Saint Vincent and the Grenadines'),
('Sao Tome and Principe'),
('Saudi Arabia'),
('Senegal'),
('Serbia'),
('Sierra Leone'),
('Singapore'),
('Slovakia'),
('Slovenia'),
('Solomon Islands'),
('Somalia'),
('South Africa'),
('South Korea'),
('South Sudan'),
('Sri Lanka'),
('State of Palestine'),
('Sudan'),
('Suriname'),
('Swaziland'),
('Syria'),
('Tajikistan'),
('Tanzania'),
('Thailand'),
('Timor-Leste'),
('Togo'),
('Tonga'),
('Trinidad and Tobago'),
('Tunisia'),
('Turkey'),
('Turkmenistan'),
('Uganda'),
('Ukraine'),
('United Arab Emirates'),
('Uruguay'),
('Uzbekistan'),
('Vanuatu'),
('Venezuela'),
('Vietnam'),
('Yemen'),
('Zambia'),
('Zimbabwe');

INSERT INTO country (name)
VALUES
('Taiwan'),
('Kosovo');

CREATE TABLE `migration`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NULL,
  `country` INT NOT NULL,
  `fourPersonFamilyMonthlyCosts` DECIMAL(16,8) NULL,
  `averageMonthlyNetSalaryAfterTax` DECIMAL(16,8) NULL,
  `parentalLeave` DECIMAL(16,8) NULL,
  `preschoolFullDayPrivateMonthly1Child` DECIMAL(16,8) NULL,
  `internationalPrimarySchoolYearly1Child` DECIMAL(16,8) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `countryFK_idx` (`country` ASC) VISIBLE,
  CONSTRAINT `countryFK`
    FOREIGN KEY (`country`)
    REFERENCES `migration`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
  
ALTER TABLE `migration`.`city` 
  ADD COLUMN `safetyTheEconomistSafeCityIndex` DECIMAL(16,8) NULL AFTER `internationalPrimarySchoolYearly1Child`,
  ADD COLUMN `safetyNumbeoCrimeCityIndex` DECIMAL(16,8) NULL AFTER `safetyTheEconomistSafeCityIndex`;
    
INSERT INTO city (name, state, country, fourPersonFamilyMonthlyCosts, averageMonthlyNetSalaryAfterTax, parentalLeave, preschoolFullDayPrivateMonthly1Child, internationalPrimarySchoolYearly1Child)
VALUES
('Zurich', NULL, '15', '5127.75', '5644.81', '11.2', '1459.6', '9382.62'),
('Basel', NULL, '15', NULL, NULL, '11.2', NULL, NULL),
('Lausanne', NULL, '15', NULL, NULL, '11.2', NULL, NULL),
('Geneva', NULL, '15', NULL, NULL, '11.2', NULL, NULL),
('Bern', NULL, '15', NULL, NULL, '11.2', NULL, NULL),
('Stavanger', NULL, '860', NULL, NULL, NULL, NULL, NULL),
('Oslo', NULL, '860', NULL, NULL, NULL, NULL, NULL),
('Trondheim', NULL, '860', NULL, NULL, NULL, NULL, NULL),
('Reykjavik', NULL, '815', NULL, NULL, NULL, NULL, NULL),
('Bergen', NULL, '860', NULL, NULL, NULL, NULL, NULL),
('New York', 'NY', '10', '4166.21', '3187.28', '1.2', '2312.78', '9571.83'),
('Anchorage', 'AK', '10', NULL, NULL, '1.2', NULL, NULL),
('Washington', 'DC', '10', NULL, NULL, '1.2', NULL, NULL),
('San Francisco', 'CA', '10', NULL, NULL, '1.2', NULL, NULL),
('Honolulu', 'HI', '10', NULL, NULL, '1.2', NULL, NULL),
('Tokyo', NULL, '823', NULL, NULL, NULL, NULL, NULL),
('Brooklyn', 'NY', '10', NULL, NULL, '1.2', NULL, NULL),
('Aalborg', NULL, '789', NULL, NULL, NULL, NULL, NULL),
('Luxembourg', NULL, '837', NULL, NULL, NULL, NULL, NULL),
('Copenhagen', NULL, '789', NULL, NULL, NULL, NULL, NULL),
('Seattle', 'WA', '10', '3496.89', '3292.17', '1.2', '1672.6', '5309.51'),
('Seoul', NULL, '887', NULL, NULL, NULL, NULL, NULL),
('Boston', 'MA', '10', NULL, NULL, '1.2', NULL, NULL),
('Tel Aviv-Yafo', NULL, '820', NULL, NULL, NULL, NULL, NULL),
('Paris', NULL, '12', '3338.48', '2236.89', '28.8', '1009.2', '9673.69'),
('Arhus', NULL, '789', NULL, NULL, NULL, NULL, NULL),
('Philadelphia', 'PA', '10', NULL, NULL, '1.2', NULL, NULL),
('Toronto', NULL, '8', '3191.52', '2334.62', '22.79918864', '1326.67', '6537.53'),
('Osaka', NULL, '823', NULL, NULL, NULL, NULL, NULL),
('London', NULL, '9', '3276.62', '2625.05', '31.1', '1652.37', '11831.47'),
('Singapore', NULL, '881', NULL, NULL, NULL, NULL, NULL),
('Chicago', 'IL', '10', NULL, NULL, '1.2', NULL, NULL),
('Amsterdam', NULL, '5', '3082.32', '2634.73', '22.2', '1398.12', '6265.14'),
('Sydney', NULL, '11', '3108.5', '3013.15', '15.07733333', '1371.25', '6954.74'),
('Haifa', NULL, '820', NULL, NULL, NULL, NULL, NULL),
#N/A
('Sacramento', 'CA', '10', NULL, NULL, '1.2', NULL, NULL),
('Dublin', NULL, '18', '3103.84', '2531.16', '20.42135293', '1548.81', '4796.12'),
('Portland', 'OR', '10', NULL, NULL, '1.2', NULL, NULL),
('Los Angeles', 'CA', '10', NULL, NULL, '1.2', NULL, NULL),
('Innsbruck', NULL, '13', NULL, NULL, '26.4', NULL, NULL),
('Jerusalem', NULL, '820', NULL, NULL, NULL, NULL, NULL),
('Pittsburgh', 'PA', '10', NULL, NULL, '1.2', NULL, NULL),
('Cork', NULL, '18', NULL, NULL, '20.42135293', NULL, NULL),
('Charlotte', 'NC', '10', NULL, NULL, '1.2', NULL, NULL),
('Miami', 'FL', '10', NULL, NULL, '1.2', NULL, NULL),
('Albany', 'NY', '10', NULL, NULL, '1.2', NULL, NULL),
('Utrecht', NULL, '5', '2998.58', '2208.67', '22.2', '936.51', '3799.61'),
('Stockholm', NULL, '1', '3033.2', '2330.5', '46.19636364', '959.65', '6858.16'),
('Linz', NULL, '13', NULL, NULL, '26.4', NULL, NULL),
('Milan', NULL, '14', '2983.08', '1607.98', '34.2', '915.77', '5883.6'),
('Minneapolis', 'MN', '10', NULL, NULL, '1.2', NULL, NULL),
('Raleigh', 'NC', '10', NULL, NULL, '1.2', NULL, NULL),
('Lyon', NULL, '12', NULL, NULL, '28.8', NULL, NULL),
('Buffalo', 'NY', '10', NULL, NULL, '1.2', NULL, NULL),
('Baltimore', 'MD', '10', NULL, NULL, '1.2', NULL, NULL),
('Vancouver', NULL, '8', '2889.11', '2596.67', '22.79918864', '1272.43', '7535.95'),
('Auckland', NULL, '855', NULL, NULL, NULL, NULL, NULL),
('Denver', 'CO', '10', NULL, NULL, '1.2', NULL, NULL),
('Perth', NULL, '11', NULL, NULL, '15.07733333', NULL, NULL),
('Canberra', NULL, '11', '2774.64', '3195.77', '15.07733333', '1019.84', '3187.55'),
('Helsinki', NULL, '801', NULL, NULL, NULL, NULL, NULL),
('Galway', NULL, '18', NULL, NULL, '20.42135293', NULL, NULL),
('Montpellier', NULL, '12', '2732.49', '1540', '28.8', '532.5', '2887.5'),
('Brussels', NULL, '761', NULL, NULL, NULL, NULL, NULL),
('San Diego', 'CA', '10', NULL, NULL, '1.2', NULL, NULL),
('Gent', NULL, '761', NULL, NULL, NULL, NULL, NULL),
('Eindhoven', NULL, '5', NULL, NULL, '22.2', NULL, NULL),
('Melbourne', NULL, '11', '2846.37', '2805.23', '15.07733333', '1022.14', '5437.75'),
('Florence', NULL, '14', '2773.02', '1363.42', '34.2', '705.75', '4158.93'),
('The Hague (Den Haag)', NULL, '5', NULL, NULL, '22.2', NULL, NULL),
('Munich', NULL, '4', '2883.7', '2673.18', '42.88', '1039.24', '8780.13'),
('Toulouse', NULL, '12', NULL, NULL, '28.8', NULL, NULL),
('Leiden', NULL, '5', NULL, NULL, '22.2', NULL, NULL),
('Tampere', NULL, '801', NULL, NULL, NULL, NULL, NULL),
('Atlanta', 'GA', '10', NULL, NULL, '1.2', NULL, NULL),
('Antwerp', NULL, '761', NULL, NULL, NULL, NULL, NULL),
('Delft', NULL, '5', NULL, NULL, '22.2', NULL, NULL),
('Newcastle', NULL, '11', NULL, NULL, '15.07733333', NULL, NULL),
('Brisbane', NULL, '11', NULL, NULL, '15.07733333', NULL, NULL),
('Nashville', 'TN', '10', NULL, NULL, '1.2', NULL, NULL),
('Gold Coast', NULL, '11', NULL, NULL, '15.07733333', NULL, NULL),
('Colorado Springs', 'CO', '10', NULL, NULL, '1.2', NULL, NULL),
('Hamburg', NULL, '4', '2888.75', '2578.83', '42.88', '762.66', '4949.29'),
('Groningen', NULL, '5', NULL, NULL, '22.2', NULL, NULL),
('Columbus', 'OH', '10', NULL, NULL, '1.2', NULL, NULL),
('Halifax', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Genoa', NULL, '14', NULL, NULL, '34.2', NULL, NULL),
('Orlando', 'FL', '10', NULL, NULL, '1.2', NULL, NULL),
('Christchurch', NULL, '855', NULL, NULL, NULL, NULL, NULL),
('Saint Louis', 'MO', '10', NULL, NULL, '1.2', NULL, NULL),
('Sliema', NULL, '17', '2642.57', '1212.33', '15.4', '821.85', '4216.67'),
('Rome', NULL, '14', '2688.92', '1449.98', '34.2', '836.47', '4681.25'),
('Kansas City', 'MO', '10', NULL, NULL, '1.2', NULL, NULL),
('Victoria', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Calgary', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Frankfurt', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Bristol', NULL, '9', '2748.94', '2284.21', '31.1', '919.17', '4136.97'),
('Rotterdam', NULL, '5', NULL, NULL, '22.2', NULL, NULL),
('Milwaukee', 'WI', '10', NULL, NULL, '1.2', NULL, NULL),
('Lille', NULL, '12', NULL, NULL, '28.8', NULL, NULL),
('Las Vegas', 'NV', '10', NULL, NULL, '1.2', NULL, NULL),
('Wellington', NULL, '855', NULL, NULL, NULL, NULL, NULL),
('Hobart', NULL, '11', NULL, NULL, '15.07733333', NULL, NULL),
('Edinburgh', NULL, '9', '2648.75', '2175.75', '31.1', '815.6', '3759.59'),
('Edmonton', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Bologna', NULL, '14', NULL, NULL, '34.2', NULL, NULL),
('Graz', NULL, '13', NULL, NULL, '26.4', NULL, NULL),
('Dubai', NULL, '907', NULL, NULL, NULL, NULL, NULL),
('Gothenburg', NULL, '1', '2750.34', '2133.84', '46.19636364', '788.21', '4525.77'),
('Tampa', 'FL', '10', NULL, NULL, '1.2', NULL, NULL),
('Cambridge', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Brighton', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Heidelberg', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Stuttgart', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Ottawa', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Dusseldorf', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Dallas', 'TX', '10', NULL, NULL, '1.2', NULL, NULL),
('Austin', 'TX', '10', NULL, NULL, '1.2', NULL, NULL),
('Phoenix', 'AZ', '10', NULL, NULL, '1.2', NULL, NULL),
('Turin', NULL, '14', NULL, NULL, '34.2', NULL, NULL),
('Oxford', NULL, '9', '2569.95', '2181.53', '31.1', '1122.02', '7526.28'),
('Mannheim', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Adelaide', NULL, '11', NULL, NULL, '15.07733333', NULL, NULL),
('Vienna', NULL, '13', '2598.17', '1925.86', '26.4', '736.68', '5386.86'),
('Nuremberg', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Manchester', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('San Antonio', 'TX', '10', NULL, NULL, '1.2', NULL, NULL),
('Louisville', 'KY', '10', NULL, NULL, '1.2', NULL, NULL),
('Berlin', NULL, '4', '2584.8', '2309.15', '42.88', '775.85', '4852.57'),
('Bonn', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Cologne', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Montreal', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Indianapolis', 'IN', '10', NULL, NULL, '1.2', NULL, NULL),
('Salt Lake City', 'UT', '10', NULL, NULL, '1.2', NULL, NULL),
('Newcastle upon Tyne', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Bremen', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Houston', 'TX', '10', NULL, NULL, '1.2', NULL, NULL),
('Madison', 'WI', '10', NULL, NULL, '1.2', NULL, NULL),
('Leicester', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Derby', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Taipei', NULL, '916', NULL, NULL, NULL, NULL, NULL),
('Dundee', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Abu Dhabi', NULL, '907', NULL, NULL, NULL, NULL, NULL),
('Leipzig', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Birmingham', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Karlsruhe', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Hanover', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Glasgow', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Beirut', NULL, '832', NULL, NULL, NULL, NULL, NULL),
('Doha', NULL, '869', NULL, NULL, NULL, NULL, NULL),
('Leeds', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Dresden', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Liverpool', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Nicosia', NULL, '786', NULL, NULL, NULL, NULL, NULL),
('Aachen', NULL, '4', NULL, NULL, '42.88', NULL, NULL),
('Limassol', NULL, '786', NULL, NULL, NULL, NULL, NULL),
('Cardiff', NULL, '9', '2376.77', '2059.36', '31.1', '703.87', '2810.32'),
('Al Khobar', NULL, '877', NULL, NULL, NULL, NULL, NULL),
('Naples', NULL, '14', NULL, NULL, '34.2', NULL, NULL),
('Southampton', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Winnipeg', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Barcelona', NULL, '7', '2278.82', '1420.39', '24', '835.19', '3709.19'),
('Sheffield', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('London', NULL, '8', NULL, NULL, '22.79918864', NULL, NULL),
('Manama', NULL, '757', NULL, NULL, NULL, NULL, NULL),
('San Jose', NULL, '783', NULL, NULL, NULL, NULL, NULL),
('Little Rock', 'AR', '10', NULL, NULL, '1.2', NULL, NULL),
('Athens', NULL, '806', NULL, NULL, NULL, NULL, NULL),
('Madrid', NULL, '7', '2273.91', '1597.22', '24', '810.72', '4035.97'),
('Belfast', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Amman', NULL, '824', NULL, NULL, NULL, NULL, NULL),
('Kingston upon Hull', NULL, '9', NULL, NULL, '31.1', NULL, NULL),
('Thessaloniki', NULL, '806', NULL, NULL, NULL, NULL, NULL),
('Palermo', NULL, '14', NULL, NULL, '34.2', NULL, NULL),
('Panama City', NULL, '863', NULL, NULL, NULL, NULL, NULL),
('Bangkok', NULL, '897', NULL, NULL, NULL, NULL, NULL),
('Ljubljana', NULL, '883', NULL, NULL, NULL, NULL, NULL),
('Sharjah', NULL, '907', NULL, NULL, NULL, NULL, NULL),
('Valencia', NULL, '7', '2007.1', '1337.08', '24', '573.12', '2009.05'),
('Montevideo', NULL, '908', NULL, NULL, NULL, NULL, NULL),
('Seville (Sevilla)', NULL, '7', NULL, NULL, '24', NULL, NULL),
('Lisbon', NULL, '6', '1937.78', '914.81', '33.45', '734.47', '3283.41'),
('Tallinn', NULL, '798', NULL, NULL, NULL, NULL, NULL),
('Alicante', NULL, '7', '2030.48', '1277.7', '24', '457.81', '2150'),
('Patras', NULL, '806', NULL, NULL, NULL, NULL, NULL),
('Heraklion', NULL, '806', NULL, NULL, NULL, NULL, NULL),
('Muscat', NULL, '861', NULL, NULL, NULL, NULL, NULL),
('Pattaya', NULL, '897', NULL, NULL, NULL, NULL, NULL),
('Ad Dammam', NULL, '877', NULL, NULL, NULL, NULL, NULL),
('Porto', NULL, '6', '1881.76', '791.38', '33.45', '594.39', '2088.55'),
('Malaga', NULL, '7', NULL, NULL, '24', NULL, NULL),
('Jeddah (Jiddah)', NULL, '877', NULL, NULL, NULL, NULL, NULL),
('Tartu', NULL, '798', NULL, NULL, NULL, NULL, NULL),
('Zagreb', NULL, '784', NULL, NULL, NULL, NULL, NULL),
('Split', NULL, '784', NULL, NULL, NULL, NULL, NULL),
('Rijeka', NULL, '784', NULL, NULL, NULL, NULL, NULL),
('Santiago', NULL, '777', NULL, NULL, NULL, NULL, NULL),
('Coimbra', NULL, '6', NULL, NULL, '33.45', NULL, NULL),
('Riga', NULL, '831', NULL, NULL, NULL, NULL, NULL),
('Shanghai', NULL, '778', NULL, NULL, NULL, NULL, NULL),
('Ajman', NULL, '907', NULL, NULL, NULL, NULL, NULL),
('Riyadh', NULL, '877', NULL, NULL, NULL, NULL, NULL),
('Phuket', NULL, '897', NULL, NULL, NULL, NULL, NULL),
('Prague', NULL, '787', NULL, NULL, NULL, NULL, NULL),
('Bratislava', NULL, '882', NULL, NULL, NULL, NULL, NULL),
('Phnom Penh', NULL, '773', NULL, NULL, NULL, NULL, NULL),
('Santo Domingo', NULL, '792', NULL, NULL, NULL, NULL, NULL),
('Pretoria', NULL, '886', NULL, NULL, NULL, NULL, NULL),
('Guayaquil', NULL, '793', NULL, NULL, NULL, NULL, NULL),
('Chiang Mai', NULL, '897', NULL, NULL, NULL, NULL, NULL),
('Vilnius', NULL, '836', NULL, NULL, NULL, NULL, NULL),
('Johannesburg', NULL, '886', NULL, NULL, NULL, NULL, NULL),
('Osijek', NULL, '784', NULL, NULL, NULL, NULL, NULL),
('Brno', NULL, '787', NULL, NULL, NULL, NULL, NULL),
('Kaunas', NULL, '836', NULL, NULL, NULL, NULL, NULL),
('Moscow', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Sao Paulo', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Quito', NULL, '793', NULL, NULL, NULL, NULL, NULL),
('Guatemala City', NULL, '808', NULL, NULL, NULL, NULL, NULL),
('Beijing', NULL, '778', NULL, NULL, NULL, NULL, NULL),
('Rio de Janeiro', NULL, '2', '1692.3', '717.28', '18', '334.91', '1958.12'),
('Kosice', NULL, '882', NULL, NULL, NULL, NULL, NULL),
('Brasilia', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Cape Town', NULL, '886', NULL, NULL, NULL, NULL, NULL),
('Budapest', NULL, '814', NULL, NULL, NULL, NULL, NULL),
('Campinas', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Olomouc', NULL, '787', NULL, NULL, NULL, NULL, NULL),
('Baghdad', NULL, '819', NULL, NULL, NULL, NULL, NULL),
('Warsaw', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Lima', NULL, '866', NULL, NULL, NULL, NULL, NULL),
('Jakarta', NULL, '817', NULL, NULL, NULL, NULL, NULL),
('Kuala Lumpur', NULL, '840', NULL, NULL, NULL, NULL, NULL),
('Ostrava', NULL, '787', NULL, NULL, NULL, NULL, NULL),
('Shenzhen', NULL, '778', NULL, NULL, NULL, NULL, NULL),
('Nairobi', NULL, '826', NULL, NULL, NULL, NULL, NULL),
('Irbil', NULL, '819', NULL, NULL, NULL, NULL, NULL),
('Penang', NULL, '840', NULL, NULL, NULL, NULL, NULL),
('Tehran', NULL, '818', NULL, NULL, NULL, NULL, NULL),
('Port Elizabeth', NULL, '886', NULL, NULL, NULL, NULL, NULL),
('Gdynia', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Vladivostok', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Chengdu', NULL, '778', NULL, NULL, NULL, NULL, NULL),
('Khartoum', NULL, '891', NULL, NULL, NULL, NULL, NULL),
('Sofia', NULL, '769', NULL, NULL, NULL, NULL, NULL),
('Saint Petersburg', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Gdansk', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Recife', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Wroclaw', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Guangzhou', NULL, '778', NULL, NULL, NULL, NULL, NULL),
('Manila', NULL, '867', NULL, NULL, NULL, NULL, NULL),
('Hanoi', NULL, '912', NULL, NULL, NULL, NULL, NULL),
('Krakow (Cracow)', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Natal', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Durban', NULL, '886', NULL, NULL, NULL, NULL, NULL),
('Porto Alegre', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Podgorica', NULL, '849', NULL, NULL, NULL, NULL, NULL),
('Belgrade', NULL, '879', NULL, NULL, NULL, NULL, NULL),
('Bucharest', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Constanta', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Debrecen', NULL, '814', NULL, NULL, NULL, NULL, NULL),
('Poznan', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Belo Horizonte', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Tirana', NULL, '748', NULL, NULL, NULL, NULL, NULL),
('Curitiba', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Sarajevo', NULL, '766', NULL, NULL, NULL, NULL, NULL),
('Istanbul', NULL, '903', NULL, NULL, NULL, NULL, NULL),
('Ho Chi Minh City', NULL, '912', NULL, NULL, NULL, NULL, NULL),
('Cebu', NULL, '867', NULL, NULL, NULL, NULL, NULL),
('Florianopolis', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Lodz', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Salvador', NULL, '2', NULL, NULL, '18', NULL, NULL),
('Casablanca', NULL, '850', NULL, NULL, NULL, NULL, NULL),
('Monterrey', NULL, '846', NULL, NULL, NULL, NULL, NULL),
('Szeged', NULL, '814', NULL, NULL, NULL, NULL, NULL),
('Cancun', NULL, '846', NULL, NULL, NULL, NULL, NULL),
('Bursa', NULL, '903', NULL, NULL, NULL, NULL, NULL),
('Nizhny Novgorod', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Mexico City', NULL, '846', NULL, NULL, NULL, NULL, NULL),
('Cluj-Napoca', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Banja Luka', NULL, '766', NULL, NULL, NULL, NULL, NULL),
('Varna', NULL, '769', NULL, NULL, NULL, NULL, NULL),
('Rabat', NULL, '850', NULL, NULL, NULL, NULL, NULL),
('Katowice', NULL, '868', NULL, NULL, NULL, NULL, NULL),
('Brasov', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Lagos', NULL, '858', NULL, NULL, NULL, NULL, NULL),
('Yekaterinburg', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Ankara', NULL, '903', NULL, NULL, NULL, NULL, NULL),
('Krasnoyarsk', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Iasi', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Plovdiv', NULL, '769', NULL, NULL, NULL, NULL, NULL),
('Novosibirsk', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Queretaro', NULL, '846', NULL, NULL, NULL, NULL, NULL),
('Rostov-na-donu', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Timisoara', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Samara', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Kazan', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Minsk', NULL, '760', NULL, NULL, NULL, NULL, NULL),
('Kaliningrad', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Arad', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Kiev', NULL, '906', NULL, NULL, NULL, NULL, NULL),
('Skopje', NULL, '3', '1359.82', '694.56', '39', '200.87', '1061.36'),
('Buenos Aires', NULL, '753', NULL, NULL, NULL, NULL, NULL),
('Novi Sad', NULL, '879', NULL, NULL, NULL, NULL, NULL),
('Dhaka', NULL, '758', NULL, NULL, NULL, NULL, NULL),
('Guadalajara', NULL, '846', NULL, NULL, NULL, NULL, NULL),
('Colombo', NULL, '889', NULL, NULL, NULL, NULL, NULL),
('Krasnodar', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Voronezh', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Izmir', NULL, '903', NULL, NULL, NULL, NULL, NULL),
('Perm', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Odessa', NULL, '906', NULL, NULL, NULL, NULL, NULL),
('Oradea', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Chelyabinsk', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Ulaanbaatar', NULL, '848', NULL, NULL, NULL, NULL, NULL),
('Saratov', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Antalya', NULL, '903', NULL, NULL, NULL, NULL, NULL),
('Asuncion', NULL, '865', NULL, NULL, NULL, NULL, NULL),
('Yerevan', NULL, '754', NULL, NULL, NULL, NULL, NULL),
('Chisinau', NULL, '870', NULL, NULL, NULL, NULL, NULL),
('Tomsk', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Nis', NULL, '879', NULL, NULL, NULL, NULL, NULL),
('Algiers', NULL, '749', NULL, NULL, NULL, NULL, NULL),
('Izhevsk', NULL, '872', NULL, NULL, NULL, NULL, NULL),
('Dnipro', NULL, '906', NULL, NULL, NULL, NULL, NULL),
('Astana', NULL, '825', NULL, NULL, NULL, NULL, NULL),
('Craiova', NULL, '871', NULL, NULL, NULL, NULL, NULL),
('Kharkiv', NULL, '906', NULL, NULL, NULL, NULL, NULL),
('Bogota', NULL, '780', NULL, NULL, NULL, NULL, NULL),
('Cairo', NULL, '794', NULL, NULL, NULL, NULL, NULL),
('Lviv', NULL, '906', NULL, NULL, NULL, NULL, NULL),
('Kathmandu', NULL, '854', NULL, NULL, NULL, NULL, NULL),
('Baku', NULL, '755', NULL, NULL, NULL, NULL, NULL),
('Almaty', NULL, '825', NULL, NULL, NULL, NULL, NULL),
('Gurgaon', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Zaporizhzhya', NULL, '906', NULL, NULL, NULL, NULL, NULL),
('Mumbai', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Medellin', NULL, '780', NULL, NULL, NULL, NULL, NULL),
('Chandigarh', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Alexandria', NULL, '794', NULL, NULL, NULL, NULL, NULL),
('Bishkek', NULL, '829', NULL, NULL, NULL, NULL, NULL),
('Tunis', NULL, '902', NULL, NULL, NULL, NULL, NULL),
('Bangalore', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Pristina', NULL, '917', NULL, NULL, NULL, NULL, NULL),
('Pune', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Delhi', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Noida', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Tbilisi', NULL, '804', NULL, NULL, NULL, NULL, NULL),
('Cali', NULL, '780', NULL, NULL, NULL, NULL, NULL),
('Tashkent', NULL, '909', NULL, NULL, NULL, NULL, NULL),
('Caracas', NULL, '911', NULL, NULL, NULL, NULL, NULL),
('Thane', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Jaipur', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Chennai', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Hyderabad', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Indore', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Ahmedabad', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Kolkata', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Guwahati', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Vadodara', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Lucknow (Lakhnau)', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Mangalore', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Coimbatore', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Surat', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Navi Mumbai', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Kochi', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Bhopal', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Bhubaneswar', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Mysore', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Lahore', NULL, '862', NULL, NULL, NULL, NULL, NULL),
('Islamabad', NULL, '862', NULL, NULL, NULL, NULL, NULL),
('Vijayawada', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Visakhapatnam', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Karachi', NULL, '862', NULL, NULL, NULL, NULL, NULL),
('Thiruvananthapuram', NULL, '816', NULL, NULL, NULL, NULL, NULL),
('Rawalpindi', NULL, '862', NULL, NULL, NULL, NULL, NULL),
('Malmo', NULL, '1', '2546.95', '2026.2', '46.19636364', '621.53', '2720.56'),
('Solna', NULL, '1', '2698.48', '3033.38', '46.19636364', '886.68', '5950.09'),
('Braga', NULL, '6', '1707.86', '862.27', '33.45', '388.33', '1071.8'),
('Cascais', NULL, '6', '1882.68', '766.8', '33.45', '866.67', '3700'),
('Lagos', NULL, '6', '1861.12', '700', '33.45', '575', '1750'),
('Faro', NULL, '6', '1790.34', '608.33', '33.45', '460.12', '1925'),
('Goiania', NULL, '2', '1208.25', '682.18', '18', '165.61', '1113.3'),
('Palma', NULL, '7', '2330.3', '1191.91', '24', '757.15', '2821.88'),
('Nice', NULL, '12', '2877.02', '2017', '28.8', '688', '4593.34'),
('Santa Cruz de Tenerife', NULL, '7', '2003.96', '1093.75', '24', '522.56', '1741.67');

INSERT INTO city 
    (id, name, country, safetyTheEconomistSafeCityIndex, safetyNumbeoCrimeCityIndex)
    VALUES 
('49', 'Stockholm', '1', '86.5', '44.4'),
('377', 'Malmo', '1', '86.5', '53.48'),
('110', 'Gothenburg', '1', '86.5', '45.2'),
('378', 'Solna', '1', '86.5', '40.52'),
('191', 'Porto', '6', '73.175', '36.87'),
('183', 'Lisbon', '6', '73.175', '27.62'),
('379', 'Braga', '6', '73.175', '43.4'),
('380', 'Cascais', '6', '73.175', '21.83'),
('381', 'Lagos', '6', '73.175', '20.96'),
('382', 'Faro', '6', '73.175', '29.93'),
('122', 'Oxford', '9', '85.7', NULL),
('158', 'Cardiff', '9', '85.7', '36.15'),
('105', 'Edinburgh', '9', '85.7', '30.53'),
('98', 'Bristol', '9', '85.7', '36.9'),
('31', 'London', '9', '85.7', '52.48'),
('125', 'Vienna', '13', '84.95', '23.01'),
('29', 'Toronto', '8', '87.8', '38.37'),
('57', 'Vancouver', '8', '87.8', '36.29'),
('222', 'Rio de Janeiro', '2', '60.9', '77.41'),
('383', 'Goiania', '2', '60.9', '68.2'),
('302', 'Skopje', '3', '65.05', '44.73'),
('12', 'New York', '10', '85.5', '44.44'),
('22', 'Seattle', '10', '85.5', '46.5'),
('130', 'Berlin', '4', '85.725', '41.01'),
('84', 'Hamburg', '4', '85.725', '43.98'),
('72', 'Munich', '4', '85.725', '17.39'),
('34', 'Amsterdam', '5', '88', '33.1'),
('48', 'Utrecht', '5', '88', '28.53'),
('170', 'Madrid', '7', '81.4', '30.24'),
('163', 'Barcelona', '7', '81.2', '44.25'),
('384', 'Palma', '7', '81.3', '31.79'),
('180', 'Valencia', '7', '81.3', '25.14'),
('185', 'Alicante', '7', '81.3', '27.35'),
('69', 'Melbourne', '11', '87.3', '43.92'),
('35', 'Sydney', '11', '87.9', '33.9'),
('61', 'Canberra', '11', '87.6', '19.32'),
('60', 'Perth', '11', '87.6', '42.96'),
('124', 'Adelaide', '11', '87.6', '28.69'),
('104', 'Hobart', '11', '87.6', '33.48'),
('385', 'Nice', '12', '70.83333333', '40.94'),
('64', 'Montpellier', '12', '70.83333333', '51.59'),
('26', 'Paris', '12', '82.4', '51.76'),
('2', 'Zurich', '15', '84.5', '16.83'),
('51', 'Milan', '14', '78.1', '42.56'),
('70', 'Florence', '14', '77.25', '37.42'),
('93', 'Rome', '14', '76.4', '51.88'),
('92', 'Sliema', '17', '72.37', '28.87'),
('38', 'Dublin', '18', '85.7', '49.2'),
('386', 'Santa Cruz de Tenerife', '7', '81.3', '25.44')
    ON DUPLICATE KEY UPDATE 
	safetyTheEconomistSafeCityIndex = VALUES(safetyTheEconomistSafeCityIndex),
    safetyNumbeoCrimeCityIndex = VALUES(safetyNumbeoCrimeCityIndex);