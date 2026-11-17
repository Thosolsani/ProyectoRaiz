import '../models/message.dart';

abstract class AIService {
  Future<String> enviarMensaje({
    required String mensaje,
    required List<Message> historial,
  });
}