package org.example.service;

import org.example.dao.CountryRepository;
import org.example.model.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CountryServiceImpl implements CountryService {

    @Autowired
    private CountryRepository countryRepository;

    @Override
    @Transactional
    public List<Country> getAllCountries() {
        return (List<Country>) countryRepository.findAll();
    }
}
