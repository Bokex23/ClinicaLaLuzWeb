package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.Paciente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PacienteRepository {
    private final Connection conexion;

    public PacienteRepository() {
        this.conexion = ConexionBD.obtenerInstancia().obtenerConexion();
    }

    public List<Paciente> listarTodos() {
        List<Paciente> lista = new ArrayList<>();
        String sql = "SELECT * FROM Pacientes";
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
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
                p.setFechaRegistro(rs.getString("fecha_registro"));
                lista.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error en listarTodos (Pacientes): " + e.getMessage());
        }
        return lista;
    }

    public boolean registrar(Paciente p) {
        String sql = "INSERT INTO Pacientes (nombres, apellidos, tipo_documento, numero_documento, telefono, correo, direccion, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
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
        } catch (SQLException e) {
            System.err.println("Error al registrar paciente: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Paciente p) {
        String sql = "UPDATE Pacientes SET nombres = ?, apellidos = ?, tipo_documento = ?, numero_documento = ?, telefono = ?, correo = ?, direccion = ?, estado = ? WHERE id_paciente = ?";
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
        } catch (SQLException e) {
            System.err.println("Error al actualizar paciente: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idPaciente) {
        String sql = "DELETE FROM Pacientes WHERE id_paciente = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, idPaciente);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar paciente: " + e.getMessage());
            return false;
        }
    }
}