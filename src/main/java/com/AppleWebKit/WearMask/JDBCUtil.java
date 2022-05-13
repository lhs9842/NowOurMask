package com.AppleWebKit.WearMask;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBCUtil {
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/wearmask";
	private static final String USER= "Mask";
	private static final String PW = "wearMask";
	
	public static Connection getConnect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(URL, USER, PW);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}