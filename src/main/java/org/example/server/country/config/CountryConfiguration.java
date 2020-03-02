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

//    @Autowired //TODO: Error creating bean with name 'org.springframework.cloud.autoconfigure.RefreshAutoConfiguration$JpaInvokerConfiguration': Invocation of init method failed; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'org.springframework.boot.autoconfigure.jdbc.DataSourceInitializerInvoker': Invocation of init method failed; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'countryConfiguration': Unsatisfied dependency expressed through field 'embeddedMysql'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'embeddedMysql' defined in org.example.server.country.config.CountryConfiguration: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [com.wix.mysql.EmbeddedMysql]: Circular reference involving containing bean 'countryConfiguration' - consider declaring the factory method as static for independence from its containing instance. Factory method 'embeddedMysql' threw exception; nested exception is java.lang.RuntimeException: java.io.IOException: java.lang.RuntimeException: mysql start failed with error: [ERROR] Can't start server: Bind on TCP/IP port: No such file or directory
//    private EmbeddedMysql embeddedMysql;
    public static EmbeddedMysql embeddedMysql;

    public CountryConfiguration() {
        logger = Logger.getLogger(getClass().getName());
//        embeddedMysql = embeddedMysql();
    }

    /**
     * Creates an in-memory "rewards" database populated with test data for fast testing
     */
    @Bean
//    @Autowired
//    public DataSource dataSource(EmbeddedMysql embeddedMysql) throws ClassNotFoundException {
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

//    private DataSource createDataSource(EmbeddedMysql embeddedMysql) throws ClassNotFoundException {
    private DataSource createDataSource() throws ClassNotFoundException {
        embeddedMysql(); // make sure embeddedMySql is started.


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

    //TODO: create a TestSuite for all IT that use the Configuration class and _tearDownAfterClass the embeddedMysql there. Tried tearing down with @Bean (destroyMethod = stop) in Configuration class, but no success.
//    @Bean(destroyMethod = "stop")
//    @Scope(ConfigurableBeanFactory.SCOPE_SINGLETON)
//    public EmbeddedMysql embeddedMysql() {
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

//        EmbeddedMysql embeddedMysql = EmbeddedMysql.anEmbeddedMysql(config)
        embeddedMysql = EmbeddedMysql.anEmbeddedMysql(config)
                .addSchema(schemaConfig)
                .start();

        logger.info("embeddedMysql = " + embeddedMysql);

//        return embeddedMysql;
    }

//    @PreDestroy
////    @Autowired
////    public void _tearDownEmbeddedMysql(EmbeddedMysql embeddedMysql) {
//    public void _tearDownEmbeddedMysql() {
//        logger.info("PreDestroy _tearDownEmbeddedMysql invoked!");
//        EmbeddedMysql embeddedMysql = embeddedMysql(); //TODO: Destroy method on bean with name 'countryConfiguration' threw an exception: org.springframework.beans.factory.BeanCreationNotAllowedException: Error creating bean with name 'embeddedMysql': Singleton bean creation not allowed while singletons of this factory are in destruction (Do not request a bean from a BeanFactory in a destroy method implementation!)
//
//        if (null != embeddedMysql) {
//            embeddedMysql.stop();
//            logger.info("embeddedMysql stopped from PreDestroy _tearDownEmbeddedMysql invoked!");
//        }
//    }

//    @PreDestroy
//    public void _tearDownEmbeddedMysql() {
//        logger.info("PreDestroy _tearDownEmbeddedMysql invoked!");
//        if (null != embeddedMysql) {
//            embeddedMysql.stop();
//            logger.info("embeddedMysql stopped from PreDestroy _tearDownEmbeddedMysql invoked!");
//        }
//    }

}