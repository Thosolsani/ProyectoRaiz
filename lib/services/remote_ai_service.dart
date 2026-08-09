import '../interfaces/ai_service.dart';

class RemoteAIService implements AIService {
  @override
  Future<String> enviarMensaje({
    required String mensaje,
    required List<String> historial,
  }) async {
    // Esta implementación será conectada posteriormente
    // con nuestro servidor seguro.

    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    return '🌿 Esta es una respuesta de prueba de la IA remota.';
  }
}