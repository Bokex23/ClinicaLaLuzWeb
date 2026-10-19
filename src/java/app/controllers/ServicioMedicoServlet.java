package app.controllers;

import app.models.entities.ServicioMedico;
import app.models.repositories.ServicioMedicoRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServicioMedicoServlet", urlPatterns = {"/servicios"})
public class ServicioMedicoServlet extends HttpServlet {
    private final ServicioMedicoRepository servicioRepository = new ServicioMedicoRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ServicioMedico> lista = servicioRepository.listarTodos();
        request.setAttribute("listaServicios", lista);
        request.getRequestDispatcher("servicios.jsp").forward(request, response);
    }
}