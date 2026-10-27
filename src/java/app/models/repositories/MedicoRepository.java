package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.Medico;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicoRepository {

    public MedicoRepository() {
        // Constructor vacío para mantener el patrón dinámico por método
    }

    public List<Medico> listarTodos() {
        List<Medico> lista = new ArrayList<>();
        String sql = "SELECT * FROM Medicos";
        Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Medico m = new Medico();
                m.setIdMedico(rs.getInt("id_medico"));
                m.setIdUsuario(rs.getInt("id_usuario"));
                m.setNombres(rs.getString("nombres"));
                m.setApellidos(rs.getString("apellidos"));
                m.setCmp(rs.getString("cmp"));
                m.setEspecialidad(rs.getString("especialidad"));
                m.setTelefono(rs.getString("telefono"));
                m.setEstado(rs.getString("estado"));
                lista.add(m);
            }
        } catch (SQLException e) {
            System.err.println("Error en listarTodos (Medicos): " + e.getMessage());
        }
        return lista;
    }

    public boolean registrar(Medico m) {
        String sql = "INSERT INTO Medicos (id_usuario, nombres, apellidos, cmp, especialidad, telefono, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, m.getIdUsuario());
                ps.setString(2, m.getNombres());
                ps.setString(3, m.getApellidos());
                ps.setString(4, m.getCmp());
                ps.setString(5, m.getEspecialidad());
                ps.setString(6, m.getTelefono());
                ps.setString(7, m.getEstado() != null ? m.getEstado() : "activo");
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al registrar medico en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Medico m) {
        String sql = "UPDATE Medicos SET id_usuario = ?, nombres = ?, apellidos = ?, cmp = ?, especialidad = ?, telefono = ?, estado = ? WHERE id_medico = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, m.getIdUsuario());
                ps.setString(2, m.getNombres());
                ps.setString(3, m.getApellidos());
                ps.setString(4, m.getCmp());
                ps.setString(5, m.getEspecialidad());
                ps.setString(6, m.getTelefono());
                ps.setString(7, m.getEstado());
                ps.setInt(8, m.getIdMedico());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar medico en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idMedico) {
        String sql = "DELETE FROM Medicos WHERE id_medico = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, idMedico);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al eliminar medico en Azure: " + e.getMessage());
            return false;
        }
    }
}