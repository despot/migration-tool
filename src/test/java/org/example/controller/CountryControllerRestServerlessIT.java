package org.example.controller;

import org.example.server.country.config.CountryConfiguration;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

/**
 * An integration test for the CountryController class.
 *
 * Use WebTestClient instead of MockMvc if you want to handle reactive streams (non-blocking approach). Check images here: https://howtodoinjava.com/spring-webflux/spring-webflux-tutorial/
 * Use RestTemplate over MockMvc when you have a deployed running server that listens to http requests. MockMvc is setting up a whole web application context (fake DispatcherServlet).
 *
 */
@RunWith(SpringRunner.class)
@EnableAutoConfiguration
@SpringBootTest(classes = CountryConfiguration.class)
@AutoConfigureMockMvc
public class CountryControllerRestServerlessIT {

    @Autowired
    private MockMvc mockMvc;

    /**
     * To build the outcome of the test (in case you add other countries), build it automatically by using https://docs.google.com/spreadsheets/d/1oh27c8lrV_DUp75bUxT1Lsf9JS2BTNOeNotGs-0760A/edit#gid=0
     */
    @Test
    public void testCreateRetrieveWithMockMVC() throws Exception {
        this.mockMvc.perform(get("/countries/getAll"))
                .andExpect(jsonPath("$[*].name").value(
                        containsInAnyOrder("Sweden","Brazil","Macedonia","Germany","Netherlands","Portugal","Spain","Canada","United Kingdom","United States","Australia","France","Austria","Italy","Switzerland","Malta","Ireland")))
        ;
    }
}
