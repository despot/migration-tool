package org.example.dao;

import org.example.model.Country;
import org.springframework.data.repository.CrudRepository;

/**
 * Repository for the Country object.
 *
 * @author Despot Jakimovski
 */
public interface CountryRepository extends CrudRepository<Country,Long> {
    
}
