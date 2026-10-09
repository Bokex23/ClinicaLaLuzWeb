package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioRepository {
    private final Connection conexion;

    public UsuarioRepository() {
        this.conexion = ConexionBD.obtenerInstancia().obtenerConexion();
    }

    public Usuario buscarPorUsuario(String nombreUsuario) {
        Usuario usr = null;
        String sql = "SELECT * FROM Usuarios WHERE nombre_usuario = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, nombreUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usr = new Usuario();
                    usr.setIdUsuario(rs.getInt("id_usuario"));
                    usr.setNombreUsuario(rs.getString("nombre_usuario"));
                    usr.setContrasenaHash(rs.getString("contrasena_hash"));
                    usr.setIdRol(rs.getInt("id_rol"));
                    usr.setEstado(rs.getString("estado"));
                    usr.setIntentosFallidos(rs.getInt("intentos_fallidos"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en buscarPorUsuario: " + e.getMessage());
        }
        return usr;
    }

    public void actualizarIntentosYEstado(Usuario usuario) {
        String sql = "UPDATE Usuarios SET intentos_fallidos = ?, estado = ? WHERE id_usuario = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, usuario.getIntentosFallidos());
            ps.setString(2, usuario.getEstado());
            ps.setInt(3, usuario.getIdUsuario());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al actualizar intentos: " + e.getMessage());
        }
    }
}