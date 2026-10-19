<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Clínica La Luz</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bs-primary: #0d3b66;
            --bs-primary-rgb: 13, 59, 102;
            --accent-blue: #0066ff;
            --bg-dashboard: #f4f7f6;
            --sidebar-width: 260px;
        }

        body {
            background-color: var(--bg-dashboard);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            color: #334155;
        }

        /* Layout Principal */
        .wrapper {
            display: flex;
            width: 100%;
            align-items: stretch;
        }

        /* Sidebar Moderno */
        #sidebar {
            min-width: var(--sidebar-width);
            max-width: var(--sidebar-width);
            background: linear-gradient(180deg, #0d3b66 0%, #092c4c 100%);
            color: #fff;
            min-height: 100vh;
            transition: all 0.3s;
            box-shadow: 4px 0 15px rgba(0,0,0,0.05);
            z-index: 100;
        }

        #sidebar .sidebar-header {
            padding: 24px 20px;
            background: rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        #sidebar ul.components {
            padding: 20px 15px;
        }

        #sidebar ul li a {
            padding: 12px 16px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.75);
            border-radius: 8px;
            margin-bottom: 6px;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        #sidebar ul li a i {
            margin-right: 12px;
            font-size: 1.1rem;
        }

        #sidebar ul li a:hover {
            color: #fff;
            background: rgba(255, 255, 255, 0.08);
            transform: translateX(4px);
        }

        #sidebar ul li.active > a {
            color: #fff;
            background: var(--accent-blue);
            box-shadow: 0 4px 12px rgba(0, 102, 255, 0.3);
        }

        #sidebar ul li a.logout-link:hover {
            background: rgba(220, 53, 69, 0.15);
            color: #ff6b6b;
        }

        /* Contenido Principal */
        #content {
            width: 100%;
            padding: 30px;
            min-height: 100vh;
        }

        /* Navbar superior interna */
        .top-navbar {
            background: #ffffff;
            padding: 15px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Tarjetas de Módulos Elegantes */
        .card-module {
            border: none;
            border-radius: 14px;
            background: #ffffff;
            transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
            box-shadow: 0 4px 20px rgba(0,0,0,0.03);
            overflow: hidden;
            position: relative;
        }

        .card-module:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 30px rgba(13, 59, 102, 0.08);
        }

        .card-module::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: transparent;
            transition: background 0.3s;
        }

        .card-module.active-card::before {
            background: var(--accent-blue);
        }

        .icon-wrapper {
            width: 54px;
            height: 54px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .btn-module {
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s;
        }
    </style>
</head>
<body>

    <div class="wrapper">
        <!-- Sidebar -->
        <nav id="sidebar">
            <div class="sidebar-header d-flex align-items-center">
                <div class="bg-white text-primary p-2 rounded-3 me-2 d-flex align-items-center justify-content-center shadow-sm" style="width: 38px; height: 38px;">
                    <i class="fa-solid fa-hospital text-primary"></i>
                </div>
                <div>
                    <h6 class="mb-0 fw-bold text-white">Clínica La Luz</h6>
                    <small style="font-size: 0.75rem; color: rgba(255,255,255,0.6);">Portal Administrativo</small>
                </div>
            </div>

            <ul class="components list-unstyled">
                <li class="active">
                    <a href="menuPrincipal.jsp"><i class="fa-solid fa-house"></i> Menú Principal</a>
                </li>
                <li>
                    <a href="usuarios.jsp"><i class="fa-solid fa-users-gear"></i> Gestión de Usuarios</a>
                </li>
                <li class="mt-4">
                    <a href="login.jsp" class="logout-link text-danger"><i class="fa-solid fa-right-from-bracket"></i> Cerrar Sesión</a>
                </li>
            </ul>
        </nav>

        <!-- Contenido Central -->
        <div id="content">
            <!-- Barra superior -->
            <div class="top-navbar">
                <div>
                    <h4 class="fw-bold mb-1" style="color: var(--bs-primary);">Panel de Control</h4>
                    <p class="text-muted small mb-0">Bienvenido al sistema integrado de gestión hospitalaria.</p>
                </div>
                <div class="d-flex align-items-center bg-light px-3 py-2 rounded-pill border">
                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; font-size: 0.85rem;">
                        <i class="fa-solid fa-user-shield"></i>
                    </div>
                    <span class="fw-semibold small text-dark">Administrador</span>
                </div>
            </div>

            <!-- Grilla de Módulos -->
            <div class="row g-4">
                <!-- Módulo 3: Gestión de Usuarios (CRUD) -->
                <div class="col-xl-4 col-md-6">
                    <div class="card card-module active-card p-4 h-100">
                        <div class="icon-wrapper" style="background: rgba(0, 102, 255, 0.1); color: var(--accent-blue);">
                            <i class="fa-solid fa-users-gear"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Gestión de Usuarios</h5>
                        <p class="text-muted small mb-4">Administre cuentas de acceso, roles corporativos, credenciales y estados de seguridad del personal.</p>
                        <a href="usuarios.jsp" class="btn btn-primary btn-module mt-auto w-100 shadow-sm" style="background-color: var(--accent-blue); border: none;">
                            Acceder al Módulo <i class="fa-solid fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>

                <!-- Módulo 4: Citas Médicas (Futuro) -->
                <div class="col-xl-4 col-md-6">
                    <div class="card card-module p-4 h-100 opacity-75">
                        <div class="icon-wrapper" style="background: rgba(13, 59, 102, 0.08); color: var(--bs-primary);">
                            <i class="fa-solid fa-calendar-check"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Citas Médicas</h5>
                        <p class="text-muted small mb-4">Control y programación centralizada de citas, especialidades y atención de pacientes.</p>
                        <button class="btn btn-light btn-module mt-auto w-100 text-muted border" disabled>Próximamente</button>
                    </div>
                </div>

                <!-- Módulo 8: Reportería y Logs (Futuro) -->
                <div class="col-xl-4 col-md-6">
                    <div class="card card-module p-4 h-100 opacity-75">
                        <div class="icon-wrapper" style="background: rgba(40, 167, 69, 0.08); color: #28a745;">
                            <i class="fa-solid fa-chart-pie"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Reportería y Logs</h5>
                        <p class="text-muted small mb-4">Supervisión de auditorías, intentos fallidos de acceso y reportes exportables a Excel.</p>
                        <button class="btn btn-light btn-module mt-auto w-100 text-muted border" disabled>Próximamente</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>