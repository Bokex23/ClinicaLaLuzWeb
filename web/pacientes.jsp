<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.Paciente" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Pacientes - Clínica La Luz</title>
    <!-- Incluimos Bootstrap para el formulario, manteniendo los estilos base -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* MISMOS ESTILOS QUE USUARIOS.JSP */
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

        /* Barra lateral idéntica */
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
        .nav-divider { height: 1px; margin: 14px 10px 10px; background: rgba(255,255,255,.11); }
        .nav-link.logout { color: #ff737f; }
        .nav-link.logout:hover { color: #fff; background: rgba(255, 82, 99, .13); }
        .sidebar-bottom { margin-top: auto; padding: 20px 22px 25px; color: rgba(255,255,255,.45); font-size: 11px; }
        .sidebar-bottom .tiny-line { width: 42px; height: 3px; margin-bottom: 11px; border-radius: 10px; background: rgba(54,150,255,.8); }

        /* Contenido Principal */
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

        /* Botón de acción principal */
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
        }
        .btn-primary-custom:hover { transform: translateY(-1px); box-shadow: 0 10px 20px rgba(8,102,245,.26); color: #fff;}
        .btn-primary-custom svg { width: 17px; height: 17px; }

        /* Adaptaciones de la tabla a tus estilos */
        .card-custom {
            background: #fff;
            border: 1px solid rgba(226,234,244,.9);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-card);
            overflow: hidden;
            margin-bottom: 24px;
        }
        .card-custom .card-header {
             background: #f8fbff;
             color: var(--navy);
             padding: 16px 20px;
             font-weight: 750;
             border-bottom: 1px solid var(--line);
        }

        .badge-custom {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 99px;
            font-size: 11px;
            font-weight: 650;
            color: #2ca66b;
            background: #e8f8ef;
        }

        @media (max-width: 850px) {
            :root { --sidebar-width: 0px; }
            .sidebar { transform: translateX(-100%); }
            .main-content { margin-left: 0; padding: 20px; }
        }
    </style>
</head>
<body>
<div class="app-shell">
    <!-- Sidebar -->
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
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2"/><circle cx="9.5" cy="7" r="4"/><path d="M20 8v6m-3-3h6M16.5 4.5a4 4 0 0 1 0 7.8M17 15h1a3 3 0 0 1 3 3v1"/></svg>
                        <span>Gestión de Usuarios</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link is-active" href="pacientes">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M17 21v-2a4 4 0 0 0-3-3.87"/><path d="M9 21v-2a4 4 0 0 1 3-3.87"/><circle cx="12" cy="7" r="4"/></svg>
                        <span>Gestión de Pacientes</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="medicos">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 2v20M2 12h20"/></svg>
                        <span>Cuerpo Médico</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="proveedores">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M3 3h2l3 13h13l3-10H7"/></svg>
                        <span>Proveedores Médicos</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="servicios">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
                        <span>Servicios Médicos</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="insumos">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
                        <span>Farmacia e Insumos</span>
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

    <!-- Contenido Principal -->
    <main class="main-content">
        <header class="page-header">
            <div>
                <h1 class="page-title">Gestión de Pacientes</h1>
                <p class="page-subtitle">Registro, control de historias clínicas y administración de datos.</p>
            </div>
        </header>

        <!-- Formulario de Registro (Estilizado) -->
        <div class="card-custom">
            <div class="card-header">Registrar Nuevo Paciente</div>
            <div class="card-body p-4">
                <form action="pacientes" method="POST">
                    <input type="hidden" name="accion" value="registrar">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label" style="color: var(--navy); font-weight: 500;">Nombres</label>
                            <input type="text" class="form-control" name="nombres" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label" style="color: var(--navy); font-weight: 500;">Apellidos</label>
                            <input type="text" class="form-control" name="apellidos" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label" style="color: var(--navy); font-weight: 500;">Tipo Documento</label>
                            <select class="form-select" name="tipo_documento">
                                <option value="DNI">DNI</option>
                                <option value="CE">Carnet de Extranjería</option>
                                <option value="Pasaporte">Pasaporte</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label" style="color: var(--navy); font-weight: 500;">Nº Documento</label>
                            <input type="text" class="form-control" name="numero_documento" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label" style="color: var(--navy); font-weight: 500;">Teléfono</label>
                            <input type="text" class="form-control" name="telefono">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label" style="color: var(--navy); font-weight: 500;">Correo</label>
                            <input type="email" class="form-control" name="correo">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label" style="color: var(--navy); font-weight: 500;">Dirección</label>
                            <input type="text" class="form-control" name="direccion">
                        </div>
                    </div>
                    <div class="mt-3">
                         <button type="submit" class="btn-primary-custom">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                            Guardar Paciente
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabla de Listado -->
        <div class="card-custom">
            <div class="card-header">Lista de Pacientes Registrados</div>
            <div class="table-responsive">
                <table class="table table-hover mb-0" style="font-size: 13px;">
                    <thead style="background: #f8fbff; color: var(--navy);">
                        <tr>
                            <th class="px-4 py-3">ID</th>
                            <th class="px-4 py-3">Nombres y Apellidos</th>
                            <th class="px-4 py-3">Documento</th>
                            <th class="px-4 py-3">Teléfono</th>
                            <th class="px-4 py-3">Correo</th>
                            <th class="px-4 py-3">Dirección</th>
                            <th class="px-4 py-3">Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Paciente> lista = (List<Paciente>) request.getAttribute("listaPacientes");
                            if (lista != null && !lista.isEmpty()) {
                                for (Paciente p : lista) {
                        %>
                        <tr>
                            <td class="px-4 py-3" style="font-weight: 650; color: var(--ink);"><%= p.getIdPaciente() %></td>
                            <td class="px-4 py-3" style="font-weight: 600; color: var(--ink);"><%= p.getNombres() %> <%= p.getApellidos() %></td>
                            <td class="px-4 py-3"><%= p.getTipoDocumento() %>: <%= p.getNumeroDocumento() %></td>
                            <td class="px-4 py-3"><%= p.getTelefono() %></td>
                            <td class="px-4 py-3"><%= p.getCorreo() %></td>
                            <td class="px-4 py-3"><%= p.getDireccion() %></td>
                            <td class="px-4 py-3"><span class="badge-custom"><%= p.getEstado() %></span></td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="7" style="text-align: center; color: var(--muted); padding: 30px;">No hay pacientes registrados en el sistema o no se ha podido conectar al Servlet.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>