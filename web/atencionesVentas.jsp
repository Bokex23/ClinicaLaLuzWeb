<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="app.models.entities.AtencionVenta" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Ventas - Clínica La Luz</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome para iconos idénticos al panel administrativo -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f7fc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        /* Barra lateral corporativa */
        .sidebar { width: 260px; height: 100vh; position: fixed; top: 0; left: 0; background: #0b2545; color: #fff; transition: all 0.3s; z-index: 100; }
        .sidebar .brand { padding: 20px; font-size: 1.1rem; font-weight: bold; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar .menu-list { list-style: none; padding: 15px 0; margin: 0; }
        .sidebar .menu-list li a { padding: 12px 20px; display: flex; align-items: center; gap: 12px; color: #a5b4fc; text-decoration: none; font-size: 0.95rem; transition: 0.2s; }
        .sidebar .menu-list li.active a, .sidebar .menu-list li a:hover { background: #1d4ed8; color: #fff; border-radius: 8px; margin: 0 10px; }
        .sidebar .logout { position: absolute; bottom: 20px; width: 100%; padding: 0 10px; }
        .sidebar .logout a { color: #f87171; display: flex; align-items: center; gap: 10px; padding: 12px 20px; text-decoration: none; border-radius: 8px; transition: 0.2s; }
        .sidebar .logout a:hover { background: rgba(248, 113, 113, 0.1); }
        
        /* Contenedor principal estilo tarjeta flotante */
        .main-content { margin-left: 260px; padding: 30px; }
        .card-custom { background: #ffffff; border: none; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); padding: 25px; margin-bottom: 25px; }
        .btn-primary-custom { background-color: #1d4ed8; border: none; border-radius: 8px; padding: 8px 16px; color: white; font-weight: 500; }
        .btn-primary-custom:hover { background-color: #1e40af; color: white; }
    </style>
</head>
<body>

    <!-- MENÚ LATERAL FIJO (Igual al de tus capturas del sistema) -->
    <div class="sidebar">
        <div class="brand">
            <i class="fa-solid fa-hospital fa-lg text-primary bg-white p-2 rounded"></i>
            <div>
                <span>Clínica La Luz</span><br>
                <small class="text-muted" style="font-size: 0.75rem;">Portal Administrativo</small>
            </div>
        </div>
        <ul class="menu-list">
            <li><a href="${pageContext.request.contextPath}/dashboard.jsp"><i class="fa-solid fa-house"></i> Menú Principal</a></li>
            <li><a href="${pageContext.request.contextPath}/usuarios"><i class="fa-solid fa-user-gear"></i> Gestión de Usuarios</a></li>
            <li><a href="${pageContext.request.contextPath}/pacientes"><i class="fa-solid fa-hospital-user"></i> Gestión de Pacientes</a></li>
            <li><a href="${pageContext.request.contextPath}/cuerpoMedico"><i class="fa-solid fa-user-doctor"></i> Cuerpo Médico</a></li>
            <li><a href="${pageContext.request.contextPath}/proveedores"><i class="fa-solid fa-truck-medical"></i> Proveedores Médicos</a></li>
            <li><a href="${pageContext.request.contextPath}/servicios"><i class="fa-solid fa-notes-medical"></i> Servicios Médicos</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/atencionesVentas"><i class="fa-solid fa-cash-register"></i> Farmacia e Insumos / Ventas</a></li>
        </ul>
        <div class="logout">
            <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Cerrar Sesión</a>
        </div>
    </div>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="main-content">
        
        <!-- Cabecera de la sección -->
        <div class="card-custom d-flex justify-content-between align-items-center">
            <div>
                <h3 class="fw-bold text-dark mb-1">Módulo de Atenciones y Ventas</h3>
                <p class="text-muted mb-0">Control de transacciones, cobros de caja y emisión de comprobantes médicos.</p>
            </div>
            <!-- Botón de acción superior estilo 'Nuevo Usuario' -->
            <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#modalNuevaVenta">
                <i class="fa-solid fa-plus me-2"></i> Nueva Venta
            </button>
        </div>

        <!-- Alertas de éxito o error al procesar peticiones -->
        <%
            String exito = request.getParameter("exito");
            String error = request.getParameter("error");
            if (exito != null) {
        %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 rounded-4 mb-4" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i> ¡Venta registrada y procesada exitosamente en el sistema!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 rounded-4 mb-4" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i> Hubo un error al procesar la venta. Verifique los datos e intente nuevamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <!-- Tabla principal de registros con diseño limpio -->
        <div class="card-custom">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="text-secondary border-bottom">
                        <tr>
                            <th class="py-3">ID Venta</th>
                            <th class="py-3">ID Paciente</th>
                            <th class="py-3">Cajero</th>
                            <th class="py-3">Subtotal</th>
                            <th class="py-3">IGV</th>
                            <th class="py-3">Total</th>
                            <th class="py-3">Estado</th>
                            <th class="py-3">Fecha</th>
                            <th class="py-3 text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<AtencionVenta> ventas = (List<AtencionVenta>) request.getAttribute("listaVentas");
                            if (ventas != null && !ventas.isEmpty()) {
                                for (AtencionVenta v : ventas) {
                        %>
                        <tr>
                            <td class="fw-bold">#<%= v.getIdVenta() %></td>
                            <td><%= v.getIdPaciente() %></td>
                            <td><%= v.getIdUsuario() %></td>
                            <td>S/. <%= v.getSubtotal() %></td>
                            <td>S/. <%= v.getIgv() %></td>
                            <td class="fw-bold text-success">S/. <%= v.getTotal() %></td>
                            <td><span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill"><%= v.getEstado() %></span></td>
                            <td class="text-muted small"><%= v.getFechaVenta() %></td>
                            <td class="text-end">
                                <button class="btn btn-sm btn-outline-primary me-1" title="Editar"><i class="fa-solid fa-pen-to-square"></i></button>
                                <button class="btn btn-sm btn-outline-danger" title="Eliminar"><i class="fa-solid fa-trash-can"></i></button>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center py-4 text-muted">No se encontraron registros de ventas activos.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- MODAL PARA REGISTRAR NUEVA VENTA -->
    <div class="modal fade" id="modalNuevaVenta" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header bg-primary text-white rounded-top-4 p-4">
                    <h5 class="modal-title fw-bold" id="modalLabel"><i class="fa-solid fa-cash-register me-2"></i> Registrar Nueva Venta / Atención</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/atencionesVentas" method="POST">
                    <div class="modal-body p-4">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="idPaciente" class="form-label fw-semibold text-secondary">ID Paciente</label>
                                <input type="number" class="form-control rounded-3 py-2" id="idPaciente" name="idPaciente" required placeholder="Ej: 1">
                            </div>
                            <div class="col-md-6">
                                <label for="idUsuario" class="form-label fw-semibold text-secondary">ID Cajero / Usuario</label>
                                <input type="number" class="form-control rounded-3 py-2" id="idUsuario" name="idUsuario" required placeholder="Ej: 1">
                            </div>
                            <div class="col-md-4">
                                <label for="subtotal" class="form-label fw-semibold text-secondary">Subtotal (S/)</label>
                                <input type="number" step="0.01" class="form-control rounded-3 py-2" id="subtotal" name="subtotal" required placeholder="0.00">
                            </div>
                            <div class="col-md-4">
                                <label for="igv" class="form-label fw-semibold text-secondary">IGV (S/)</label>
                                <input type="number" step="0.01" class="form-control rounded-3 py-2" id="igv" name="igv" required placeholder="0.00">
                            </div>
                            <div class="col-md-4">
                                <label for="total" class="form-label fw-semibold text-secondary">Total General (S/)</label>
                                <input type="number" step="0.01" class="form-control rounded-3 py-2" id="total" name="total" required placeholder="0.00">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer bg-light rounded-bottom-4 p-3">
                        <button type="button" class="btn btn-secondary px-4 rounded-3" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary px-4 rounded-3">Guardar Venta</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>