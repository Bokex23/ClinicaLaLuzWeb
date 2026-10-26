package app.controllers;

import app.models.entities.Usuario;
import app.models.repositories.UsuarioRepository;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet", "/usuarios"})
public class UsuarioServlet extends HttpServlet {

    private final UsuarioRepository usuarioRepository = new UsuarioRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Usuario> listaUsuarios = usuarioRepository.listarTodos();
        request.setAttribute("listaUsuarios", listaUsuarios);
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null) {
            doGet(request, response);
            return;
        }

        if ("registrar".equals(accion)) {
            String nombre = request.getParameter("nombreUsuario");
            String password = request.getParameter("contrasena");
            int rol = Integer.parseInt(request.getParameter("idRol"));
            String estado = request.getParameter("estado");

            Usuario u = new Usuario();
            u.setNombreUsuario(nombre);
            u.setContrasenaHash(password);
            u.setIdRol(rol);
            u.setEstado(estado);
            u.setIntentosFallidos(0);

            boolean exito = usuarioRepository.registrar(u);
            response.sendRedirect("usuarios");

        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            usuarioRepository.eliminar(id);
            response.sendRedirect("usuarios");
        } else {
            doGet(request, response);
        }
    }
}