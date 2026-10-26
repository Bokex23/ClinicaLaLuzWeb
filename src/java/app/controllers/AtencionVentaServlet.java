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
        
        // Recupera la lista de todas las atenciones / ventas desde la base de datos
        List<AtencionVenta> listaVentas = ventaRepository.listarTodas();
        
        // Adjunta la lista como atributo para que la vista JSP pueda mostrarla
        request.setAttribute("listaVentas", listaVentas);
        
        // Redirige hacia la vista del módulo (puedes crear un atencionesVentas.jsp luego)
        request.getRequestDispatcher("atencionesVentas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Captura parámetros del formulario de registro de venta / atención
        int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        double subtotal = Double.parseDouble(request.getParameter("subtotal"));
        double igv = Double.parseDouble(request.getParameter("igv"));
        double total = Double.parseDouble(request.getParameter("total"));

        AtencionVenta nuevaVenta = new AtencionVenta();
        nuevaVenta.setIdPaciente(idPaciente);
        nuevaVenta.setIdUsuario(idUsuario);
        nuevaVenta.setSubtotal(subtotal);
        nuevaVenta.setIgv(igv);
        nuevaVenta.setTotal(total);
        nuevaVenta.setEstado("EMITIDO");

        boolean registrado = ventaRepository.insertar(nuevaVenta);

        if (registrado) {
            response.sendRedirect("atencionesVentas?exito=1");
        } else {
            response.sendRedirect("atencionesVentas?error=1");
        }
    }
}