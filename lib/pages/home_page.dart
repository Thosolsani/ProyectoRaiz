import 'package:flutter/material.dart';
import '../widgets/menu_button.dart';
import '../widgets/emoji_button.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String emocionSeleccionada = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text("Proyecto Raíz"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 20),

            const Text(
              "Hola 👋",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 8),

            const Text(
              "¿Cómo te sientes hoy?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                EmojiButton(
                  emoji: "😊",
                  texto: "Feliz",
                  onTap: () {
                    setState(() {
                      emocionSeleccionada = "😊 Feliz";
                    });
                  },
                ),

                EmojiButton(
                  emoji: "😌",
                  texto: "Calma",
                  onTap: () {
                    setState(() {
                      emocionSeleccionada = "😌 Calma";
                    });
                  },
                ),

                EmojiButton(
                  emoji: "😐",
                  texto: "Normal",
                  onTap: () {
                    setState(() {
                      emocionSeleccionada = "😐 Normal";
                    });
                  },
                ),

                EmojiButton(
                  emoji: "😔",
                  texto: "Triste",
                  onTap: () {
                    setState(() {
                      emocionSeleccionada = "😔 Triste";
                    });
                  },
                ),

                EmojiButton(
                  emoji: "😴",
                  texto: "Cansado",
                  onTap: () {
                    setState(() {
                      emocionSeleccionada = "😴 Cansado";
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                emocionSeleccionada.isEmpty
                    ? "Selecciona cómo te sientes"
                    : "Hoy te sientes: $emocionSeleccionada",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            MenuButton(
              icon: Icons.smart_toy,
              texto: "Hablar con la IA",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            MenuButton(
              icon: Icons.book,
              texto: "Diario emocional",
              onPressed: () {},
            ),

            const SizedBox(height: 15),

            MenuButton(
              icon: Icons.air,
              texto: "Respiración guiada",
              onPressed: () {},
            ),

            const SizedBox(height: 15),

            MenuButton(
              icon: Icons.self_improvement,
              texto: "Meditación",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}