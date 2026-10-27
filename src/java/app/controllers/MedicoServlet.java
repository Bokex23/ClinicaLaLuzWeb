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
        request.getRequestDispatcher("medicos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("medicos");
            return;
        }

        if ("registrar".equals(accion)) {
            Medico m = new Medico();
            m.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
            m.setNombres(request.getParameter("nombres"));
            m.setApellidos(request.getParameter("apellidos"));
            m.setCmp(request.getParameter("cmp"));
            m.setEspecialidad(request.getParameter("especialidad"));
            m.setTelefono(request.getParameter("telefono"));
            
            String estado = request.getParameter("estado");
            m.setEstado(estado != null ? estado : "activo");

            medicoRepository.registrar(m);
            response.sendRedirect("medicos");

        } else if ("actualizar".equals(accion)) {
            Medico m = new Medico();
            m.setIdMedico(Integer.parseInt(request.getParameter("idMedico")));
            m.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
            m.setNombres(request.getParameter("nombres"));
            m.setApellidos(request.getParameter("apellidos"));
            m.setCmp(request.getParameter("cmp"));
            m.setEspecialidad(request.getParameter("especialidad"));
            m.setTelefono(request.getParameter("telefono"));
            m.setEstado(request.getParameter("estado"));

            medicoRepository.actualizar(m);
            response.sendRedirect("medicos");

        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            medicoRepository.eliminar(id);
            response.sendRedirect("medicos");

        } else {
            response.sendRedirect("medicos");
        }
    }
}