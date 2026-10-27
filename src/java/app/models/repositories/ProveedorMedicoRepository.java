package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.ProveedorMedico;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProveedorMedicoRepository {

    public ProveedorMedicoRepository() {
        // Constructor vacío para mantener el patrón dinámico por método
    }

    public List<ProveedorMedico> listarTodos() {
        List<ProveedorMedico> lista = new ArrayList<>();
        String sql = "SELECT * FROM Proveedores_Medicos";
        Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProveedorMedico p = new ProveedorMedico();
                p.setIdProveedor(rs.getInt("id_proveedor"));
                p.setRazonSocial(rs.getString("razon_social"));
                p.setRuc(rs.getString("ruc"));
                p.setTipoProveedor(rs.getString("tipo_proveedor"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setDireccion(rs.getString("direccion"));
                p.setEstado(rs.getString("estado"));
                lista.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error en listarTodos (Proveedores): " + e.getMessage());
        }
        return lista;
    }

    public boolean registrar(ProveedorMedico p) {
        String sql = "INSERT INTO Proveedores_Medicos (razon_social, ruc, tipo_proveedor, telefono, correo, direccion, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, p.getRazonSocial());
                ps.setString(2, p.getRuc());
                ps.setString(3, p.getTipoProveedor());
                ps.setString(4, p.getTelefono());
                ps.setString(5, p.getCorreo());
                ps.setString(6, p.getDireccion());
                ps.setString(7, p.getEstado() != null ? p.getEstado() : "activo");
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al registrar proveedor en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(ProveedorMedico p) {
        String sql = "UPDATE Proveedores_Medicos SET razon_social = ?, ruc = ?, tipo_proveedor = ?, telefono = ?, correo = ?, direccion = ?, estado = ? WHERE id_proveedor = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, p.getRazonSocial());
                ps.setString(2, p.getRuc());
                ps.setString(3, p.getTipoProveedor());
                ps.setString(4, p.getTelefono());
                ps.setString(5, p.getCorreo());
                ps.setString(6, p.getDireccion());
                ps.setString(7, p.getEstado());
                ps.setInt(8, p.getIdProveedor());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar proveedor en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idProveedor) {
        String sql = "DELETE FROM Proveedores_Medicos WHERE id_proveedor = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, idProveedor);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al eliminar proveedor en Azure: " + e.getMessage());
            return false;
        }
    }
}