package app.controllers;

import app.models.entities.AtencionVenta;
import app.models.repositories.AtencionVentaRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AtencionVentaServlet", urlPatterns = {"/atencionesVentas"})
public class AtencionVentaServlet extends HttpServlet {

    private AtencionVentaRepository ventaRepository;

    @Override
    public void init() throws ServletException {
        super.init();
        ventaRepository = new AtencionVentaRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<AtencionVenta> listaVentas = ventaRepository.listarTodas();
        request.setAttribute("listaVentas", listaVentas);
        request.getRequestDispatcher("atencionesVentas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("atencionesVentas");
            return;
        }

        try {
            if ("registrar".equals(accion) || "actualizar".equals(accion)) {
                int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                
                // El usuario solo ingresa el Total, el sistema calcula Subtotal e IGV automáticamente
                double total = Double.parseDouble(request.getParameter("total"));
                double subtotal = total / 1.18;
                double igv = total - subtotal;

                AtencionVenta venta = new AtencionVenta();
                venta.setIdPaciente(idPaciente);
                venta.setIdUsuario(idUsuario);
                venta.setSubtotal(subtotal);
                venta.setIgv(igv);
                venta.setTotal(total);

                if ("registrar".equals(accion)) {
                    venta.setEstado("EMITIDO");
                    boolean ok = ventaRepository.insertar(venta);
                    response.sendRedirect("atencionesVentas?" + (ok ? "exito=1" : "error=1"));
                } else {
                    int idVenta = Integer.parseInt(request.getParameter("idVenta"));
                    String estado = request.getParameter("estado");
                    venta.setIdVenta(idVenta);
                    venta.setEstado(estado != null ? estado : "EMITIDO");
                    
                    boolean ok = ventaRepository.actualizar(venta);
                    response.sendRedirect("atencionesVentas?" + (ok ? "exito=1" : "error=1"));
                }

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = ventaRepository.eliminar(id);
                response.sendRedirect("atencionesVentas?" + (ok ? "exito=1" : "error=1"));
            } else {
                response.sendRedirect("atencionesVentas");
            }
        } catch (NumberFormatException e) {
            System.err.println("Error de formato numérico en Venta: " + e.getMessage());
            response.sendRedirect("atencionesVentas?error=1");
        }
    }
}