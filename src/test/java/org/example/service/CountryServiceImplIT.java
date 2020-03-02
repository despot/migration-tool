package org.example.service;

import org.example.model.Country;
import org.example.server.country.config.CountryConfiguration;
import org.junit.AfterClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.example.server.country.config.CountryConfiguration.embeddedMysql;

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
        assertThat(countryListActual.size()).isEqualTo(4);
    }

    @AfterClass
    public static void _tearDownAfterClass() {
        if (null != embeddedMysql) {
            embeddedMysql.stop();
        }
    }

}
