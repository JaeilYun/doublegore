package com.home.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.dao.annotation.PersistenceExceptionTranslationPostProcessor;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@EnableTransactionManagement
@PropertySource(value = { "classpath:/configs/config.properties" })
@EnableJpaRepositories(basePackages = "com.home.contents",
	entityManagerFactoryRef = "entityManager",
	transactionManagerRef = "transactionManager",
	includeFilters = {@ComponentScan.Filter(Repository.class)})
public class HibernateConfig {
	@Autowired
	private Environment environment;

	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(environment.getRequiredProperty("jdbc.driverClassName"));
		dataSource.setUrl(environment.getRequiredProperty("jdbc.url"));
		dataSource.setUsername(environment.getRequiredProperty("jdbc.username"));
		dataSource.setPassword(environment.getRequiredProperty("jdbc.password"));

		return dataSource;
	}

	@Bean(name = "entityManager")
	public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
		LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
		factory.setDataSource(dataSource());
		factory.setPackagesToScan(new String[] { "com.home.common", "com.home.contents"});
		factory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
		factory.setPersistenceUnitName("doublegore");
		factory.setJpaProperties(hibernateProperties());

		return factory;
	}

	@Bean
	public PersistenceExceptionTranslationPostProcessor exceptionTranslation() {
		return new PersistenceExceptionTranslationPostProcessor();
	}

	private Properties hibernateProperties() {
		Properties properties = new Properties();

		properties.setProperty("hibernate.dialect", environment.getRequiredProperty("hibernate.dialect"));
		properties.setProperty("hibernate.show_sql", environment.getRequiredProperty("hibernate.show_sql"));
		properties.setProperty("hibernate.format_sql", environment.getRequiredProperty("hibernate.format_sql"));
		properties.setProperty("hibernate.use_sql_comments", environment.getRequiredProperty("hibernate.use_sql_comments"));
		properties.setProperty("hibernate.id.new_generator_mappings", environment.getRequiredProperty("hibernate.id.new_generator_mappings"));
		properties.setProperty("hibernate.hbm2ddl.auto", environment.getRequiredProperty("hibernate.hbm2ddl.auto"));
		// lazy
		properties.setProperty("hibernate.enable_lazy_load_no_trans", environment.getRequiredProperty("hibernate.lazy_load"));

		return properties;
	}

	@Bean(name = "transactionManager")
	public PlatformTransactionManager transactionManagerJpa() {
		JpaTransactionManager transactionManager = new JpaTransactionManager();
		transactionManager.setEntityManagerFactory(entityManagerFactory().getObject());
		transactionManager.setPersistenceUnitName("transactionManager");
		return transactionManager;
	}
}
