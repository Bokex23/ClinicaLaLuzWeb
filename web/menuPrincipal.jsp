<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Clínica La Luz</title>
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
        a { color: inherit; }
        button { font: inherit; }
        .app-shell { min-height: 100vh; }

        /* Barra lateral: todos los iconos son SVG incluidos en este mismo archivo. */
        .sidebar {
            position: fixed;
            inset: 0 auto 0 0;
            z-index: 30;
            display: flex;
            flex-direction: column;
            width: var(--sidebar-width);
            min-height: 100vh;
            overflow: hidden;
            color: #fff;
            background: linear-gradient(160deg, #104875 0%, var(--navy) 42%, var(--navy-deep) 100%);
            box-shadow: 10px 0 35px rgba(9, 40, 72, .08);
        }
        .sidebar::before,
        .sidebar::after {
            content: "";
            position: absolute;
            z-index: -1;
            pointer-events: none;
            border-radius: 50%;
        }
        .sidebar::before {
            width: 390px;
            height: 390px;
            left: -175px;
            bottom: -210px;
            background: linear-gradient(140deg, rgba(0, 102, 255, .25), rgba(0, 102, 255, 0));
        }
        .sidebar::after {
            width: 250px;
            height: 250px;
            right: -170px;
            bottom: 90px;
            border: 1px solid rgba(255,255,255,.07);
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
        .brand-caption { margin: 5px 0 0; color: rgba(255,255,255,.66); font-size: 12px; letter-spacing: .15px; }
        .nav-area { padding: 24px 14px; }
        .nav-list { display: grid; gap: 9px; margin: 0; padding: 0; list-style: none; }
        .nav-link {
            position: relative;
            display: flex;
            align-items: center;
            gap: 13px;
            min-height: 54px;
            padding: 0 16px;
            color: rgba(255,255,255,.76);
            text-decoration: none;
            font-size: 14px;
            font-weight: 560;
            border: 1px solid transparent;
            border-radius: 13px;
            transition: background .2s ease, color .2s ease, transform .2s ease, box-shadow .2s ease;
        }
        .nav-link svg { width: 21px; height: 21px; flex: 0 0 21px; }
        .nav-link:hover { color: #fff; background: rgba(255,255,255,.08); transform: translateX(2px); }
        .nav-link.is-active {
            color: #fff;
            background: linear-gradient(110deg, #1680ff, #075bf0);
            box-shadow: 0 9px 22px rgba(0, 93, 245, .28);
        }
        .nav-link.is-active::before {
            content: "";
            position: absolute;
            left: -14px;
            top: 12px;
            bottom: 12px;
            width: 4px;
            border-radius: 0 5px 5px 0;
            background: #fff;
        }
        .nav-divider { height: 1px; margin: 18px 10px 13px; background: rgba(255,255,255,.11); }
        .nav-link.logout { color: #ff737f; }
        .nav-link.logout:hover { color: #fff; background: rgba(255, 82, 99, .13); }
        .sidebar-bottom { margin-top: auto; padding: 20px 22px 25px; color: rgba(255,255,255,.45); font-size: 11px; }
        .sidebar-bottom .tiny-line { width: 42px; height: 3px; margin-bottom: 11px; border-radius: 10px; background: rgba(54,150,255,.8); }

        /* Contenido */
        .main-content { min-height: 100vh; margin-left: var(--sidebar-width); padding: 32px clamp(22px, 3vw, 48px) 42px; }
        .mobile-bar { display: none; }
        .page-header {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            min-height: 142px;
            margin-bottom: 29px;
            padding: 28px 32px;
            overflow: hidden;
            background: rgba(255,255,255,.92);
            border: 1px solid rgba(255,255,255,.95);
            border-radius: var(--radius-lg);
            box-shadow: 0 7px 25px rgba(23, 54, 91, .035);
        }
        .page-header::after {
            content: "";
            position: absolute;
            width: 250px;
            height: 250px;
            top: -170px;
            right: 185px;
            border: 35px solid rgba(8,102,245,.035);
            border-radius: 50%;
            pointer-events: none;
        }
        .header-copy { position: relative; z-index: 1; }
        .eyebrow { width: 42px; height: 4px; margin-bottom: 15px; background: #1680ff; border-radius: 10px; }
        .page-title { margin: 0; color: var(--navy); font-size: clamp(25px, 2.1vw, 32px); line-height: 1.15; font-weight: 790; letter-spacing: -.9px; }
        .page-subtitle { margin: 9px 0 0; color: var(--muted); font-size: 14px; line-height: 1.55; }
        .admin-pill {
            position: relative;
            z-index: 1;
            display: inline-flex;
            flex-shrink: 0;
            align-items: center;
            gap: 11px;
            padding: 9px 16px 9px 10px;
            color: #172b4d;
            background: #f9fbfd;
            border: 1px solid #e2e9f1;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 650;
            white-space: nowrap;
        }
        .admin-avatar { display: grid; width: 37px; height: 37px; place-items: center; color: #fff; background: var(--navy); border-radius: 50%; }
        .admin-avatar svg { width: 19px; height: 19px; }

        .section-heading { display: flex; align-items: end; justify-content: space-between; gap: 16px; margin: 0 2px 17px; }
        .section-heading h2 { margin: 0; color: #263d5c; font-size: 16px; font-weight: 750; letter-spacing: -.25px; }
        .section-heading p { margin: 5px 0 0; color: #8a97a9; font-size: 12px; }
        .module-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 22px; align-items: stretch; }
        .module-card {
            --module-color: #0866f5;
            --module-tint: #e8f1ff;
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            min-height: 342px;
            padding: 25px 24px 23px;
            overflow: hidden;
            background: #fff;
            border: 1px solid rgba(226,234,244,.9);
            border-radius: 21px;
            box-shadow: var(--shadow-card);
            transition: transform .24s ease, box-shadow .24s ease, border-color .24s ease;
        }
        .module-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--module-color);
            opacity: 0;
            transition: opacity .2s ease;
        }
        .module-card::after {
            content: "";
            position: absolute;
            top: 35px;
            right: -48px;
            width: 155px;
            height: 155px;
            background: radial-gradient(circle, var(--module-tint) 0%, rgba(255,255,255,0) 72%);
            opacity: .8;
            pointer-events: none;
        }
        .module-card:hover { transform: translateY(-5px); box-shadow: 0 17px 40px rgba(25,56,94,.11); border-color: #d6e4f6; }
        .module-card.primary { border-color: #dce9ff; }
        .module-card.primary::before { opacity: 1; }
        .module-card.calendar { --module-color: #58748f; --module-tint: #edf3f8; }
        .module-card.reports { --module-color: #2ca66b; --module-tint: #e8f8ef; }
        .card-top { position: relative; z-index: 1; display: flex; align-items: flex-start; justify-content: space-between; gap: 12px; margin-bottom: 24px; }
        .module-icon {
            display: grid;
            width: 62px;
            height: 62px;
            place-items: center;
            color: var(--module-color);
            background: var(--module-tint);
            border: 1px solid color-mix(in srgb, var(--module-color) 10%, white);
            border-radius: 18px;
            box-shadow: 0 7px 14px rgba(32,71,117,.045);
        }
        .module-icon svg { width: 29px; height: 29px; }
        .card-arrow { display: grid; width: 34px; height: 34px; place-items: center; color: #8192a9; background: #f6f9fc; border-radius: 50%; }
        .card-arrow svg { width: 17px; height: 17px; }
        .module-card h3 { position: relative; z-index: 1; margin: 0 0 10px; color: #172b4d; font-size: 18px; line-height: 1.35; font-weight: 760; letter-spacing: -.45px; }
        .module-card p { position: relative; z-index: 1; margin: 0 0 25px; color: #6c7b90; font-size: 13px; line-height: 1.75; }
        .module-action {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            min-height: 48px;
            margin-top: auto;
            padding: 12px 15px;
            color: #fff;
            background: linear-gradient(105deg, #1680ff, #075bf0);
            border: 0;
            border-radius: 12px;
            box-shadow: 0 7px 15px rgba(8,102,245,.19);
            text-align: center;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: transform .2s ease, box-shadow .2s ease;
        }
        .module-action:hover { color: #fff; transform: translateY(-1px); box-shadow: 0 10px 20px rgba(8,102,245,.26); }
        .module-action svg { width: 17px; height: 17px; }
        .module-action.disabled {
            color: #8997a9;
            background: #f5f7fa;
            border: 1px solid #e6ebf1;
            box-shadow: none;
            cursor: not-allowed;
        }
        .module-action.disabled:hover { transform: none; box-shadow: none; }
        .card-status { position: relative; z-index: 1; display: flex; align-items: center; gap: 7px; margin: 0 0 15px; color: #8a97a9; font-size: 11px; font-weight: 650; letter-spacing: .25px; text-transform: uppercase; }
        .status-dot { width: 6px; height: 6px; background: #1680ff; border-radius: 50%; box-shadow: 0 0 0 4px #eaf3ff; }
        .calendar .status-dot, .reports .status-dot { background: #aab6c4; box-shadow: 0 0 0 4px #f1f4f7; }

        .page-footer { display: flex; align-items: center; justify-content: space-between; gap: 16px; margin: 28px 4px 0; color: #98a4b4; font-size: 11px; }
        .footer-brand { display: inline-flex; align-items: center; gap: 7px; }
        .footer-brand svg { width: 14px; height: 14px; color: #6f8aa7; }

        @media (max-width: 1200px) {
            .module-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
            .module-card:last-child { grid-column: 1 / -1; }
        }
        @media (max-width: 850px) {
            :root { --sidebar-width: 270px; }
            .sidebar { transform: translateX(-100%); transition: transform .25s ease; box-shadow: 15px 0 40px rgba(5,25,48,.2); }
            .sidebar.is-open { transform: translateX(0); }
            .sidebar-backdrop { position: fixed; inset: 0; z-index: 20; display: none; background: rgba(6,25,46,.42); backdrop-filter: blur(2px); }
            .sidebar-backdrop.is-visible { display: block; }
            .main-content { margin-left: 0; padding: 18px 18px 30px; }
            .mobile-bar { display: flex; align-items: center; justify-content: space-between; gap: 14px; margin-bottom: 17px; }
            .mobile-brand { display: flex; align-items: center; gap: 10px; color: var(--navy); font-size: 14px; font-weight: 750; }
            .mobile-brand .mini-mark { display: grid; width: 36px; height: 36px; place-items: center; color: #fff; background: var(--navy); border-radius: 11px; }
            .mobile-brand svg { width: 20px; height: 20px; }
            .menu-toggle { display: grid; width: 42px; height: 42px; place-items: center; color: var(--navy); background: #fff; border: 1px solid var(--line); border-radius: 12px; cursor: pointer; }
            .menu-toggle svg { width: 21px; height: 21px; }
            .page-header { min-height: 0; padding: 24px; }
            .page-header::after { right: -60px; }
        }
        @media (max-width: 600px) {
            .main-content { padding: 14px 13px 24px; }
            .page-header { align-items: flex-start; flex-direction: column; gap: 18px; margin-bottom: 24px; padding: 22px 20px; border-radius: 18px; }
            .page-title { font-size: 26px; }
            .page-subtitle { font-size: 13px; }
            .admin-pill { padding: 7px 13px 7px 8px; }
            .admin-avatar { width: 32px; height: 32px; }
            .section-heading { margin-bottom: 13px; }
            .module-grid { grid-template-columns: 1fr; gap: 15px; }
            .module-card:last-child { grid-column: auto; }
            .module-card { min-height: 315px; padding: 23px 21px 21px; }
            .card-top { margin-bottom: 20px; }
            .module-card h3 { font-size: 18px; }
            .page-footer { align-items: flex-start; flex-direction: column; gap: 8px; margin-top: 23px; }
        }
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { scroll-behavior: auto !important; transition-duration: .01ms !important; animation-duration: .01ms !important; }
        }
    </style>
</head>
<body>
<div class="app-shell">
    <div class="sidebar-backdrop" id="sidebarBackdrop" aria-hidden="true"></div>

    <aside class="sidebar" id="sidebar" aria-label="Navegación principal">
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
                    <a class="nav-link is-active" href="menuPrincipal.jsp" aria-current="page">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m3 10 9-7 9 7"/><path d="M5 9.5V21h14V9.5M9 21v-7h6v7"/></svg>
                        <span>Menú Principal</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="usuarios.jsp">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M16 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2"/><circle cx="9.5" cy="7" r="4"/><path d="M20 8v6m-3-3h6M16.5 4.5a4 4 0 0 1 0 7.8M17 15h1a3 3 0 0 1 3 3v1"/></svg>
                        <span>Gestión de Usuarios</span>
                    </a>
                </li>
                <li class="nav-divider" aria-hidden="true"></li>
                <li>
                    <a class="nav-link logout" href="login.jsp">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M10 17l5-5-5-5M15 12H3"/><path d="M12 3h6a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-6"/></svg>
                        <span>Cerrar Sesión</span>
                    </a>
                </li>
            </ul>
        </nav>

        <div class="sidebar-bottom" aria-hidden="true">
            <div class="tiny-line"></div>
            Sistema integrado de gestión hospitalaria
        </div>
    </aside>

    <main class="main-content">
        <div class="mobile-bar">
            <div class="mobile-brand">
                <span class="mini-mark" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 21V5.5A1.5 1.5 0 0 1 5.5 4H10v17M10 8h4m-2-2v4M14 21V3.5A1.5 1.5 0 0 1 15.5 2H19a1 1 0 0 1 1 1v18M2 21h20"/></svg>
                </span>
                Clínica La Luz
            </div>
            <button class="menu-toggle" id="menuToggle" type="button" aria-label="Abrir menú" aria-expanded="false" aria-controls="sidebar">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
            </button>
        </div>

        <header class="page-header">
            <div class="header-copy">
                <div class="eyebrow" aria-hidden="true"></div>
                <h1 class="page-title">Panel de Control</h1>
                <p class="page-subtitle">Bienvenido al sistema integrado de gestión hospitalaria.</p>
            </div>
            <div class="admin-pill" aria-label="Usuario actual: Administrador">
                <span class="admin-avatar" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="3.5"/><path d="M5 20a7 7 0 0 1 14 0M18.5 5.5l1.5 1v3.2c0 2.3-1.4 4.1-3.5 5.1-2.1-1-3.5-2.8-3.5-5.1V6.5l3.5-1.7z"/></svg>
                </span>
                <span>Administrador</span>
            </div>
        </header>

        <section aria-labelledby="modulesTitle">
            <div class="section-heading">
                <div>
                    <h2 id="modulesTitle">Módulos del sistema</h2>
                    <p>Accede rápidamente a las herramientas administrativas.</p>
                </div>
            </div>

            <div class="module-grid">
                <article class="module-card primary">
                    <div class="card-top">
                        <div class="module-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H7a4 4 0 0 0-4 4v2"/><circle cx="9.5" cy="7" r="4"/><path d="M20 8v6m-3-3h6M16.5 4.5a4 4 0 0 1 0 7.8M17 15h1a3 3 0 0 1 3 3v1"/></svg>
                        </div>
                        <span class="card-arrow" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m9 18 6-6-6-6"/></svg></span>
                    </div>
                    <div class="card-status"><span class="status-dot"></span> Módulo disponible</div>
                    <h3>Gestión de Usuarios</h3>
                    <p>Administre cuentas de acceso, roles corporativos, credenciales y estados de seguridad del personal.</p>
                    <a href="usuarios.jsp" class="module-action">
                        Acceder al Módulo
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 12h14m-6-6 6 6-6 6"/></svg>
                    </a>
                </article>

                <article class="module-card calendar">
                    <div class="card-top">
                        <div class="module-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M16 3v4M8 3v4M3 10h18m-13 5 2 2 4-4"/></svg>
                        </div>
                        <span class="card-arrow" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m9 18 6-6-6-6"/></svg></span>
                    </div>
                    <div class="card-status"><span class="status-dot"></span> En preparación</div>
                    <h3>Citas Médicas</h3>
                    <p>Control y programación centralizada de citas, especialidades y atención de pacientes.</p>
                    <button class="module-action disabled" type="button" disabled>Próximamente</button>
                </article>

                <article class="module-card reports">
                    <div class="card-top">
                        <div class="module-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3v9h9A9 9 0 1 1 12 3Z"/><path d="M16 3.7A9 9 0 0 1 21 9h-5V3.7Z"/></svg>
                        </div>
                        <span class="card-arrow" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m9 18 6-6-6-6"/></svg></span>
                    </div>
                    <div class="card-status"><span class="status-dot"></span> En preparación</div>
                    <h3>Reportería y Logs</h3>
                    <p>Supervisión de auditorías, intentos fallidos de acceso y reportes exportables a Excel.</p>
                    <button class="module-action disabled" type="button" disabled>Próximamente</button>
                </article>
            </div>
        </section>

        <footer class="page-footer">
            <span class="footer-brand">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 3v18M3 12h18"/><rect x="5" y="5" width="14" height="14" rx="4"/></svg>
                Clínica La Luz · Portal Administrativo
            </span>
            <span>Gestión hospitalaria</span>
        </footer>
    </main>
</div>

<script>
    (function () {
        const sidebar = document.getElementById('sidebar');
        const toggle = document.getElementById('menuToggle');
        const backdrop = document.getElementById('sidebarBackdrop');

        function closeMenu() {
            if (!sidebar || !toggle || !backdrop) return;
            sidebar.classList.remove('is-open');
            backdrop.classList.remove('is-visible');
            toggle.setAttribute('aria-expanded', 'false');
            toggle.setAttribute('aria-label', 'Abrir menú');
        }

        if (toggle && sidebar && backdrop) {
            toggle.addEventListener('click', function () {
                const isOpen = sidebar.classList.toggle('is-open');
                backdrop.classList.toggle('is-visible', isOpen);
                toggle.setAttribute('aria-expanded', String(isOpen));
                toggle.setAttribute('aria-label', isOpen ? 'Cerrar menú' : 'Abrir menú');
            });
            backdrop.addEventListener('click', closeMenu);
            document.addEventListener('keydown', function (event) {
                if (event.key === 'Escape') closeMenu();
            });
            window.addEventListener('resize', function () {
                if (window.innerWidth > 850) closeMenu();
            });
        }
    })();
</script>
</body>
</html>
