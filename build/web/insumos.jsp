<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.InsumoMedicamento" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Farmacia e Insumos - Clínica La Luz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Inventario de Farmacia e Insumos - Clínica La Luz</h2>
            <a href="menuPrincipal.jsp" class="btn btn-secondary">Volver al Menú</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">Stock de Medicamentos e Insumos Médicos</div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th>Nombre del Item</th>
                            <th>Categoría</th>
                            <th>Precio Unit.</th>
                            <th>Stock Actual</th>
                            <th>Stock Mín.</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<InsumoMedicamento> lista = (List<InsumoMedicamento>) request.getAttribute("listaInsumos");
                            if (lista != null) {
                                for (InsumoMedicamento i : lista) {
                        %>
                        <tr>
                            <td><%= i.getCodigoItem() %></td>
                            <td><%= i.getNombreItem() %></td>
                            <td><%= i.getCategoria() %></td>
                            <td>S/. <%= String.format("%.2f", i.getPrecioUnitario()) %></td>
                            <td><%= i.getStockActual() %></td>
                            <td><%= i.getStockMinimo() %></td>
                            <td><span class="badge bg-warning text-dark"><%= i.getEstado() %></span></td>
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