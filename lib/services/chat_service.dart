class ChatService {
  String responder(String mensaje) {
    final texto = mensaje.toLowerCase().trim();

    if (texto.contains('hola')) {
      return '🌿 Hola. Me alegra que estés aquí. ¿Cómo te sientes hoy?';
    }

    if (texto.contains('bien') ||
        texto.contains('feliz') ||
        texto.contains('contento')) {
      return '💚 Me alegra saberlo. ¿Qué crees que está contribuyendo a que te sientas así?';
    }

    if (texto.contains('triste') ||
        texto.contains('mal') ||
        texto.contains('deprimido')) {
      return '🌿 Gracias por contármelo. Estoy aquí para escucharte. ¿Quieres contarme un poco más sobre lo que estás sintiendo?';
    }

    if (texto.contains('ansioso') ||
        texto.contains('ansiedad') ||
        texto.contains('estresado') ||
        texto.contains('estrés')) {
      return '🌿 Entiendo. Podemos ir paso a paso. ¿Qué es lo que más te está preocupando en este momento?';
    }

    return '💚 Gracias por compartirlo conmigo. Cuéntame un poco más para poder acompañarte mejor.';
  }
}