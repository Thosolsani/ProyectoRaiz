import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String texto;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.icon,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,

        icon: Icon(icon),

        label: Text(
          texto,
          style: const TextStyle(fontSize: 18),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 18),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          elevation: 3,
        ),
      ),
    );
  }
}