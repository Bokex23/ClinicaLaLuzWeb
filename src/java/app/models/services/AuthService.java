package app.models.services;

import app.models.entities.Usuario;
import app.models.repositories.UsuarioRepository;
import org.mindrot.jbcrypt.BCrypt; // Importación de la nueva librería

public class AuthService {
    private final UsuarioRepository usuarioRepository;

    public AuthService() {
        this.usuarioRepository = new UsuarioRepository();
    }

    public String procesarLogin(String nombreUsuario, String claveIngresada) {
        Usuario usuario = usuarioRepository.buscarPorUsuario(nombreUsuario);

        if (usuario == null) {
            return "El usuario ingresado no existe.";
        }

        if ("bloqueado".equalsIgnoreCase(usuario.getEstado())) {
            return "Su cuenta está bloqueada por exceder los intentos fallidos.";
        }

        // Verificamos contraseña encriptada usando jBCrypt
        if (BCrypt.checkpw(claveIngresada, usuario.getContrasenaHash())) {
            usuario.restablecerIntentos();
            usuarioRepository.actualizarIntentosYEstado(usuario);
            return "Exito";
        } else {
            int intentos = usuario.getIntentosFallidos() + 1;
            usuario.setIntentosFallidos(intentos);

            if (intentos >= 3) {
                usuario.bloquearCuenta();
                usuarioRepository.actualizarIntentosYEstado(usuario);
                return "Contraseña incorrecta. Has alcanzado 3 intentos fallidos, tu cuenta ha sido bloqueada.";
            }

            usuarioRepository.actualizarIntentosYEstado(usuario);
            return "Contraseña incorrecta. Intentos fallidos: " + intentos + " de 3.";
        }
    }

    // Método temporal para generar tu hash de prueba.
    // Clic derecho en este archivo -> "Run File" para ver el hash en la consola.
    public static void main(String[] args) {
        String hashGenerado = BCrypt.hashpw("admin123", BCrypt.gensalt());
        System.out.println("Copia el siguiente texto y ponlo en tu UPDATE de SQL Server:");
        System.out.println(hashGenerado);
    }
}