package util;


import org.apache.commons.dbcp2.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtils {
    private static DataSource ds = null;
    static {
        try {
            Properties prop = new Properties();
            prop.load(new DBUtils().getClass().getClassLoader().getResourceAsStream("jdbc.properties"));
            //得到数据源
            ds = BasicDataSourceFactory.createDataSource(prop);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    //获取数据库的连接对象
    public static Connection getConnection(){
        Connection conn = null;
        try {
            conn = ds.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
    public static void release(Connection conn, PreparedStatement pstmt){
        if (pstmt!=null){
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            pstmt=null;
        }
        if (conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            conn=null;
        }
    }
    public static void release(Connection conn, PreparedStatement pstmt, ResultSet rs){
        if (rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            rs=null;
        }
        release(conn,pstmt);
    }
}
