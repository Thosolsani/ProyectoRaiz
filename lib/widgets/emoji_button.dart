import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final String emoji;
  final String texto;
  final VoidCallback onTap;

  const EmojiButton({
    super.key,
    required this.emoji,
    required this.texto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Column(
        children: [

          Text(
            emoji,
            style: const TextStyle(fontSize: 36),
          ),

          const SizedBox(height: 5),

          Text(
            texto,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}