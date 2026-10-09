<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clínica La Luz - Iniciar Sesión</title>
    <!-- Fuentes e Íconos -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="login-wrapper">
        <!-- Panel Izquierdo (Intacto) -->
        <div class="hero-panel">
            <div class="hero-top">
                <div class="brand-logo">
                    <div class="logo-icon">
                        <svg viewBox="0 0 100 100" class="clinic-cross">
                            <defs>
                                <linearGradient id="luzGradTop" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" stop-color="#008ce3"/>
                                    <stop offset="100%" stop-color="#00a3e0"/>
                                </linearGradient>
                                <linearGradient id="luzGradBottom" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" stop-color="#1cc2f2"/>
                                    <stop offset="100%" stop-color="#0099e6"/>
                                </linearGradient>
                            </defs>
                            <path d="M 45 6 C 24 6 6 24 6 45 C 24 45 45 33 45 6 Z" fill="url(#luzGradTop)"/>
                            <path d="M 55 6 C 55 33 76 45 94 45 C 94 24 76 6 55 6 Z" fill="#0077c8"/>
                            <path d="M 6 55 C 6 76 24 94 45 94 C 45 67 27 55 6 55 Z" fill="#005fa3"/>
                            <path d="M 94 55 C 67 55 55 67 55 94 C 76 94 94 76 94 55 Z" fill="url(#luzGradBottom)"/>
                        </svg>
                    </div>
                    <div class="brand-text">
                        <span class="brand-small">Clínica</span>
                        <span class="brand-large">La Luz</span>
                    </div>
                </div>

                <div class="hero-heading">
                    <h1>Tu salud, nuestra prioridad</h1>
                    <p>Brindamos atención médica de calidad, con tecnología de vanguardia y un equipo de profesionales comprometidos con tu bienestar.</p>
                </div>
            </div>

            <!-- Franja azul inferior con curvas -->
            <div class="hero-bottom-wave">
                <svg class="wave-shape" viewBox="0 0 500 120" preserveAspectRatio="none">
                    <path d="M0,40 C150,90 350,-10 500,30 L500,120 L0,120 Z" fill="#1869a8"></path>
                </svg>
                <div class="hero-features">
                    <div class="feature-item">
                        <i class="fa-regular fa-calendar-days feature-icon"></i>
                        <h4>Agenda tus citas</h4>
                        <p>de forma rápida y segura</p>
                    </div>
                    <div class="feature-divider"></div>
                    <div class="feature-item">
                        <i class="fa-shield-halved fa-solid feature-icon"></i>
                        <h4>Tus datos protegidos</h4>
                        <p>con los más altos estándares</p>
                    </div>
                    <div class="feature-divider"></div>
                    <div class="feature-item">
                        <i class="fa-solid fa-heart-pulse feature-icon"></i>
                        <h4>Mejor atención,</h4>
                        <p>siempre</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Panel Derecho con Partículas Interactivas -->
        <div class="form-panel">
            <canvas id="particleCanvas"></canvas>

            <div class="login-card">
                <div class="card-header">
                    <h2>Bienvenido</h2>
                    <p>Inicia sesión para acceder al sistema</p>
                </div>

                <!-- Mensaje de error dinámico en la misma pantalla (JSP) -->
                <% 
                    String errorMsg = (String) request.getAttribute("mensajeError");
                    if (errorMsg != null && !errorMsg.isEmpty()) { 
                %>
                <div class="alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span><%= errorMsg %></span>
                </div>
                <% } %>

                <form action="<%=request.getContextPath()%>/AuthServlet" method="POST" class="form-body">
                    <div class="input-group">
                        <label for="usuario"><i class="fa-solid fa-user"></i> Usuario</label>
                        <input type="text" name="txtUsuario" placeholder="Ingrese su usuario" 
                               value="<%= request.getAttribute("usuario_previo") != null ? request.getAttribute("usuario_previo") : "" %>" required>
                    </div>

                    <div class="input-group">
                        <label for="password"><i class="fa-solid fa-lock"></i> Contraseña</label>
                        <div class="password-wrapper">
                            <input type="password" name="txtClave" id="password" placeholder="Ingrese su contraseña" 
                                   value="<%= request.getAttribute("clave_previo") != null ? request.getAttribute("clave_previo") : "" %>" required>
                            <button type="button" class="toggle-password" id="togglePassword">
                                <i class="fa-regular fa-eye-slash" id="eyeIcon"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-options">
                        <label class="checkbox-container">
                            <input type="checkbox" name="remember" checked>
                            <span class="checkmark"></span>
                            Recordar mi sesión
                        </label>
                    </div>

                    <button type="submit" class="btn-primary">
                        <span>Ingresar</span>
                        <i class="fa-solid fa-arrow-right"></i>
                    </button>

                    <div class="divider">
                        <span>¿Olvidaste tu contraseña?</span>
                    </div>

                    <div class="security-badge">
                        <i class="fa-solid fa-lock"></i>
                        <span>Sistema seguro de la Clínica La Luz</span>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts de interactividad (Intactos) -->
    <script>
        // Mostrar / Ocultar Contraseña
        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#password');
        const eyeIcon = document.querySelector('#eyeIcon');

        togglePassword.addEventListener('click', function () {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            eyeIcon.classList.toggle('fa-eye');
            eyeIcon.classList.toggle('fa-eye-slash');
        });

        // Animación Interactiva de Nodos/Partículas
        const canvas = document.getElementById('particleCanvas');
        const ctx = canvas.getContext('2d');

        function resizeCanvas() {
            canvas.width = canvas.parentElement.clientWidth;
            canvas.height = canvas.parentElement.clientHeight;
        }
        window.addEventListener('resize', resizeCanvas);
        resizeCanvas();

        let mouse = { x: null, y: null, radius: 130 };

        canvas.addEventListener('mousemove', function(event) {
            const rect = canvas.getBoundingClientRect();
            mouse.x = event.clientX - rect.left;
            mouse.y = event.clientY - rect.top;
        });

        canvas.addEventListener('mouseleave', function() {
            mouse.x = null;
            mouse.y = null;
        });

        class Particle {
            constructor() {
                this.x = Math.random() * canvas.width;
                this.y = Math.random() * canvas.height;
                this.vx = (Math.random() - 0.5) * 1.2;
                this.vy = (Math.random() - 0.5) * 1.2;
                this.radius = Math.random() * 2.5 + 1.5;
            }
            update() {
                this.x += this.vx;
                this.y += this.vy;

                if (this.x < 0 || this.x > canvas.width) this.vx = -this.vx;
                if (this.y < 0 || this.y > canvas.height) this.vy = -this.vy;
            }
            draw() {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx.fillStyle = 'rgba(0, 115, 230, 0.35)';
                ctx.fill();
            }
        }

        let particlesArray = [];
        for (let i = 0; i < 40; i++) {
            particlesArray.push(new Particle());
        }

        function animate() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            
            for (let i = 0; i < particlesArray.length; i++) {
                particlesArray[i].update();
                particlesArray[i].draw();

                for (let j = i + 1; j < particlesArray.length; j++) {
                    let dx = particlesArray[i].x - particlesArray[j].x;
                    let dy = particlesArray[i].y - particlesArray[j].y;
                    let distance = Math.sqrt(dx * dx + dy * dy);

                    if (distance < 100) {
                        ctx.beginPath();
                        ctx.strokeStyle = `rgba(0, 115, 230, ${0.15 * (1 - distance / 100)})`;
                        ctx.lineWidth = 0.8;
                        ctx.moveTo(particlesArray[i].x, particlesArray[i].y);
                        ctx.lineTo(particlesArray[j].x, particlesArray[j].y);
                        ctx.stroke();
                    }
                }

                if (mouse.x !== null && mouse.y !== null) {
                    let mdx = particlesArray[i].x - mouse.x;
                    let mdy = particlesArray[i].y - mouse.y;
                    let mdistance = Math.sqrt(mdx * mdx + mdy * mdy);

                    if (mdistance < mouse.radius) {
                        ctx.beginPath();
                        ctx.strokeStyle = `rgba(0, 140, 255, ${0.35 * (1 - mdistance / mouse.radius)})`;
                        ctx.lineWidth = 1;
                        ctx.moveTo(particlesArray[i].x, particlesArray[i].y);
                        ctx.lineTo(mouse.x, mouse.y);
                        ctx.stroke();
                    }
                }
            }
            requestAnimationFrame(animate);
        }
        animate();
    </script>
</body>
</html>