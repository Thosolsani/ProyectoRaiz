import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController mensajeController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Map<String, dynamic>> mensajes = [
    {
      "texto": "🌿 Hola, soy Proyecto Raíz.",
      "esUsuario": false,
    },
    {
      "texto": "Me alegra que estés aquí.",
      "esUsuario": false,
    },
    {
      "texto": "¿Cómo te sientes hoy?",
      "esUsuario": false,
    },
  ];

  void enviarMensaje() {
    final texto = mensajeController.text.trim();

    if (texto.isEmpty) return;

    // Oculta el teclado
    FocusScope.of(context).unfocus();

    setState(() {
      mensajes.add({
        "texto": texto,
        "esUsuario": true,
      });

      mensajes.add({
        "texto": "💚 Gracias por compartir eso conmigo.",
        "esUsuario": false,
      });
    });

    mensajeController.clear();

    // Desplaza automáticamente el chat hacia abajo
    Future.delayed(const Duration(milliseconds: 100), () {
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
                final bool esUsuario = mensajes[index]["esUsuario"];

                return Align(
                  alignment: esUsuario
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: esUsuario
                          ? Colors.green
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      mensajes[index]["texto"],
                      style: TextStyle(
                        color:
                            esUsuario ? Colors.white : Colors.black87,
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