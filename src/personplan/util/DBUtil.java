package personplan.util;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;



public class DBUtil {
	private static final String jdbcUrl="jdbc:mysql://localhost:3306/work?useUnicode=true&characterEncoding=UTF-8";
	private static final String dbUser="root";
	private static final String dbPwd="123456";
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static Connection getConnection() throws java.sql.SQLException{
		return java.sql.DriverManager.getConnection(jdbcUrl, dbUser, dbPwd);
	}
}
