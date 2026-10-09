package app.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static ConexionBD instancia;
    private Connection conexion;
    
    private final String URL = "jdbc:sqlserver://BOKEX:1433;databaseName=ClinicaLaLuzDB;integratedSecurity=true;encrypt=true;trustServerCertificate=true;";

    private ConexionBD() {
        conectar();
    }

    private void conectar() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.conexion = DriverManager.getConnection(URL);
            System.out.println("¡CONEXIÓN EXITOSA A SQL SERVER!");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: No se encontró el Driver JDBC -> " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("--- ERROR SQL DETALLADO ---");
            System.err.println("Mensaje: " + e.getMessage());
            System.err.println("Código de error: " + e.getErrorCode());
            e.printStackTrace();
        }
    }

    public static synchronized ConexionBD obtenerInstancia() {
        if (instancia == null) {
            instancia = new ConexionBD();
        }
        return instancia;
    }

    public Connection obtenerConexion() {
        try {
            if (conexion == null || conexion.isClosed()) {
                conectar();
            }
        } catch (SQLException e) {
            System.err.println("Error al validar/reabrir la conexión: " + e.getMessage());
        }
        return conexion;
    }
}