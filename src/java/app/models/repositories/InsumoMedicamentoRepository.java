package app.models.repositories;

import app.config.ConexionBD;
import app.models.entities.InsumoMedicamento;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InsumoMedicamentoRepository {

    public InsumoMedicamentoRepository() {
        // Constructor vacío para mantener el patrón dinámico por método
    }

    public List<InsumoMedicamento> listarTodos() {
        List<InsumoMedicamento> lista = new ArrayList<>();
        String sql = "SELECT * FROM Insumos_Medicamentos";
        Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InsumoMedicamento i = new InsumoMedicamento();
                i.setIdItem(rs.getInt("id_item"));
                i.setCodigoItem(rs.getString("codigo_item"));
                i.setNombreItem(rs.getString("nombre_item"));
                i.setCategoria(rs.getString("categoria"));
                i.setPrecioUnitario(rs.getDouble("precio_unitario"));
                i.setStockActual(rs.getInt("stock_actual"));
                i.setStockMinimo(rs.getInt("stock_minimo"));
                i.setEstado(rs.getString("estado"));
                lista.add(i);
            }
        } catch (SQLException e) {
            System.err.println("Error en listarTodos (Insumos): " + e.getMessage());
        }
        return lista;
    }

    public boolean registrar(InsumoMedicamento i) {
        String sql = "INSERT INTO Insumos_Medicamentos (codigo_item, nombre_item, categoria, precio_unitario, stock_actual, stock_minimo, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, i.getCodigoItem());
                ps.setString(2, i.getNombreItem());
                ps.setString(3, i.getCategoria());
                ps.setDouble(4, i.getPrecioUnitario());
                ps.setInt(5, i.getStockActual());
                ps.setInt(6, i.getStockMinimo());
                ps.setString(7, i.getEstado() != null ? i.getEstado() : "disponible");
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al registrar insumo en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(InsumoMedicamento i) {
        String sql = "UPDATE Insumos_Medicamentos SET codigo_item = ?, nombre_item = ?, categoria = ?, precio_unitario = ?, stock_actual = ?, stock_minimo = ?, estado = ? WHERE id_item = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setString(1, i.getCodigoItem());
                ps.setString(2, i.getNombreItem());
                ps.setString(3, i.getCategoria());
                ps.setDouble(4, i.getPrecioUnitario());
                ps.setInt(5, i.getStockActual());
                ps.setInt(6, i.getStockMinimo());
                ps.setString(7, i.getEstado());
                ps.setInt(8, i.getIdItem());
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar insumo en Azure: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idItem) {
        String sql = "DELETE FROM Insumos_Medicamentos WHERE id_item = ?";
        try {
            Connection conexion = ConexionBD.obtenerInstancia().obtenerConexion();
            if (conexion != null) {
                conexion.setAutoCommit(true);
            }
            
            try (PreparedStatement ps = conexion.prepareStatement(sql)) {
                ps.setInt(1, idItem);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error al eliminar insumo en Azure: " + e.getMessage());
            return false;
        }
    }
}