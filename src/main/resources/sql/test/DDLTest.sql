drop table country if exists;

CREATE TABLE country (
  id BIGINT IDENTITY PRIMARY KEY ,
  name VARCHAR(45) NOT NULL UNIQUE,
  parentalLeave DECIMAL(16,8) NULL,
  kindergardenPrices DECIMAL(16,8) NULL,
  internationalSchoolPrices DECIMAL(16,8) NULL,
  educationRankingsByPopulation DECIMAL(16,8) NULL,
  averageHighestAndLowestTemperatureDifference DECIMAL(16,8) NULL,
  averageYearlySunshineHours DECIMAL(16,8) NULL,
  hoursReturnTravelFromOriginToDestination DECIMAL(16,8) NULL,
  hoursReturnTravelFromOriginToDestination2 DECIMAL(16,8) NULL,
  priceEurOfTravelReturnFromOriginToDestination DECIMAL(16,8) NULL,
  priceEurOfTravelReturnFromOriginToDestination2 DECIMAL(16,8) NULL);


