package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    // ==========================================
    // MÉTODOS CRUD - ETAPA 4 (Patrón Repository)
    // ==========================================

    // 1. LISTAR TODOS LOS USUARIOS
    public List<Usuario> listarTodos() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM Usuarios";
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario usr = new Usuario();
                usr.setIdUsuario(rs.getInt("id_usuario"));
                usr.setNombreUsuario(rs.getString("nombre_usuario"));
                usr.setContrasenaHash(rs.getString("contrasena_hash"));
                usr.setIdRol(rs.getInt("id_rol"));
                usr.setEstado(rs.getString("estado"));
                usr.setIntentosFallidos(rs.getInt("intentos_fallidos"));
                lista.add(usr);
            }
        } catch (SQLException e) {
            System.err.println("Error en listarTodos: " + e.getMessage());
        }
        return lista;
    }

    // 2. REGISTRAR UN NUEVO USUARIO
    public boolean registrar(Usuario usuario) {
        String sql = "INSERT INTO Usuarios (nombre_usuario, contrasena_hash, id_rol, estado, intentos_fallidos) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombreUsuario());
            ps.setString(2, usuario.getContrasenaHash());
            ps.setInt(3, usuario.getIdRol());
            ps.setString(4, usuario.getEstado());
            ps.setInt(5, usuario.getIntentosFallidos());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al registrar usuario: " + e.getMessage());
            return false;
        }
    }

    // 3. ACTUALIZAR UN USUARIO EXISTENTE
    public boolean actualizar(Usuario usuario) {
        String sql = "UPDATE Usuarios SET nombre_usuario = ?, id_rol = ?, estado = ? WHERE id_usuario = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombreUsuario());
            ps.setInt(2, usuario.getIdRol());
            ps.setString(3, usuario.getEstado());
            ps.setInt(4, usuario.getIdUsuario());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }

    // 4. ELIMINAR UN USUARIO
    public boolean eliminar(int idUsuario) {
        String sql = "DELETE FROM Usuarios WHERE id_usuario = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }
}