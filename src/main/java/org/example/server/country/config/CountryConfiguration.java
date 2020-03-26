package org.example.server.country.config;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 * The countries Spring configuration.
 *
 * @author Despot
 */
@Configuration
@ComponentScan({"org.example.service", "org.example.controller"})
@EntityScan({"org.example.model"})
@EnableJpaRepositories("org.example.dao")
@PropertySource("classpath:db-config.properties")
public class CountryConfiguration {

    protected static Logger logger;

    public CountryConfiguration() {
        logger = Logger.getLogger(getClass().getName());
    }

    /**
     * Creates an in-memory "rewards" database populated with test data for fast testing
     */
    @Bean
    public DataSource dataSource() throws ClassNotFoundException {
        logger.info("dataSource() invoked");

        // Create an in-memory H2 relational database containing some demo countries;
        DataSource dataSource = (new EmbeddedDatabaseBuilder())
                .addScript("classpath:sql/test/DDLTest.sql")
                .addScript("classpath:sql/test/DMLTest.sql").build();
        logger.info("dataSource = " + dataSource);

        // Sanity check
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> countries = jdbcTemplate.queryForList("SELECT * FROM country;");
        logger.info("System has " + countries.size() + " countries.");

        return dataSource;
    }
}