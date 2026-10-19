<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.ServicioMedico" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Servicios Médicos - Clínica La Luz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Catálogo de Servicios Médicos - Clínica La Luz</h2>
            <a href="menuPrincipal.jsp" class="btn btn-secondary">Volver al Menú</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">Servicios y Consultas Disponibles</div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th>Nombre del Servicio</th>
                            <th>Especialidad</th>
                            <th>Costo (S/.)</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<ServicioMedico> lista = (List<ServicioMedico>) request.getAttribute("listaServicios");
                            if (lista != null) {
                                for (ServicioMedico s : lista) {
                        %>
                        <tr>
                            <td><%= s.getCodigoServicio() %></td>
                            <td><%= s.getNombreServicio() %></td>
                            <td><%= s.getEspecialidad() %></td>
                            <td>S/. <%= String.format("%.2f", s.getCosto()) %></td>
                            <td><span class="badge bg-success"><%= s.getEstado() %></span></td>
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