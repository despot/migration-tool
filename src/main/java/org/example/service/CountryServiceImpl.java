package org.example.service;

import org.example.dao.CountryRepository;
import org.example.model.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import java.util.Random;

@Service
public class CountryServiceImpl implements CountryService {

    @Autowired
    private CountryRepository countryRepository;

    @Override
    @Transactional
    public List<Country> getAllCountries() {
        List<Country> countries = (List<Country>) countryRepository.findAll();
        if (null == countries) {//or use Optional.empty()
            return Collections.emptyList();
        }
        generateOneTenIndex(countries);
        return countries;
    }

//    @Override
//    @Transactional
//    public void generateOneTenIndex(List<Country> countries) {
        private void generateOneTenIndex(List<Country> countries) {
        //TODO: implement logic instead of mock logic below
        Random random = new Random();
        countries.forEach(country -> country.setOneTenIndex(new BigDecimal(random.nextInt(11-1)+1)));
    }
}
