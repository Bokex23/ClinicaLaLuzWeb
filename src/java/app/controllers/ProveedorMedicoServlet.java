package app.controllers;

import app.models.entities.ProveedorMedico;
import app.models.repositories.ProveedorMedicoRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProveedorMedicoServlet", urlPatterns = {"/proveedores"})
public class ProveedorMedicoServlet extends HttpServlet {
    private final ProveedorMedicoRepository proveedorRepository = new ProveedorMedicoRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ProveedorMedico> lista = proveedorRepository.listarTodos();
        request.setAttribute("listaProveedores", lista);
        request.getRequestDispatcher("proveedores.jsp").forward(request, response);
    }
}