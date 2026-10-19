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
    private final Connection conexion;

    public MedicoRepository() {
        this.conexion = ConexionBD.obtenerInstancia().obtenerConexion();
    }

    public List<Medico> listarTodos() {
        List<Medico> lista = new ArrayList<>();
        String sql = "SELECT * FROM Medicos";
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
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, m.getIdUsuario());
            ps.setString(2, m.getNombres());
            ps.setString(3, m.getApellidos());
            ps.setString(4, m.getCmp());
            ps.setString(5, m.getEspecialidad());
            ps.setString(6, m.getTelefono());
            ps.setString(7, m.getEstado() != null ? m.getEstado() : "activo");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al registrar medico: " + e.getMessage());
            return false;
        }
    }
}