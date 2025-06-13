/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Rifki Erlangga
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    // Database connection details are defined here
    private static final String URL = "jdbc:mysql://localhost:3306/simpasca";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    /**
     * Establishes and returns a connection to the database.
     *
     * @return a Connection object or null if the connection fails.
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // 1. Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. Establish the connection
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            // Optional: Print a success message for debugging
            // System.out.println("Koneksi ke database berhasil!");

        } catch (ClassNotFoundException e) {
            System.out.println("Driver tidak ditemukan: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Koneksi ke database gagal: " + e.getMessage());
        }
        
        // 3. Return the connection object
        return conn;
    }
}