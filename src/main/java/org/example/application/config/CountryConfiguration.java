package org.example.application.config;

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
@ComponentScan({"org.example.service"})
@EntityScan({"org.example.model", "org.example.service"})
@EnableJpaRepositories("org.example.dao")
@PropertySource("classpath:db-config.properties")
public class CountryConfiguration {

    protected Logger logger;

    public static EmbeddedMysql embeddedMysql;

    public CountryConfiguration() {
        logger = Logger.getLogger(getClass().getName());
    }

    /**
     * Creates an in-memory "rewards" database populated with test data for fast testing
     */
    @Bean
    public DataSource dataSource() throws ClassNotFoundException {
        logger.info("dataSource() invoked");

        // Create an in-memory H2 relational database containing some demo countries.
//        DataSource dataSource = (new EmbeddedDatabaseBuilder()).addScript("classpath:sql/DDLTest.sql")
////                .addScript("classpath:sql/DMLTest.sql")
//                .build();

        DataSource dataSource = createDataSource();

                logger.info("dataSource = " + dataSource);

        // Sanity check
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> countries = jdbcTemplate.queryForList("SELECT * FROM country;");
        logger.info("System has " + countries.size() + " countries.");

        return dataSource;
    }

    public DataSource createDataSource() throws ClassNotFoundException {
//        final EmbeddedMysql embeddedMysql = _setupBeforeClass(); // make sure embeddedMySql is started.
        _setupBeforeClass(); // make sure embeddedMySql is started.

//        Map<String, String> params = new HashMap<>();
//        params.put("profileSQL", String.valueOf(false));
//        params.put("generateSimpleParameterMetadata", String.valueOf(true));
//
//        final String url = String.format("jdbc:mysql://localhost:%d/%s?%s",
//                embeddedMysql.getConfig().getPort(),
//                "access_api",
//                Joiner.on("&").withKeyValueSeparator("=").join(params));
//        final String url = String.format("jdbc:mysql://localhost:%d/%s?%s",
//                embeddedMysql.getConfig().getPort(),
//                "access_api",
//                Joiner.on("&").withKeyValueSeparator("=").join(params));

        final String url = format("jdbc:mysql://localhost:%d/%s",
                embeddedMysql.getConfig().getPort(),
                "test_database");

//        dataSourceBuilder.driverClassName(com.mysql.jdbc.Driver.class.getName());
//        dataSourceBuilder.driverClassName(Class.forName("com.mysql.jdbc.Driver").getName());
        return DataSourceBuilder.create()
                .username(embeddedMysql.getConfig().getUsername())
                .password(embeddedMysql.getConfig().getPassword())
                .driverClassName(Class.forName("com.mysql.cj.jdbc.Driver").getName())
                .url(url)
                .build();
    }

    public static void _setupBeforeClass() {
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
    }

    //TODO: think about adding CountryServiceImplIT._tearDownAfterClass() method in CountryConfiguration through a method after destruction or similar, as you need to kill the embeddedMysql from there.
}