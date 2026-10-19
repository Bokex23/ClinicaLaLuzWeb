<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.ProveedorMedico" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Proveedores Médicos - Clínica La Luz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Proveedores y Laboratorios - Clínica La Luz</h2>
            <a href="menuPrincipal.jsp" class="btn btn-secondary">Volver al Menú</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">Lista de Proveedores Autorizados</div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Razón Social</th>
                            <th>RUC</th>
                            <th>Tipo</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Dirección</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<ProveedorMedico> lista = (List<ProveedorMedico>) request.getAttribute("listaProveedores");
                            if (lista != null) {
                                for (ProveedorMedico p : lista) {
                        %>
                        <tr>
                            <td><%= p.getIdProveedor() %></td>
                            <td><%= p.getRazonSocial() %></td>
                            <td><%= p.getRuc() %></td>
                            <td><%= p.getTipoProveedor() %></td>
                            <td><%= p.getTelefono() %></td>
                            <td><%= p.getCorreo() %></td>
                            <td><%= p.getDireccion() %></td>
                        </tr>
                        <% 
                                }
                            } 
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>