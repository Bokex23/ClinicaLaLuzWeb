<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.AtencionVenta" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atenciones y Ventas - Clínica La Luz</title>
    <style>
        :root {
            --navy: #0d3b66;
            --navy-deep: #082b4b;
            --blue: #0866f5;
            --blue-light: #e8f1ff;
            --ink: #172b4d;
            --muted: #68778d;
            --page: #f3f7fc;
            --white: #ffffff;
            --line: #e5ebf3;
            --sidebar-width: 276px;
            --radius-lg: 22px;
            --shadow-card: 0 12px 34px rgba(25, 56, 94, .07);
        }

        * { box-sizing: border-box; }
        html { min-height: 100%; }
        body {
            margin: 0; min-height: 100vh; background: var(--page); color: var(--ink);
            font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }
        a { color: inherit; text-decoration: none; }
        button { font: inherit; cursor: pointer; }
        .app-shell { min-height: 100vh; }

        .sidebar {
            position: fixed; inset: 0 auto 0 0; z-index: 30; display: flex; flex-direction: column;
            width: var(--sidebar-width); min-height: 100vh; overflow-y: auto; color: #fff;
            background: linear-gradient(160deg, #104875 0%, var(--navy) 42%, var(--navy-deep) 100%);
            box-shadow: 10px 0 35px rgba(9, 40, 72, .08);
        }
        .sidebar::before {
            content: ""; position: absolute; z-index: -1; pointer-events: none; border-radius: 50%;
            width: 390px; height: 390px; left: -175px; bottom: -210px;
            background: linear-gradient(140deg, rgba(0, 102, 255, .25), rgba(0, 102, 255, 0));
        }
        .brand {
            display: flex; align-items: center; gap: 13px; min-height: 112px; padding: 25px 22px;
            border-bottom: 1px solid rgba(255,255,255,.11);
        }
        .brand-mark {
            display: grid; flex: 0 0 48px; width: 48px; height: 48px; place-items: center;
            color: var(--navy); background: #fff; border: 1px solid rgba(255,255,255,.7);
            border-radius: 15px; box-shadow: 0 7px 18px rgba(0,0,0,.12);
        }
        .brand-mark svg { width: 27px; height: 27px; }
        .brand-name { margin: 0; color: #fff; font-size: 17px; font-weight: 760; letter-spacing: -.35px; }
        .brand-caption { margin: 5px 0 0; color: rgba(255,255,255,.66); font-size: 12px; }
        .nav-area { padding: 24px 14px; }
        .nav-list { display: grid; gap: 9px; margin: 0; padding: 0; list-style: none; }
        .nav-link {
            position: relative; display: flex; align-items: center; gap: 13px; min-height: 48px;
            padding: 0 16px; color: rgba(255,255,255,.76); font-size: 14px; font-weight: 560;
            border: 1px solid transparent; border-radius: 13px; transition: background .2s ease, color .2s ease;
        }
        .nav-link svg { width: 21px; height: 21px; flex: 0 0 21px; }
        .nav-link:hover { color: #fff; background: rgba(255,255,255,.08); }
        .nav-link.is-active {
            color: #fff; background: linear-gradient(110deg, #1680ff, #075bf0);
            box-shadow: 0 9px 22px rgba(0, 93, 245, .28);
        }
        .nav-divider { height: 1px; margin: 18px 10px 13px; background: rgba(255,255,255,.11); }
        .nav-link.logout { color: #ff737f; }
        .nav-link.logout:hover { color: #fff; background: rgba(255, 82, 99, .13); }

        .main-content { min-height: 100vh; margin-left: var(--sidebar-width); padding: 32px clamp(22px, 3vw, 48px) 42px; }
        .page-header {
            display: flex; align-items: center; justify-content: space-between; gap: 24px;
            min-height: 110px; margin-bottom: 25px; padding: 24px 32px; background: rgba(255,255,255,.92);
            border: 1px solid rgba(255,255,255,.95); border-radius: var(--radius-lg); box-shadow: var(--shadow-card);
        }
        .page-title { margin: 0; color: var(--navy); font-size: 24px; font-weight: 790; letter-spacing: -.8px; }
        .page-subtitle { margin: 5px 0 0; color: var(--muted); font-size: 13px; }

        .btn-primary-custom {
            display: inline-flex; align-items: center; gap: 10px; padding: 12px 22px; color: #fff;
            background: linear-gradient(105deg, #1680ff, #075bf0); border: 0; border-radius: 12px;
            box-shadow: 0 7px 15px rgba(8,102,245,.19); font-size: 13px; font-weight: 700; cursor: pointer;
        }
        .btn-primary-custom:hover { transform: translateY(-1px); box-shadow: 0 10px 20px rgba(8,102,245,.26); }

        .btn-danger-custom {
            display: inline-flex; align-items: center; gap: 10px; padding: 12px 22px; color: #fff;
            background: linear-gradient(105deg, #ff5263, #e63946); border: 0; border-radius: 12px;
            box-shadow: 0 7px 15px rgba(255, 82, 99, .19); font-size: 13px; font-weight: 700; cursor: pointer;
        }
        .btn-danger-custom:hover { transform: translateY(-1px); box-shadow: 0 10px 20px rgba(255, 82, 99, .26); }
        .btn-primary-custom svg, .btn-danger-custom svg { width: 17px; height: 17px; }

        .alert-box {
            padding: 16px 20px; border-radius: 12px; margin-bottom: 25px; font-size: 14px; font-weight: 500;
            display: flex; align-items: center; gap: 10px;
        }
        .alert-success { background: #e8f8ef; color: #1e7145; border: 1px solid #bde9d0; }
        .alert-error { background: #ffe6e8; color: #cc1b2b; border: 1px solid #ffb3b9; }

        .card-table {
            background: #fff; border: 1px solid rgba(226,234,244,.9); border-radius: var(--radius-lg);
            box-shadow: var(--shadow-card); overflow: hidden; margin-bottom: 25px;
        }
        .table-container { width: 100%; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; text-align: left; font-size: 13px; }
        th { background: #f8fbff; color: var(--navy); padding: 16px 20px; font-weight: 750; border-bottom: 1px solid var(--line); }
        td { padding: 16px 20px; border-bottom: 1px solid var(--line); color: var(--ink); vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #fafdfd; }

        .badge {
            display: inline-flex; align-items: center; gap: 6px; padding: 5px 12px;
            border-radius: 99px; font-size: 11px; font-weight: 650; color: #1e7145; background: #e8f8ef;
        }
        .action-btns { display: flex; gap: 8px; justify-content: center; }
        .btn-icon {
            display: grid; width: 34px; height: 34px; place-items: center; border-radius: 10px;
            border: 1px solid var(--line); background: #fff; cursor: pointer;
        }
        .btn-icon.edit { color: #0866f5; }
        .btn-icon.edit:hover { background: #e8f1ff; border-color: #b3d1ff; }
        .btn-icon.delete { color: #ff5263; }
        .btn-icon.delete:hover { background: #ffe6e8; border-color: #ffb3b9; }
        .btn-icon svg { width: 16px; height: 16px; }

        .modal-overlay {
            position: fixed; inset: 0; background: rgba(8, 43, 75, 0.4); backdrop-filter: blur(4px);
            display: none; place-items: center; z-index: 100; opacity: 0; transition: opacity 0.3s ease;
        }
        .modal-overlay.show { display: grid; opacity: 1; }
        .modal-card {
            background: #fff; width: 100%; max-width: 500px; border-radius: var(--radius-lg);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15); overflow: hidden;
        }
        .modal-header { padding: 20px 24px; background: #f8fbff; border-bottom: 1px solid var(--line); display: flex; justify-content: space-between; align-items: center; }
        .modal-header h3 { margin: 0; color: var(--navy); font-size: 18px; font-weight: 700; }
        .btn-close { background: none; border: none; font-size: 22px; color: var(--muted); cursor: pointer; }
        .modal-body { padding: 24px; display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group.full-width { grid-column: span 2; }
        .form-group label { font-size: 13px; font-weight: 650; color: var(--navy); }
        .form-group input, .form-group select { padding: 10px 14px; border: 1px solid var(--line); border-radius: 10px; font-size: 13px; outline: none; }
        .modal-footer { padding: 16px 24px; border-top: 1px solid var(--line); display: flex; justify-content: flex-end; gap: 10px; background: #fafdfd; }
        .btn-secondary { padding: 10px 18px; background: #fff; border: 1px solid var(--line); border-radius: 10px; font-weight: 600; cursor: pointer; }
    </style>
</head>
<body>
<div class="app-shell">
    <aside class="sidebar" aria-label="Navegación principal">
        <div class="brand">
            <div class="brand-mark" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 21V5.5A1.5 1.5 0 0 1 5.5 4H10v17M10 8h4m-2-2v4M14 21V3.5A1.5 1.5 0 0 1 15.5 2H19a1 1 0 0 1 1 1v18M2 21h20"/>
                    <path d="M6.5 8h.01M6.5 12h.01M6.5 16h.01M17 7h.01M17 11h.01M17 15h.01" stroke-width="2.4"/>
                </svg>
            </div>
            <div>
                <p class="brand-name">Clínica La Luz</p>
                <p class="brand-caption">Portal Administrativo</p>
            </div>
        </div>
        <nav class="nav-area">
            <ul class="nav-list">
                <li><a class="nav-link" href="menuPrincipal.jsp">Menú Principal</a></li>
                <li><a class="nav-link" href="usuarios">Gestión de Usuarios</a></li>
                <li><a class="nav-link" href="pacientes">Gestión de Pacientes</a></li>
                <li><a class="nav-link" href="medicos">Cuerpo Médico</a></li>
                <li><a class="nav-link" href="proveedores">Proveedores Médicos</a></li>
                <li><a class="nav-link" href="servicios">Servicios Médicos</a></li>
                <li><a class="nav-link" href="insumos">Farmacia e Insumos</a></li>
                <li><a class="nav-link is-active" href="atencionesVentas">Atenciones y Ventas</a></li>
                <li class="nav-divider"></li>
                <li><a class="nav-link logout" href="login.jsp">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </aside>

    <main class="main-content">
        <header class="page-header">
            <div>
                <h1 class="page-title">Módulo de Atenciones y Ventas</h1>
                <p class="page-subtitle">Control de transacciones, cobros de caja y emisión de comprobantes médicos.</p>
            </div>
            <button class="btn-primary-custom" type="button" onclick="document.getElementById('modalVenta').classList.add('show')">
                Nueva Venta
            </button>
        </header>

        <%
            String exito = request.getParameter("exito");
            String error = request.getParameter("error");
            if (exito != null) {
        %>
            <div class="alert-box alert-success">Venta procesada exitosamente en el sistema.</div>
        <% } if (error != null) { %>
            <div class="alert-box alert-error">Hubo un error al procesar la venta. Verifique los datos.</div>
        <% } %>

        <div class="card-table">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID Venta</th>
                            <th>ID Paciente</th>
                            <th>Cajero</th>
                            <th>Subtotal</th>
                            <th>IGV</th>
                            <th>Total</th>
                            <th>Estado</th>
                            <th>Fecha</th>
                            <th style="text-align: center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<AtencionVenta> ventas = (List<AtencionVenta>) request.getAttribute("listaVentas");
                            if (ventas != null && !ventas.isEmpty()) {
                                for (AtencionVenta v : ventas) {
                        %>
                        <tr>
                            <td style="font-weight: 650;">#<%= v.getIdVenta() %></td>
                            <td><%= v.getIdPaciente() %></td>
                            <td><%= v.getIdUsuario() %></td>
                            <td>S/. <%= String.format("%.2f", v.getSubtotal()) %></td>
                            <td>S/. <%= String.format("%.2f", v.getIgv()) %></td>
                            <td style="font-weight: 700; color: #1e7145;">S/. <%= String.format("%.2f", v.getTotal()) %></td>
                            <td><span class="badge"><%= v.getEstado() %></span></td>
                            <td style="color: var(--muted);"><%= v.getFechaVenta() != null ? v.getFechaVenta() : "-" %></td>
                            <td style="text-align: center;">
                                <div class="action-btns">
                                    <button type="button" class="btn-icon edit" title="Editar venta"
                                        onclick="abrirEditar('<%= v.getIdVenta() %>', '<%= v.getIdPaciente() %>', '<%= v.getIdUsuario() %>', '<%= v.getTotal() %>', '<%= v.getEstado() %>')">
                                        ✎
                                    </button>
                                    <button type="button" class="btn-icon delete" title="Eliminar venta" onclick="abrirEliminar('<%= v.getIdVenta() %>')">
                                        ✕
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr>
                            <td colspan="9" style="text-align: center; color: var(--muted); padding: 30px;">No se encontraron registros de ventas.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Modal para Registrar Nueva Venta (Solo Pide el Total) -->
    <div class="modal-overlay" id="modalVenta">
        <div class="modal-card">
            <div class="modal-header">
                <h3>Registrar Nueva Venta</h3>
                <button type="button" class="btn-close" onclick="document.getElementById('modalVenta').classList.remove('show')">&times;</button>
            </div>
            <form action="atencionesVentas" method="POST">
                <input type="hidden" name="accion" value="registrar">
                <div class="modal-body">
                    <div class="form-group">
                        <label>ID Paciente</label>
                        <input type="number" name="idPaciente" required placeholder="Ej: 1">
                    </div>
                    <div class="form-group">
                        <label>ID Cajero / Usuario</label>
                        <input type="number" name="idUsuario" required placeholder="Ej: 1">
                    </div>
                    <div class="form-group full-width">
                        <label>Total General a Cobrar (S/.) [Subtotal e IGV se calculan solos]</label>
                        <input type="number" step="0.01" name="total" required placeholder="Ej: 118.00">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="document.getElementById('modalVenta').classList.remove('show')">Cancelar</button>
                    <button type="submit" class="btn-primary-custom">Guardar Venta</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal para Editar Venta -->
    <div class="modal-overlay" id="modalEditar">
        <div class="modal-card">
            <div class="modal-header">
                <h3>Editar Venta</h3>
                <button type="button" class="btn-close" onclick="document.getElementById('modalEditar').classList.remove('show')">&times;</button>
            </div>
            <form action="atencionesVentas" method="POST">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idVenta" id="editIdVenta">
                <div class="modal-body">
                    <div class="form-group">
                        <label>ID Paciente</label>
                        <input type="number" name="idPaciente" id="editIdPaciente" required>
                    </div>
                    <div class="form-group">
                        <label>ID Cajero / Usuario</label>
                        <input type="number" name="idUsuario" id="editIdUsuario" required>
                    </div>
                    <div class="form-group">
                        <label>Total General (S/.)</label>
                        <input type="number" step="0.01" name="total" id="editTotal" required>
                    </div>
                    <div class="form-group">
                        <label>Estado</label>
                        <select name="estado" id="editEstado">
                            <option value="EMITIDO">EMITIDO</option>
                            <option value="PAGADO">PAGADO</option>
                            <option value="ANULADO">ANULADO</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="document.getElementById('modalEditar').classList.remove('show')">Cancelar</button>
                    <button type="submit" class="btn-primary-custom">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal para Eliminar Venta -->
    <div class="modal-overlay" id="modalEliminar">
        <div class="modal-card" style="max-width: 400px;">
            <div class="modal-header">
                <h3 style="color: #ff5263;">Confirmar Eliminación</h3>
                <button type="button" class="btn-close" onclick="document.getElementById('modalEliminar').classList.remove('show')">&times;</button>
            </div>
            <form action="atencionesVentas" method="POST">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" id="deleteIdVenta">
                <div class="modal-body" style="grid-template-columns: 1fr; text-align: center;">
                    <p style="margin: 0; color: var(--ink);">¿Estás seguro de que deseas eliminar este registro de venta?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="document.getElementById('modalEliminar').classList.remove('show')">Cancelar</button>
                    <button type="submit" class="btn-danger-custom">Sí, Eliminar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function abrirEditar(id, idPaciente, idUsuario, total, estado) {
        document.getElementById('editIdVenta').value = id;
        document.getElementById('editIdPaciente').value = idPaciente;
        document.getElementById('editIdUsuario').value = idUsuario;
        document.getElementById('editTotal').value = total;
        document.getElementById('editEstado').value = estado;
        document.getElementById('modalEditar').classList.add('show');
    }

    function abrirEliminar(id) {
        document.getElementById('deleteIdVenta').value = id;
        document.getElementById('modalEliminar').classList.add('show');
    }
</script>
</body>
</html>