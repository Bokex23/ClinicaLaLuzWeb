package app.controllers;

import app.models.entities.Medico;
import app.models.repositories.MedicoRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MedicoServlet", urlPatterns = {"/medicos"})
public class MedicoServlet extends HttpServlet {
    private final MedicoRepository medicoRepository = new MedicoRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Medico> lista = medicoRepository.listarTodos();
        request.setAttribute("listaMedicos", lista);
        request.getRequestDispatcher("vistas/medicos.jsp").forward(request, response);
    }
}