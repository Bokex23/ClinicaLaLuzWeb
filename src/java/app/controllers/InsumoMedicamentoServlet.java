package app.controllers;

import app.models.entities.InsumoMedicamento;
import app.models.repositories.InsumoMedicamentoRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "InsumoMedicamentoServlet", urlPatterns = {"/insumos"})
public class InsumoMedicamentoServlet extends HttpServlet {
    private final InsumoMedicamentoRepository insumoRepository = new InsumoMedicamentoRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<InsumoMedicamento> lista = insumoRepository.listarTodos();
        request.setAttribute("listaInsumos", lista);
        request.getRequestDispatcher("insumos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("insumos");
            return;
        }

        if ("registrar".equals(accion)) {
            InsumoMedicamento i = new InsumoMedicamento();
            i.setCodigoItem(request.getParameter("codigoItem"));
            i.setNombreItem(request.getParameter("nombreItem"));
            i.setCategoria(request.getParameter("categoria"));
            i.setPrecioUnitario(Double.parseDouble(request.getParameter("precioUnitario")));
            i.setStockActual(Integer.parseInt(request.getParameter("stockActual")));
            i.setStockMinimo(Integer.parseInt(request.getParameter("stockMinimo")));
            
            String estado = request.getParameter("estado");
            i.setEstado(estado != null ? estado : "disponible");

            insumoRepository.registrar(i);
            response.sendRedirect("insumos");

        } else if ("actualizar".equals(accion)) {
            InsumoMedicamento i = new InsumoMedicamento();
            i.setIdItem(Integer.parseInt(request.getParameter("idItem")));
            i.setCodigoItem(request.getParameter("codigoItem"));
            i.setNombreItem(request.getParameter("nombreItem"));
            i.setCategoria(request.getParameter("categoria"));
            i.setPrecioUnitario(Double.parseDouble(request.getParameter("precioUnitario")));
            i.setStockActual(Integer.parseInt(request.getParameter("stockActual")));
            i.setStockMinimo(Integer.parseInt(request.getParameter("stockMinimo")));
            i.setEstado(request.getParameter("estado"));

            insumoRepository.actualizar(i);
            response.sendRedirect("insumos");

        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            insumoRepository.eliminar(id);
            response.sendRedirect("insumos");

        } else {
            response.sendRedirect("insumos");
        }
    }
}