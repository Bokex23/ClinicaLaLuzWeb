package app.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static ConexionBD instancia;
    private Connection conexion;
    
    // URL actualizada para conectar con Azure SQL Database
    private final String URL = "jdbc:sqlserver://servidor-clinica.database.windows.net:1433;database=ClinicaLaLuzDB;user=adminclinica;password=Admin123;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";

    private ConexionBD() {
        conectar();
    }

    private void conectar() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.conexion = DriverManager.getConnection(URL);
            System.out.println("¡CONEXIÓN EXITOSA A SQL SERVER EN AZURE!");
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