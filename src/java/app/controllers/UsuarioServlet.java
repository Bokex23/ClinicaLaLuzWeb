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
        
        // Obtenemos la lista de usuarios desde el repositorio (conectado a Azure)
        List<Usuario> listaUsuarios = usuarioRepository.listarTodos();
        
        // Guardamos la lista en los atributos de la petición
        request.setAttribute("listaUsuarios", listaUsuarios);
        
        // Redirigimos hacia la vista del CRUD
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}