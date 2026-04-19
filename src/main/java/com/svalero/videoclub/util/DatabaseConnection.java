package com.svalero.videoclub.util;

import org.mariadb.jdbc.MariaDbPoolDataSource;
import javax.sql.DataSource;
import java.sql.SQLException;

public class DatabaseConnection {

    private static DataSource dataSource;

    public static DataSource getDataSource() throws SQLException {
        if (dataSource == null) {
            MariaDbPoolDataSource pool = new MariaDbPoolDataSource();
            pool.setUrl("jdbc:mariadb://localhost:3306/videoclub");
            pool.setUser("root");
            pool.setPassword("123456");
            dataSource = pool;
        }
        return dataSource;
    }
}