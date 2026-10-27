package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.Paciente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class PacienteRepository {

    public PacienteRepository() {
        // Constructor vacío para mantener el patrón dinámico
    }

    public List<Paciente> listarTodos() {
        List<Paciente> lista = new ArrayList<>();
        String sql = "SELECT * FROM Pacientes";
        Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            // Formateador de fecha al estilo latinoamericano
            SimpleDateFormat formatoLatino = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
             
            while (rs.next()) {
                Paciente p = new Paciente();
                p.setIdPaciente(rs.getInt("id_paciente"));
                p.setNombres(rs.getString("nombres"));
                p.setApellidos(rs.getString("apellidos"));
                p.setTipoDocumento(rs.getString("tipo_documento"));
                p.setNumeroDocumento(rs.getString("numero_documento"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setDireccion(rs.getString("direccion"));
                p.setEstado(rs.getString("estado"));
                
                // Extraer el DATETIME nativo de Azure y darle formato de texto
                Timestamp ts = rs.getTimestamp("fecha_registro");
                if (ts != null) {
                    p.setFechaRegistro(formatoLatino.format(ts));
                } else {
                    p.setFechaRegistro("-");
                }
                
                lista.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error en listarTodos (Pacientes): " + e.getMessage());
        }
        return lista;
    }

    public boolean registrar(Paciente p) {
        String sql = "INSERT INTO Pacientes (nombres, apellidos, tipo_documento, numero_documento, telefono, correo, direccion, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            
            // Forzar el auto-commit para Azure SQL
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, p.getNombres());
                ps.setString(2, p.getApellidos());
                ps.setString(3, p.getTipoDocumento());
                ps.setString(4, p.getNumeroDocumento());
                ps.setString(5, p.getTelefono());
                ps.setString(6, p.getCorreo());
                ps.setString(7, p.getDireccion());
                ps.setString(8, p.getEstado() != null ? p.getEstado() : "activo");
                
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al registrar paciente en Azure: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizar(Paciente p) {
        String sql = "UPDATE Pacientes SET nombres = ?, apellidos = ?, tipo_documento = ?, numero_documento = ?, telefono = ?, correo = ?, direccion = ?, estado = ? WHERE id_paciente = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, p.getNombres());
                ps.setString(2, p.getApellidos());
                ps.setString(3, p.getTipoDocumento());
                ps.setString(4, p.getNumeroDocumento());
                ps.setString(5, p.getTelefono());
                ps.setString(6, p.getCorreo());
                ps.setString(7, p.getDireccion());
                ps.setString(8, p.getEstado());
                ps.setInt(9, p.getIdPaciente());
                
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar paciente en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idPaciente) {
        String sql = "DELETE FROM Pacientes WHERE id_paciente = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, idPaciente);
                
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al eliminar paciente en Azure: " + e.getMessage());
            return false;
        }
    }
}