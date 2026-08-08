import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController mensajeController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final ChatService chatService = ChatService();

  final List<Message> mensajes = [
    Message(
      text: "🌿 Hola, soy Proyecto Raíz.",
      isUser: false,
    ),
    Message(
      text: "Me alegra que estés aquí.",
      isUser: false,
    ),
    Message(
      text: "¿Cómo te sientes hoy?",
      isUser: false,
    ),
  ];

  void enviarMensaje() {
    final texto = mensajeController.text.trim();

    if (texto.isEmpty) return;

    // Oculta el teclado.
    FocusScope.of(context).unfocus();

    // Agrega el mensaje del usuario.
    setState(() {
      mensajes.add(
        Message(
          text: texto,
          isUser: true,
        ),
      );
    });

    mensajeController.clear();

    // Obtiene la respuesta del ChatService.
    final respuesta = chatService.responder(texto);

    // Agrega la respuesta del asistente.
    setState(() {
      mensajes.add(
        Message(
          text: respuesta,
          isUser: false,
        ),
      );
    });

    // Desplaza automáticamente el chat hacia abajo.
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;

      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    mensajeController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistente IA"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: mensajes.length,

              itemBuilder: (context, index) {
                final Message mensaje = mensajes[index];
                final bool esUsuario = mensaje.isUser;

                return Align(
                  alignment: esUsuario
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                    ),

                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: esUsuario
                          ? Colors.green
                          : Colors.green.shade50,

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Text(
                      mensaje.text,

                      style: TextStyle(
                        color: esUsuario
                            ? Colors.white
                            : Colors.black87,

                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),

              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: mensajeController,

                      textInputAction: TextInputAction.send,

                      onSubmitted: (_) => enviarMensaje(),

                      decoration: InputDecoration(
                        hintText: "Escribe un mensaje...",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.green,

                    child: IconButton(
                      onPressed: enviarMensaje,

                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}