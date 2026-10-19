<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.Medico" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Médicos - Clínica La Luz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Cuerpo Médico - Clínica La Luz</h2>
            <a href="menuPrincipal.jsp" class="btn btn-secondary">Volver al Menú</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">Médicos Especialistas Registrados</div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombres y Apellidos</th>
                            <th>CMP</th>
                            <th>Especialidad</th>
                            <th>Teléfono</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Medico> lista = (List<Medico>) request.getAttribute("listaMedicos");
                            if (lista != null) {
                                for (Medico m : lista) {
                        %>
                        <tr>
                            <td><%= m.getIdMedico() %></td>
                            <td><%= m.getNombres() %> <%= m.getApellidos() %></td>
                            <td><%= m.getCmp() %></td>
                            <td><%= m.getEspecialidad() %></td>
                            <td><%= m.getTelefono() %></td>
                            <td><span class="badge bg-info"><%= m.getEstado() %></span></td>
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