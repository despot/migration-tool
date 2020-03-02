package org.example.service;

import org.example.dao.CountryRepository;
import org.example.model.Country;
import org.example.objectMother.CountryMother;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;

public class CountryServiceImplUnitTest {

    @InjectMocks
    private CountryServiceImpl countryServiceImpl;

    @Mock
    private CountryRepository countryRepository;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void getAllCountriesTest()
    {
        when(countryRepository.findAll()).thenReturn(CountryMother.createACountryListWithoutOneTenIndex());

        List<Country> countryListActual = countryServiceImpl.getAllCountries();

        assertEquals(2, countryListActual.size());
        verify(countryRepository, times(1)).findAll();
    }

//    @Test
//    public void generateOneTenIndex()
//    {
//        List<Country> countries = CountryMother.createACountryListWithoutOneTenIndex();
//
//        countryServiceImpl.generateOneTenIndex(countries);
//        countries.forEach(country -> assertNotNull(country.getOneTenIndex()));
//    }
}
