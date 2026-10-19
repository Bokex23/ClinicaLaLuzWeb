<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, app.models.entities.Medico" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuerpo Médico - Clínica La Luz</title>
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
        .nav-divider { height: 1px; margin: 18px 10px 13px; background: rgba(255,255,255,.11); }
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

        /* Tabla Estilizada */
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
            color: #0866f5;
            background: #e8f1ff;
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
                <li><a class="nav-link is-active" href="medicos">Cuerpo Médico</a></li>
                <li><a class="nav-link" href="proveedores">Proveedores Médicos</a></li>
                <li><a class="nav-link" href="servicios">Servicios Médicos</a></li>
                <li><a class="nav-link" href="insumos">Farmacia e Insumos</a></li>
                <li class="nav-divider"></li>
                <li><a class="nav-link logout" href="login.jsp">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </aside>

    <main class="main-content">
        <header class="page-header">
            <div>
                <h1 class="page-title">Cuerpo Médico</h1>
                <p class="page-subtitle">Supervisión del personal médico, especialidades y códigos CMP.</p>
            </div>
        </header>

        <div class="card-table">
            <div class="table-container">
                <table>
                    <thead>
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
                            if (lista != null && !lista.isEmpty()) {
                                for (Medico m : lista) {
                        %>
                        <tr>
                            <td style="font-weight: 650;"><%= m.getIdMedico() %></td>
                            <td style="font-weight: 600;"><%= m.getNombres() %> <%= m.getApellidos() %></td>
                            <td><%= m.getCmp() %></td>
                            <td><%= m.getEspecialidad() %></td>
                            <td><%= m.getTelefono() %></td>
                            <td><span class="badge"><%= m.getEstado() %></span></td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: var(--muted); padding: 30px;">No hay médicos registrados en el sistema.</td>
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