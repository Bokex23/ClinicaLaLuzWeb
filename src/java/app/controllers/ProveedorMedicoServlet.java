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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("proveedores");
            return;
        }

        if ("registrar".equals(accion)) {
            ProveedorMedico p = new ProveedorMedico();
            p.setRazonSocial(request.getParameter("razonSocial"));
            p.setRuc(request.getParameter("ruc"));
            p.setTipoProveedor(request.getParameter("tipoProveedor"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            p.setDireccion(request.getParameter("direccion"));
            
            String estado = request.getParameter("estado");
            p.setEstado(estado != null ? estado : "activo");

            proveedorRepository.registrar(p);
            response.sendRedirect("proveedores");

        } else if ("actualizar".equals(accion)) {
            ProveedorMedico p = new ProveedorMedico();
            p.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            p.setRazonSocial(request.getParameter("razonSocial"));
            p.setRuc(request.getParameter("ruc"));
            p.setTipoProveedor(request.getParameter("tipoProveedor"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            p.setDireccion(request.getParameter("direccion"));
            p.setEstado(request.getParameter("estado"));

            proveedorRepository.actualizar(p);
            response.sendRedirect("proveedores");

        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            proveedorRepository.eliminar(id);
            response.sendRedirect("proveedores");

        } else {
            response.sendRedirect("proveedores");
        }
    }
}