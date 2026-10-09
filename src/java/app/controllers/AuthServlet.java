package app.controllers;

import app.models.services.AuthService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AuthServlet", urlPatterns = {"/AuthServlet"})
public class AuthServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        this.authService = new AuthService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = request.getParameter("txtUsuario");
        String clave = request.getParameter("txtClave");

        String resultado = authService.procesarLogin(usuario, clave);

        if ("Exito".equals(resultado)) {
            response.sendRedirect("menuPrincipal.jsp");
        } else {
            // Guardamos el mensaje de error
            request.setAttribute("mensajeError", resultado);
            
            // Guardamos lo que el usuario escribió para que no se borre
            request.setAttribute("usuario_previo", usuario);
            request.setAttribute("clave_previo", clave);
            
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}