drop table country if exists;

CREATE TABLE country (
  id BIGINT IDENTITY PRIMARY KEY ,
  name VARCHAR(45) NOT NULL,
  educationRankingsByPopulation DECIMAL(16,8) NULL);


