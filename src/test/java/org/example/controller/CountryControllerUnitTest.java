package org.example.controller;

import org.example.model.Country;
import org.example.objectMother.CountryMother;
import org.example.service.CountryService;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;

public class CountryControllerUnitTest {
    @InjectMocks
    private CountryController countryController;

    @Mock
    private CountryService countryService;

    @Before
    public void init() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void getAllTest() {
        when(countryService.getAllCountries()).thenReturn(CountryMother.createACountryListComplete());

        List<Country> countryListActual = countryController.getAll();

        assertEquals(2, countryListActual.size());
        verify(countryService, times(1)).getAllCountries();
    }

}
