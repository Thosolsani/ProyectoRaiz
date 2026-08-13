import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../interfaces/ai_service.dart';

class RemoteAIService implements AIService {
  @override
  Future<String> enviarMensaje({
    required String mensaje,
    required List<String> historial,
  }) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/api/chat');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'mensaje': mensaje,
        'historial': historial,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['respuesta'] as String;
    }

    throw Exception(
      'Error del servidor: ${response.statusCode}',
    );
  }
}