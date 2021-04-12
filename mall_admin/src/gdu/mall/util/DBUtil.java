package gdu.mall.util;
import java.sql.*;

public class DBUtil {
	// DB �뿰寃� 硫붿냼�뱶 (�엯�젰媛믪� �뾾怨�, 由ы꽩媛믪� connection conn�씠 �맖)
   public static Connection getConnection() throws Exception{
      Class.forName("org.mariadb.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall","root","java1004");
      return conn;
   }
}