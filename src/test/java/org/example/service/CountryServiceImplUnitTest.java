package org.example.service;

import org.example.dao.CountryRepository;
import org.example.model.Country;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.math.BigDecimal;
import java.util.Arrays;
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
        List<Country> list = Arrays.asList(
                new Country(1L,"Chad",BigDecimal.valueOf(1.23)),
                new Country(2L,"France", BigDecimal.valueOf(4.56)));

        when(countryRepository.findAll()).thenReturn(list);

        //test
        List<Country> countryListActual = countryServiceImpl.getAllCountries();

        assertEquals(2, countryListActual.size());
        verify(countryRepository, times(1)).findAll();
    }
}
