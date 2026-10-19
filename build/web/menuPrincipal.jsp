<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Principal - Clínica La Luz</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome para iconos profesionales -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-blue: #0d3b66;
            --accent-blue: #0066ff;
            --bg-light: #f8fafc;
        }
        body {
            background-color: var(--bg-light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .sidebar {
            min-height: 100vh;
            background-color: var(--primary-blue);
            color: white;
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            border-radius: 6px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: var(--accent-blue);
            color: white;
        }
        .card-menu {
            border: none;
            border-radius: 12px;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 12px rgba(0,0,0,0.04);
        }
        .card-menu:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,102,255,0.15);
        }
        .icon-box {
            width: 60px;
            height: 60px;
            background-color: rgba(0, 102, 255, 0.1);
            color: var(--accent-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            font-size: 24px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <div class="container-fluid">
        <div class="row">
            <!-- Menú Lateral (Sidebar) -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse p-3">
                <div class="text-center mb-4 mt-2">
                    <h5 class="fw-bold text-white"><i class="fa-solid fa-hospital me-2"></i>Clínica La Luz</h5>
                    <small class="text-white-50">Sistema Integrado</small>
                </div>
                <hr class="text-white-50">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="menuPrincipal.jsp"><i class="fa-solid fa-house me-2"></i> Menú Principal</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="usuarios.jsp"><i class="fa-solid fa-users-gear me-2"></i> Gestión de Usuarios</a>
                    </li>
                    <li class="nav-item mt-5">
                        <a class="nav-link text-danger" href="login.jsp"><i class="fa-solid fa-right-from-bracket me-2"></i> Cerrar Sesión</a>
                    </li>
                </ul>
            </nav>

            <!-- Contenido Principal (Panel de Control / Módulo 2) -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-4 border-bottom">
                    <div>
                        <h1 class="h3 fw-bold" style="color: var(--primary-blue);">Bienvenido al Panel de Control</h1>
                        <p class="text-muted mb-0">Seleccione un módulo para gestionar las operaciones del sistema de la clínica.</p>
                    </div>
                    <div class="badge bg-primary p-2 px-3 fs-6">
                        <i class="fa-solid fa-user-shield me-1"></i> Rol: Administrador
                    </div>
                </div>

                <!-- Tarjetas de Acceso a los Módulos -->
                <div class="row g-4">
                    <!-- Módulo de Gestión de Usuarios (CRUD - Etapa 4) -->
                    <div class="col-md-4">
                        <div class="card card-menu p-4 bg-white h-100">
                            <div class="icon-box">
                                <i class="fa-solid fa-users-gear"></i>
                            </div>
                            <h5 class="fw-bold text-dark">Gestión de Usuarios</h5>
                            <p class="text-muted small">Administre las cuentas de acceso, roles, estados de bloqueo y contraseñas del personal.</p>
                            <a href="usuarios.jsp" class="btn btn-outline-primary mt-auto w-100 fw-semibold">Acceder al CRUD</a>
                        </div>
                    </div>

                    <!-- Módulo de Citas Médicas -->
                    <div class="col-md-4">
                        <div class="card card-menu p-4 bg-white h-100">
                            <div class="icon-box" style="background-color: rgba(13, 59, 102, 0.1); color: var(--primary-blue);">
                                <i class="fa-solid fa-calendar-days"></i>
                            </div>
                            <h5 class="fw-bold text-dark">Citas Médicas</h5>
                            <p class="text-muted small">Control y programación de citas médicas de forma rápida, segura y centralizada.</p>
                            <button class="btn btn-outline-secondary mt-auto w-100 fw-semibold" disabled>Próximamente</button>
                        </div>
                    </div>

                    <!-- Módulo de Reportería -->
                    <div class="col-md-4">
                        <div class="card card-menu p-4 bg-white h-100">
                            <div class="icon-box" style="background-color: rgba(40, 167, 69, 0.1); color: #28a745;">
                                <i class="fa-solid fa-chart-line"></i>
                            </div>
                            <h5 class="fw-bold text-dark">Reportería y Logs</h5>
                            <p class="text-muted small">Supervisión de auditorías, intentos de acceso fallidos y respaldos de datos en Azure.</p>
                            <button class="btn btn-outline-secondary mt-auto w-100 fw-semibold" disabled>Próximamente</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>