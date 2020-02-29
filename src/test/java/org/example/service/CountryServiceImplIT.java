package org.example.service;

import org.example.application.config.CountryConfiguration;
import org.example.model.Country;
import org.junit.AfterClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.example.application.config.CountryConfiguration.embeddedMysql;

@RunWith(SpringRunner.class)
@EnableAutoConfiguration
@SpringBootTest(classes = CountryConfiguration.class)
public class CountryServiceImplIT {

    @Autowired
    private CountryServiceImpl countryService;

    @Test
    public void getAllCountriesTest() {
        List<Country> countryListActual = countryService.getAllCountries();
        assertThat(countryListActual).isNotNull().isNotEmpty();
    }

    @Test
    public void getAllCountries_NumberOfCountriesTest() {
        List<Country> countryListActual = countryService.getAllCountries();
        assertThat(countryListActual.size()).isEqualTo(4);
    }

    //TODO: think about adding this method in CountryConfiguration through a method after destruction or similar, as you need to kill the embeddedMysql from there.
    @AfterClass
    public static void _tearDownAfterClass() {
        if (null != embeddedMysql) {
            embeddedMysql.stop();
        }
    }

}
