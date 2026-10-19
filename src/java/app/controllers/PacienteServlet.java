package app.controllers;

import app.models.entities.Paciente;
import app.models.repositories.PacienteRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PacienteServlet", urlPatterns = {"/pacientes"})
public class PacienteServlet extends HttpServlet {
    private final PacienteRepository pacienteRepository = new PacienteRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        if ("listar".equals(accion)) {
            List<Paciente> lista = pacienteRepository.listarTodos();
            request.setAttribute("listaPacientes", lista);
            request.getRequestDispatcher("vistas/pacientes.jsp").forward(request, response);
        } else {
            response.sendRedirect("pacientes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("registrar".equals(accion)) {
            Paciente p = new Paciente();
            p.setNombres(request.getParameter("nombres"));
            p.setApellidos(request.getParameter("apellidos"));
            p.setTipoDocumento(request.getParameter("tipo_documento"));
            p.setNumeroDocumento(request.getParameter("numero_documento"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            p.setDireccion(request.getParameter("direccion"));
            
            pacienteRepository.registrar(p);
            response.sendRedirect("pacientes?accion=listar");
        }
    }
}