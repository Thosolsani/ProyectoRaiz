abstract class AIService {
  Future<String> enviarMensaje({
    required String mensaje,
    required List<String> historial,
  });
}