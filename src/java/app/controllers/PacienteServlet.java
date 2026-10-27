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
            request.getRequestDispatcher("pacientes.jsp").forward(request, response);
        } else {
            response.sendRedirect("pacientes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Aseguramos que los caracteres especiales (tildes, ñ) se capturen correctamente
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            response.sendRedirect("pacientes");
            return;
        }

        if ("registrar".equals(accion)) {
            Paciente p = new Paciente();
            p.setNombres(request.getParameter("nombres"));
            p.setApellidos(request.getParameter("apellidos"));
            p.setTipoDocumento(request.getParameter("tipo_documento"));
            p.setNumeroDocumento(request.getParameter("numero_documento"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            p.setDireccion(request.getParameter("direccion"));
            
            String estado = request.getParameter("estado");
            if (estado != null) {
                p.setEstado(estado);
            }
            
            pacienteRepository.registrar(p);
            response.sendRedirect("pacientes");

        } else if ("actualizar".equals(accion)) {
            Paciente p = new Paciente();
            p.setIdPaciente(Integer.parseInt(request.getParameter("idPaciente")));
            p.setNombres(request.getParameter("nombres"));
            p.setApellidos(request.getParameter("apellidos"));
            p.setTipoDocumento(request.getParameter("tipo_documento"));
            p.setNumeroDocumento(request.getParameter("numero_documento"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            p.setDireccion(request.getParameter("direccion"));
            p.setEstado(request.getParameter("estado"));

            pacienteRepository.actualizar(p);
            response.sendRedirect("pacientes");

        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            pacienteRepository.eliminar(id);
            response.sendRedirect("pacientes");
            
        } else {
            response.sendRedirect("pacientes");
        }
    }
}