package app.models.repositories;

import app.models.entities.AtencionVenta;
import app.config.ConexionBD; // <-- Apunta correctamente a tu paquete app.config
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AtencionVentaRepository {

    // Método para listar todas las atenciones / ventas registradas en la clínica
    public List<AtencionVenta> listarTodas() {
        List<AtencionVenta> lista = new ArrayList<>();
        String sql = "SELECT id_venta, id_paciente, id_usuario, subtotal, igv, total, estado, fecha_venta FROM Atenciones_Ventas";

        // Usamos tu método correcto: obtenerInstancia() y obtenerConexion()
        try (Connection con = ConexionBD.obtenerInstancia().obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AtencionVenta venta = new AtencionVenta();
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setIdPaciente(rs.getInt("id_paciente"));
                venta.setIdUsuario(rs.getInt("id_usuario"));
                venta.setSubtotal(rs.getDouble("subtotal"));
                venta.setIgv(rs.getDouble("igv"));
                venta.setTotal(rs.getDouble("total"));
                venta.setEstado(rs.getString("estado"));
                venta.setFechaVenta(rs.getString("fecha_venta")); // Captura la fecha en formato latinoamericano
                
                lista.add(venta);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar las atenciones de ventas: " + e.getMessage());
        }
        return lista;
    }

    // Método para registrar una nueva venta / atención médica
    public boolean insertar(AtencionVenta venta) {
        String sql = "INSERT INTO Atenciones_Ventas (id_paciente, id_usuario, subtotal, igv, total, estado) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.obtenerInstancia().obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, venta.getIdPaciente());
            ps.setInt(2, venta.getIdUsuario());
            ps.setDouble(3, venta.getSubtotal());
            ps.setDouble(4, venta.getIgv());
            ps.setDouble(5, venta.getTotal());
            ps.setString(6, venta.getEstado());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            System.err.println("Error al insertar la venta: " + e.getMessage());
            return false;
        }
    }
}