package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.ServicioMedico;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ServicioMedicoRepository {

    public ServicioMedicoRepository() {
        // Constructor vacío para mantener el patrón dinámico por método
    }

    public List<ServicioMedico> listarTodos() {
        List<ServicioMedico> lista = new ArrayList<>();
        String sql = "SELECT * FROM Servicios_Medicos";
        Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ServicioMedico s = new ServicioMedico();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setCodigoServicio(rs.getString("codigo_servicio"));
                s.setNombreServicio(rs.getString("nombre_servicio"));
                s.setEspecialidad(rs.getString("especialidad"));
                s.setCosto(rs.getDouble("costo"));
                s.setEstado(rs.getString("estado"));
                lista.add(s);
            }
        } catch (SQLException e) {
            System.err.println("Error en listarTodos (Servicios): " + e.getMessage());
        }
        return lista;
    }

    public boolean registrar(ServicioMedico s) {
        String sql = "INSERT INTO Servicios_Medicos (codigo_servicio, nombre_servicio, especialidad, costo, estado) VALUES (?, ?, ?, ?, ?)";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, s.getCodigoServicio());
                ps.setString(2, s.getNombreServicio());
                ps.setString(3, s.getEspecialidad());
                ps.setDouble(4, s.getCosto());
                ps.setString(5, s.getEstado() != null ? s.getEstado() : "disponible");
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al registrar servicio en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(ServicioMedico s) {
        String sql = "UPDATE Servicios_Medicos SET codigo_servicio = ?, nombre_servicio = ?, especialidad = ?, costo = ?, estado = ? WHERE id_servicio = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, s.getCodigoServicio());
                ps.setString(2, s.getNombreServicio());
                ps.setString(3, s.getEspecialidad());
                ps.setDouble(4, s.getCosto());
                ps.setString(5, s.getEstado());
                ps.setInt(6, s.getIdServicio());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar servicio en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idServicio) {
        String sql = "DELETE FROM Servicios_Medicos WHERE id_servicio = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, idServicio);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al eliminar servicio en Azure: " + e.getMessage());
            return false;
        }
    }
}