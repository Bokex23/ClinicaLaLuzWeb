<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.InsumoMedicamento" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmacia e Insumos - Clínica La Luz</title>
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
            margin: 0;
            min-height: 100vh;
            background: var(--page);
            color: var(--ink);
            font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            -webkit-font-smoothing: antialiased;
        }
        a { color: inherit; text-decoration: none; }
        button { font: inherit; cursor: pointer; }
        .app-shell { min-height: 100vh; }

        .sidebar {
            position: fixed;
            inset: 0 auto 0 0;
            z-index: 30;
            display: flex;
            flex-direction: column;
            width: var(--sidebar-width);
            min-height: 100vh;
            overflow-y: auto;
            color: #fff;
            background: linear-gradient(160deg, #104875 0%, var(--navy) 42%, var(--navy-deep) 100%);
            box-shadow: 10px 0 35px rgba(9, 40, 72, .08);
        }
        .sidebar::before {
            content: "";
            position: absolute;
            z-index: -1;
            pointer-events: none;
            border-radius: 50%;
            width: 390px;
            height: 390px;
            left: -175px;
            bottom: -210px;
            background: linear-gradient(140deg, rgba(0, 102, 255, .25), rgba(0, 102, 255, 0));
        }
        .brand {
            display: flex;
            align-items: center;
            gap: 13px;
            min-height: 112px;
            padding: 25px 22px;
            border-bottom: 1px solid rgba(255,255,255,.11);
        }
        .brand-mark {
            display: grid;
            flex: 0 0 48px;
            width: 48px;
            height: 48px;
            place-items: center;
            color: var(--navy);
            background: #fff;
            border: 1px solid rgba(255,255,255,.7);
            border-radius: 15px;
            box-shadow: 0 7px 18px rgba(0,0,0,.12);
        }
        .brand-mark svg { width: 27px; height: 27px; }
        .brand-name { margin: 0; color: #fff; font-size: 17px; font-weight: 760; letter-spacing: -.35px; }
        .brand-caption { margin: 5px 0 0; color: rgba(255,255,255,.66); font-size: 12px; }
        .nav-area { padding: 24px 14px; }
        .nav-list { display: grid; gap: 9px; margin: 0; padding: 0; list-style: none; }
        .nav-link {
            position: relative;
            display: flex;
            align-items: center;
            gap: 13px;
            min-height: 48px;
            padding: 0 16px;
            color: rgba(255,255,255,.76);
            font-size: 14px;
            font-weight: 560;
            border: 1px solid transparent;
            border-radius: 13px;
            transition: background .2s ease, color .2s ease, transform .2s ease;
        }
        .nav-link svg { width: 21px; height: 21px; flex: 0 0 21px; }
        .nav-link:hover { color: #fff; background: rgba(255,255,255,.08); transform: translateX(2px); }
        .nav-link.is-active {
            color: #fff;
            background: linear-gradient(110deg, #1680ff, #075bf0);
            box-shadow: 0 9px 22px rgba(0, 93, 245, .28);
        }
        .nav-divider { height: 1px; margin: 18px 10px 13px; background: rgba(255,255,255,.11); }
        .nav-link.logout { color: #ff737f; }
        .nav-link.logout:hover { color: #fff; background: rgba(255, 82, 99, .13); }

        .main-content { min-height: 100vh; margin-left: var(--sidebar-width); padding: 32px clamp(22px, 3vw, 48px) 42px; }
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            min-height: 110px;
            margin-bottom: 25px;
            padding: 24px 32px;
            background: rgba(255,255,255,.92);
            border: 1px solid rgba(255,255,255,.95);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-card);
        }
        .page-title { margin: 0; color: var(--navy); font-size: 24px; font-weight: 790; letter-spacing: -.8px; }
        .page-subtitle { margin: 5px 0 0; color: var(--muted); font-size: 13px; }

        .btn-primary-custom {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 22px;
            color: #fff;
            background: linear-gradient(105deg, #1680ff, #075bf0);
            border: 0;
            border-radius: 12px;
            box-shadow: 0 7px 15px rgba(8,102,245,.19);
            font-size: 13px;
            font-weight: 700;
            transition: transform .2s, box-shadow .2s;
            cursor: pointer;
        }
        .btn-primary-custom:hover { transform: translateY(-1px); box-shadow: 0 10px 20px rgba(8,102,245,.26); color: #fff; }

        .btn-danger-custom {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 22px;
            color: #fff;
            background: linear-gradient(105deg, #ff5263, #e63946);
            border: 0;
            border-radius: 12px;
            box-shadow: 0 7px 15px rgba(255, 82, 99, .19);
            font-size: 13px;
            font-weight: 700;
            transition: transform .2s, box-shadow .2s;
            cursor: pointer;
        }
        .btn-danger-custom:hover { transform: translateY(-1px); box-shadow: 0 10px 20px rgba(255, 82, 99, .26); color: #fff; }

        .btn-primary-custom svg, .btn-danger-custom svg { width: 17px; height: 17px; }

        .card-table {
            background: #fff;
            border: 1px solid rgba(226,234,244,.9);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-card);
            overflow: hidden;
            margin-bottom: 25px;
        }
        .table-container { width: 100%; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; text-align: left; font-size: 13px; }
        th { background: #f8fbff; color: var(--navy); padding: 16px 20px; font-weight: 750; border-bottom: 1px solid var(--line); }
        td { padding: 16px 20px; border-bottom: 1px solid var(--line); color: var(--ink); vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #fafdfd; }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 99px;
            font-size: 11px;
            font-weight: 650;
            color: #b25e00;
            background: #fff4e5;
        }

        .action-btns { display: flex; gap: 8px; justify-content: center; }
        .btn-icon {
            display: grid;
            width: 34px;
            height: 34px;
            place-items: center;
            border-radius: 10px;
            border: 1px solid var(--line);
            background: #fff;
            transition: all .2s;
            cursor: pointer;
        }
        .btn-icon.edit { color: #0866f5; }
        .btn-icon.edit:hover { background: #e8f1ff; border-color: #b3d1ff; }
        .btn-icon.delete { color: #ff5263; }
        .btn-icon.delete:hover { background: #ffe6e8; border-color: #ffb3b9; }
        .btn-icon svg { width: 16px; height: 16px; }

        /* Estilos de Modales Flotantes */
        .modal-overlay {
            position: fixed; inset: 0; background: rgba(8, 43, 75, 0.4); backdrop-filter: blur(4px);
            display: none; place-items: center; z-index: 100;
        }
        .modal-overlay.show { display: grid; }
        .modal-card { background: #fff; width: 100%; max-width: 600px; border-radius: var(--radius-lg); overflow: hidden; box-shadow: 0 20px 40px rgba(0,0,0,0.15); }
        .modal-header { padding: 20px 24px; background: #f8fbff; border-bottom: 1px solid var(--line); display: flex; justify-content: space-between; align-items: center; }
        .modal-header h3 { margin: 0; color: var(--navy); font-size: 18px; }
        .btn-close { background: none; border: none; font-size: 22px; cursor: pointer; color: var(--muted); }
        .modal-body { padding: 24px; display: grid; gap: 16px; grid-template-columns: 1fr 1fr; }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group.full-width { grid-column: span 2; }
        .form-group label { font-size: 13px; font-weight: 650; color: var(--navy); }
        .form-group input, .form-group select { padding: 10px 14px; border: 1px solid var(--line); border-radius: 10px; font-size: 13px; outline: none; }
        .modal-footer { padding: 16px 24px; border-top: 1px solid var(--line); display: flex; justify-content: flex-end; gap: 10px; background: #fafdfd; }
        .btn-secondary { padding: 10px 18px; background: #fff; border: 1px solid var(--line); border-radius: 10px; font-weight: 600; cursor: pointer; }

        @media (max-width: 850px) {
            :root { --sidebar-width: 0px; }
            .sidebar { transform: translateX(-100%); }
            .main-content { margin-left: 0; padding: 20px; }
            .modal-body { grid-template-columns: 1fr; }
            .form-group.full-width { grid-column: span 1; }
        }
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
                <li>
                    <a class="nav-link" href="menuPrincipal.jsp">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m3 10 9-7 9 7"/><path d="M5 9.5V21h14V9.5M9 21v-7h6v7"/></svg>
                        <span>Menú Principal</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="usuarios">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                            <circle cx="9" cy="7" r="4"/>
                            <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                        </svg>
                        <span>Gestión de Usuarios</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="pacientes">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M17 21v-1a4 4 0 0 0-4-4h-2a4 4 0 0 0-4 4v1"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                        <span>Gestión de Pacientes</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="medicos">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2v20M2 12h20"/></svg>
                        <span>Cuerpo Médico</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="proveedores">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M3 3h2l3 13h13l3-10H7"/></svg>
                        <span>Proveedores Médicos</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="servicios">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
                        <span>Servicios Médicos</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link is-active" href="insumos">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
                        <span>Farmacia e Insumos</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="atencionesVentas">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
                        <span>Atenciones y Ventas</span>
                    </a>
                </li>
                <li class="nav-divider" aria-hidden="true"></li>
                <li>
                    <a class="nav-link logout" href="login.jsp">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10 17l5-5-5-5M15 12H3"/><path d="M12 3h6a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-6"/></svg>
                        <span>Cerrar Sesión</span>
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <main class="main-content">
        <header class="page-header">
            <div>
                <h1 class="page-title">Inventario de Farmacia e Insumos</h1>
                <p class="page-subtitle">Control de stock actual y mínimos para tópico y farmacia.</p>
            </div>
            <button class="btn-primary-custom" type="button" onclick="document.getElementById('modalInsumo').classList.add('show')">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 5v14M5 12h14"/>
                </svg>
                Nuevo Ítem
            </button>
        </header>

        <div class="card-table">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Nombre del Item</th>
                            <th>Categoría</th>
                            <th>Precio Unit.</th>
                            <th>Stock Actual</th>
                            <th>Stock Mín.</th>
                            <th>Estado</th>
                            <th style="text-align: center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<InsumoMedicamento> lista = (List<InsumoMedicamento>) request.getAttribute("listaInsumos");
                            if (lista != null && !lista.isEmpty()) {
                                for (InsumoMedicamento i : lista) {
                        %>
                        <tr>
                            <td style="font-weight: 650;"><%= i.getCodigoItem() %></td>
                            <td style="font-weight: 600;"><%= i.getNombreItem() %></td>
                            <td><%= i.getCategoria() %></td>
                            <td>S/. <%= String.format("%.2f", i.getPrecioUnitario()) %></td>
                            <td><%= i.getStockActual() %></td>
                            <td><%= i.getStockMinimo() %></td>
                            <td><span class="badge"><%= i.getEstado() %></span></td>
                            <td style="text-align: center;">
                                <div class="action-btns">
                                    <button type="button" class="btn-icon edit" title="Editar ítem"
                                        onclick="abrirEditar('<%= i.getIdItem() %>', '<%= i.getCodigoItem() %>', '<%= i.getNombreItem() %>', '<%= i.getCategoria() %>', '<%= i.getPrecioUnitario() %>', '<%= i.getStockActual() %>', '<%= i.getStockMinimo() %>', '<%= i.getEstado() %>')">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                    </button>
                                    <button type="button" class="btn-icon delete" title="Eliminar ítem" onclick="abrirEliminar('<%= i.getIdItem() %>')">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18m-2 0v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr>
                            <td colspan="8" style="text-align: center; color: var(--muted); padding: 30px;">No hay insumos o medicamentos registrados en el sistema.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Modal para Registrar Nuevo Ítem -->
    <div class="modal-overlay" id="modalInsumo">
        <div class="modal-card">
            <div class="modal-header">
                <h3>Registrar Nuevo Ítem / Medicamento</h3>
                <button type="button" class="btn-close" onclick="document.getElementById('modalInsumo').classList.remove('show')">&times;</button>
            </div>
            <form action="insumos" method="POST">
                <input type="hidden" name="accion" value="registrar">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Código del Ítem</label>
                        <input type="text" name="codigoItem" required placeholder="Ej: MED-002">
                    </div>
                    <div class="form-group">
                        <label>Precio Unitario (S/.)</label>
                        <input type="number" step="0.01" name="precioUnitario" required placeholder="Ej: 15.00">
                    </div>
                    <div class="form-group full-width">
                        <label>Nombre del Ítem</label>
                        <input type="text" name="nombreItem" required placeholder="Ej: Ibuprofeno 400mg">
                    </div>
                    <div class="form-group full-width">
                        <label>Categoría</label>
                        <input type="text" name="categoria" required placeholder="Ej: Medicamento">
                    </div>
                    <div class="form-group">
                        <label>Stock Actual</label>
                        <input type="number" name="stockActual" required placeholder="Ej: 100">
                    </div>
                    <div class="form-group">
                        <label>Stock Mínimo</label>
                        <input type="number" name="stockMinimo" required placeholder="Ej: 10">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="document.getElementById('modalInsumo').classList.remove('show')">Cancelar</button>
                    <button type="submit" class="btn-primary-custom">Guardar Ítem</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal para Editar Ítem -->
    <div class="modal-overlay" id="modalEditar">
        <div class="modal-card">
            <div class="modal-header">
                <h3>Editar Ítem / Medicamento</h3>
                <button type="button" class="btn-close" onclick="document.getElementById('modalEditar').classList.remove('show')">&times;</button>
            </div>
            <form action="insumos" method="POST">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idItem" id="editIdItem">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Código del Ítem</label>
                        <input type="text" name="codigoItem" id="editCodigoItem" required>
                    </div>
                    <div class="form-group">
                        <label>Precio Unitario (S/.)</label>
                        <input type="number" step="0.01" name="precioUnitario" id="editPrecioUnitario" required>
                    </div>
                    <div class="form-group full-width">
                        <label>Nombre del Ítem</label>
                        <input type="text" name="nombreItem" id="editNombreItem" required>
                    </div>
                    <div class="form-group full-width">
                        <label>Categoría</label>
                        <input type="text" name="categoria" id="editCategoria" required>
                    </div>
                    <div class="form-group">
                        <label>Stock Actual</label>
                        <input type="number" name="stockActual" id="editStockActual" required>
                    </div>
                    <div class="form-group">
                        <label>Stock Mínimo</label>
                        <input type="number" name="stockMinimo" id="editStockMinimo" required>
                    </div>
                    <div class="form-group full-width">
                        <label>Estado</label>
                        <select name="estado" id="editEstado">
                            <option value="disponible">Disponible</option>
                            <option value="bajo stock">Bajo Stock</option>
                            <option value="agotado">Agotado</option>
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

    <!-- Modal de Confirmación para Eliminar Ítem -->
    <div class="modal-overlay" id="modalEliminar">
        <div class="modal-card" style="max-width: 450px;">
            <div class="modal-header">
                <h3 style="color: #ff5263;">Confirmar Eliminación</h3>
                <button type="button" class="btn-close" onclick="document.getElementById('modalEliminar').classList.remove('show')">&times;</button>
            </div>
            <form action="insumos" method="POST">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" id="deleteIdItem">
                <div class="modal-body" style="grid-template-columns: 1fr; text-align: center; padding: 30px 24px;">
                    <p style="margin: 0; font-size: 15px; color: var(--ink);">¿Estás seguro de que deseas eliminar este ítem del inventario?</p>
                    <p style="margin: 8px 0 0; font-size: 13px; color: var(--muted);">Esta acción borrará el registro de farmacia permanentemente.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary" onclick="document.getElementById('modalEliminar').classList.remove('show')">Cancelar</button>
                    <button type="submit" class="btn-danger-custom">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h18m-2 0v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                        Sí, Eliminar Ítem
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function abrirEditar(id, codigo, nombre, categoria, precio, stockActual, stockMinimo, estado) {
        document.getElementById('editIdItem').value = id;
        document.getElementById('editCodigoItem').value = codigo;
        document.getElementById('editNombreItem').value = nombre;
        document.getElementById('editCategoria').value = categoria;
        document.getElementById('editPrecioUnitario').value = precio;
        document.getElementById('editStockActual').value = stockActual;
        document.getElementById('editStockMinimo').value = stockMinimo;
        document.getElementById('editEstado').value = estado;
        document.getElementById('modalEditar').classList.add('show');
    }

    function abrirEliminar(id) {
        document.getElementById('deleteIdItem').value = id;
        document.getElementById('modalEliminar').classList.add('show');
    }
</script>
</body>
</html>