<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.Paciente" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Pacientes - Clínica La Luz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Gestión de Pacientes - Clínica La Luz</h2>
            <a href="menuPrincipal.jsp" class="btn btn-secondary">Volver al Menú</a>
        </div>

        <!-- Formulario de Registro -->
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-primary text-white">Registrar Nuevo Paciente</div>
            <div class="card-body">
                <form action="pacientes" method="POST">
                    <input type="hidden" name="accion" value="registrar">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Nombres</label>
                            <input type="text" class="form-control" name="nombres" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Apellidos</label>
                            <input type="text" class="form-control" name="apellidos" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Tipo Documento</label>
                            <select class="form-select" name="tipo_documento">
                                <option value="DNI">DNI</option>
                                <option value="CE">Carnet de Extranjería</option>
                                <option value="Pasaporte">Pasaporte</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Nº Documento</label>
                            <input type="text" class="form-control" name="numero_documento" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Teléfono</label>
                            <input type="text" class="form-control" name="telefono">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Correo</label>
                            <input type="email" class="form-control" name="correo">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Dirección</label>
                            <input type="text" class="form-control" name="direccion">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success">Guardar Paciente</button>
                </form>
            </div>
        </div>

        <!-- Tabla de Listado -->
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">Lista de Pacientes Registrados</div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombres y Apellidos</th>
                            <th>Documento</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Dirección</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Paciente> lista = (List<Paciente>) request.getAttribute("listaPacientes");
                            if (lista != null) {
                                for (Paciente p : lista) {
                        %>
                        <tr>
                            <td><%= p.getIdPaciente() %></td>
                            <td><%= p.getNombres() %> <%= p.getApellidos() %></td>
                            <td><%= p.getTipoDocumento() %>: <%= p.getNumeroDocumento() %></td>
                            <td><%= p.getTelefono() %></td>
                            <td><%= p.getCorreo() %></td>
                            <td><%= p.getDireccion() %></td>
                            <td><span class="badge bg-success"><%= p.getEstado() %></span></td>
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