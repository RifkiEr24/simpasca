// Simpan di: models/Model.java
package models;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public abstract class Model<E> {

    protected Connection con;
    protected Statement stmt;
    private String message;
    protected String table;
    protected String primaryKey = "id";

    // --- KONEKSI DATABASE ---
    public void connect() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/simpasca", "root", "");
            stmt = con.createStatement();
        } catch (ClassNotFoundException | SQLException e) {
            message = "Koneksi Gagal: " + e.getMessage();
            System.out.println(message);
        }
    }

    public void disconnect() {
        try {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            message = e.getMessage();
        }
    }

    protected abstract E toModel(ResultSet rs) throws SQLException;

    // --- METHOD UNTUK SELECT DATA ---
    public ArrayList<E> get() {
        ArrayList<E> res = new ArrayList<>();
        try {
            this.connect();
            String query = "SELECT * FROM " + table + " ORDER BY " + primaryKey + " DESC";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                res.add(toModel(rs));
            }
        } catch (SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
        return res;
    }

    public E find(Object pkValue) {
        try {
            connect();
            String query = "SELECT * FROM " + table + " WHERE " + primaryKey + " = '" + pkValue.toString() + "'";
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return toModel(rs);
            }
        } catch (SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
        return null;
    }

    public boolean insert() {
        connect();
        try {
            StringBuilder cols = new StringBuilder();
            StringBuilder values = new StringBuilder();
            
            for (Field field : this.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                if (isParentField(field.getName()) || field.getName().equals(this.primaryKey)) continue;

                Object value = field.get(this);
                if (value != null) {
                    cols.append(field.getName()).append(",");
                    values.append("'").append(formatValue(value)).append("',");
                }
            }
            cols.setLength(cols.length() - 1);
            values.setLength(values.length() - 1);
            
            String query = String.format("INSERT INTO %s (%s) VALUES (%s)", this.table, cols, values);
            stmt.executeUpdate(query);
            return true;
        } catch (IllegalAccessException | SQLException e) {
            this.message = e.getMessage();
            System.out.println("Insert Error: " + message);
            return false;
        } finally {
            disconnect();
        }
    }

    /**
     * Memperbarui record di database berdasarkan ID objek saat ini.
     */
    public boolean update() {
        connect();
        try {
            StringBuilder setClauses = new StringBuilder();
            Object pkValue = null;

            for (Field field : this.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                Object value = field.get(this);
                
                if (field.getName().equals(this.primaryKey)) {
                    pkValue = value;
                    continue;
                }
                if (isParentField(field.getName())) continue;

                if (value != null) {
                    setClauses.append(field.getName()).append("='").append(formatValue(value)).append("',");
                }
            }
            setClauses.setLength(setClauses.length() - 1);

            String query = String.format("UPDATE %s SET %s WHERE %s = '%s'", this.table, setClauses, this.primaryKey, pkValue);
            stmt.executeUpdate(query);
            return true;
        } catch (IllegalAccessException | SQLException e) {
            this.message = e.getMessage();
            System.out.println("Update Error: " + message);
            return false;
        } finally {
            disconnect();
        }
    }

    /**
     * Menghapus record dari database berdasarkan ID objek saat ini.
     */
    public boolean delete() {
        connect();
        try {
            // Mengambil nilai pk dari field objek saat ini
            Object pkValue = this.getClass().getDeclaredField(this.primaryKey).get(this);
            String query = String.format("DELETE FROM %s WHERE %s = '%s'", this.table, this.primaryKey, pkValue);
            stmt.executeUpdate(query);
            return true;
        } catch (NoSuchFieldException | IllegalAccessException | SQLException e) {
            this.message = e.getMessage();
            System.out.println("Delete Error: " + message);
            return false;
        } finally {
            disconnect();
        }
    }

    // Helper method untuk memformat value sesuai tipe datanya
    private String formatValue(Object value) {
        if (value instanceof Date) {
            return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(value);
        }
        return value.toString();
    }

    // Helper method untuk mengecek apakah sebuah field milik parent class `Model`
    private boolean isParentField(String fieldName) {
        for (Field parentField : Model.class.getDeclaredFields()) {
            if (parentField.getName().equals(fieldName)) {
                return true;
            }
        }
        return false;
    }
    
    public String getMessage() {
        return message;
    }
}