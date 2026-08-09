import '../config/app_config.dart';
import '../interfaces/ai_service.dart';
import 'local_ai_service.dart';
import 'remote_ai_service.dart';

class ChatService {
  final AIService aiService;

  ChatService({
    AIService? aiService,
  }) : aiService = aiService ?? _crearServicio();

  static AIService _crearServicio() {
    if (AppConfig.useLocalAI) {
      return LocalAIService();
    }

    return RemoteAIService();
  }

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