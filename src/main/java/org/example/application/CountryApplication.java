package org.example.application;

import org.example.application.config.CountryConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;

import java.util.logging.Logger;

/**
 * Run as a micro-service, registering with the Discovery Server (Eureka).
 * <p>
 * Note that the configuration for this application is imported from
 * {@link CountryConfiguration}. This is a deliberate separation of concerns.
 * <p>
 * This class declares no beans and current package contains no components for
 * ComponentScan to find.
 *
 * @author Despot
 */
@SpringBootApplication
@EnableDiscoveryClient
@Import(CountryConfiguration.class)
public class CountryApplication {

    protected Logger logger = Logger.getLogger(CountryApplication.class.getName());

    /**
     * Run the application using Spring Boot and an embedded servlet engine.
     *
     * @param args Program arguments - ignored.
     */
    public static void main(String[] args) {
        // Tell server to look for country-server.properties or country-server.yml
        System.setProperty("spring.config.name", "country-server");

        SpringApplication.run(CountryApplication.class, args);
    }
}