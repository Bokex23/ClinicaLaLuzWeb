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
}