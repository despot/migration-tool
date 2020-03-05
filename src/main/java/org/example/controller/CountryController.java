package org.example.controller;

import org.example.model.Country;
import org.example.service.CountryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.logging.Logger;

@RestController
@RequestMapping("countries")
public class CountryController {

    protected Logger logger = Logger.getLogger(CountryController.class.getName());
    protected CountryService countryService;

    @Autowired
    public CountryController(CountryService countryService) {
        this.countryService = countryService;
    }

    @CrossOrigin
    @GetMapping(path = "/getAll")
    public List<Country> getAll() {
        logger.info("Country-service getAll invoked");

        return countryService.getAllCountries();
        //TODO: when there are custom thrown exceptions in the service layer, check the server.error.whitelabel.enabled=true automated spring boot way of handling exceptions by checking to see what happens on the client side when an Exception occurs. don't throw ResponseStatusException inline as you might handle them in a different way everywhere and you see the exception transformation in the controller (crosscutting concern). The last resort is defining global place for transforming exceptions and sending them to the client (@ControllerAdvice public class RestResponseEntityExceptionHandler extends ResponseEntityExceptionHandler).
    }
}
