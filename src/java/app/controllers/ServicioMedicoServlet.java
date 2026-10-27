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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("servicios");
            return;
        }

        if ("registrar".equals(accion)) {
            ServicioMedico s = new ServicioMedico();
            s.setCodigoServicio(request.getParameter("codigoServicio"));
            s.setNombreServicio(request.getParameter("nombreServicio"));
            s.setEspecialidad(request.getParameter("especialidad"));
            s.setCosto(Double.parseDouble(request.getParameter("costo")));
            
            String estado = request.getParameter("estado");
            s.setEstado(estado != null ? estado : "disponible");

            servicioRepository.registrar(s);
            response.sendRedirect("servicios");

        } else if ("actualizar".equals(accion)) {
            ServicioMedico s = new ServicioMedico();
            s.setIdServicio(Integer.parseInt(request.getParameter("idServicio")));
            s.setCodigoServicio(request.getParameter("codigoServicio"));
            s.setNombreServicio(request.getParameter("nombreServicio"));
            s.setEspecialidad(request.getParameter("especialidad"));
            s.setCosto(Double.parseDouble(request.getParameter("costo")));
            s.setEstado(request.getParameter("estado"));

            servicioRepository.actualizar(s);
            response.sendRedirect("servicios");

        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            servicioRepository.eliminar(id);
            response.sendRedirect("servicios");

        } else {
            response.sendRedirect("servicios");
        }
    }
}