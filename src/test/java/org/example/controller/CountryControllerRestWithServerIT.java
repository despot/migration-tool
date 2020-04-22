package org.example.controller;

import org.junit.Before;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.util.List;

import static org.junit.Assert.assertEquals;

/**
 * An integration test for the CountryController class.
 *
 * Use WebTestClient instead of MockMvc if you want to handle reactive streams (non-blocking approach). Check images here: https://howtodoinjava.com/spring-webflux/spring-webflux-tutorial/
 * Use RestTemplate over MockMvc when you have a deployed running server that listens to http requests. MockMvc is setting up a whole web application context (fake DispatcherServlet).
 *
 * In Order to run this, you need to run the Registration and Country Servers and uncomment the @Test part (it was commented as to not fail when all tests are run). This is not a needed test anyway as the acceptance tests can be done with Protractor/Selenium, but if you do need it, you need to start the Registration and Country server programmatically.
 */
public class CountryControllerRestWithServerIT {

    private RestTemplate restTemplate;

    @Before
    public void setUp() {
        restTemplate = new RestTemplate();
    }

//    @Test
    public void testCreateRetrieveWithFullMVC() {
        ResponseEntity<List> countryListResponseEntity =
                restTemplate.getForEntity("http://localhost:2222/countries/getAll", List.class);

        //Verify request succeed
        assertEquals(200, countryListResponseEntity.getStatusCodeValue());
        assertEquals(4, countryListResponseEntity.getBody().size());
    }
}
