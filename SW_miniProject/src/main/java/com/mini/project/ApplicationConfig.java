package com.mini.project;

import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class ApplicationConfig implements ServletContextListener {

  // private static final Logger logger = LoggerFactory.getLogger(ApplicationConfig.class);

  /*
   * @Override public void contextInitialized(ServletContextEvent sce) {
   * logger.info("===== contextInitialized() start");
   * 
   * HikariConfig hikariConfig = new HikariConfig();
   * 
   * hikariConfig.setUsername("root"); hikariConfig.setPassword("0000");
   * hikariConfig.setJdbcUrl("jdbc:mariadb://127.0.0.1:3306/sw_miniproject");
   * hikariConfig.setConnectionTestQuery("select now() from dual");
   * hikariConfig.setMaximumPoolSize(10); // Connection Pool에서 갖고있을 Connection의 갯수
   * //hikariConfig.setLeakDetectionThreshold(30000); hikariConfig.setPoolName("Mariadb-HikariCP");
   * 
   * HikariDataSource ds = new HikariDataSource(hikariConfig);
   * sce.getServletContext().setAttribute("dataSource", ds);
   * logger.info("===== contextInitialized() end"); }
   * 
   * @Override public void contextDestroyed(ServletContextEvent sce) { }
   */

}
