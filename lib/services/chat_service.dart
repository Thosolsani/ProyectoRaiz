import '../interfaces/ai_service.dart';
import 'local_ai_service.dart';

class ChatService {
  final AIService aiService;

  ChatService({
    AIService? aiService,
  }) : aiService = aiService ?? LocalAIService();

  Future<String> responder({
    required String mensaje,
    required List<String> historial,
  }) {
    return aiService.enviarMensaje(
      mensaje: mensaje,
      historial: historial,
    );
  }
}