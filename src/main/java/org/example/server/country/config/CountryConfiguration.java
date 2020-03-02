package org.example.server.country.config;

import com.wix.mysql.EmbeddedMysql;
import com.wix.mysql.config.MysqldConfig;
import com.wix.mysql.config.SchemaConfig;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.logging.Logger;

import static com.wix.mysql.ScriptResolver.classPathScript;
import static com.wix.mysql.distribution.Version.v5_7_19;
import static java.lang.String.format;

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

    public static EmbeddedMysql embeddedMysql;

    public CountryConfiguration() {
        logger = Logger.getLogger(getClass().getName());
        embeddedMysql();
    }

    /**
     * Creates an in-memory "rewards" database populated with test data for fast testing
     */
    @Bean
    public DataSource dataSource() throws ClassNotFoundException {
        logger.info("dataSource() invoked");

        DataSource dataSource = createDataSource();
        logger.info("dataSource = " + dataSource);

        // Sanity check
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> countries = jdbcTemplate.queryForList("SELECT * FROM country;");
        logger.info("System has " + countries.size() + " countries.");

        return dataSource;
    }

    private DataSource createDataSource() throws ClassNotFoundException {
        final String url = format("jdbc:mysql://localhost:%d/%s",
                embeddedMysql.getConfig().getPort(),
                "test_database");

        return DataSourceBuilder.create()
                .username(embeddedMysql.getConfig().getUsername())
                .password(embeddedMysql.getConfig().getPassword())
                .driverClassName(Class.forName("com.mysql.cj.jdbc.Driver").getName())
                .url(url)
                .build();
    }

    //TODO: create a TestSuite for all IT that use the Configuration class and _tearDownAfterClass the embeddedMysql there. Tried tearing down with @Bean (destroyMethod = stop) in Configuration class, but no success.
    public static void embeddedMysql() {
        MysqldConfig config = MysqldConfig.aMysqldConfig(v5_7_19)
                .withPort(3307)
                .withTimeZone(TimeZone.getTimeZone(ZoneId.of("UTC")))
                .withUser("test", "test")
                .build();

        SchemaConfig schemaConfig = SchemaConfig.aSchemaConfig("test_database")
                .withScripts(classPathScript("sql/DDLTest.sql"))
                .withScripts(classPathScript("sql/DMLTest.sql"))
                .build();

        embeddedMysql = EmbeddedMysql.anEmbeddedMysql(config)
                .addSchema(schemaConfig)
                .start();

        logger.info("embeddedMysql = " + embeddedMysql);
    }
}