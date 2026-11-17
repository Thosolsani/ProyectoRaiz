
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentStep = 0;
  bool isFinishing = false;

  final List<String> questions = [
    '¿A qué te dedicas?',
    '¿Cuál es tu ocupación o responsabilidad principal?',
    '¿Cómo es tu entorno familiar?',
    '¿Qué te gustaría encontrar en Raíz?',
  ];

  final List<String> descriptions = [
    'Puedes contarme si trabajas, estudias o realizas otra actividad.',
    'Esto me ayudará a comprender mejor tu día a día.',
    'Comparte solamente aquello con lo que te sientas cómodo.',
    'Me gustaría saber cómo puedo acompañarte mejor.',
  ];

  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  void nextStep() {
    if (isFinishing) return;

    if (currentStep < questions.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      showCompletion();
    }
  }

  void previousStep() {
    if (isFinishing) return;

    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  Future<void> openHome() async {
    if (isFinishing) return;

    setState(() {
      isFinishing = true;
    });

    try {
      final preferences = await SharedPreferences.getInstance();

      final saved = await preferences.setBool(
        'onboarding_completed',
        true,
      );

      if (!mounted) return;

      if (!saved) {
        throw Exception('No se pudo guardar el estado de bienvenida.');
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => const HomePage(),
        ),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se pudo completar la bienvenida. '
            'Por favor, inténtalo nuevamente.',
          ),
        ),
      );

      setState(() {
        isFinishing = false;
      });
    }
  }

  void showCompletion() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Gracias por compartir'),
        content: const Text(
          'Conocerte un poco mejor puede ayudar a que nuestras '
          'conversaciones sean más personales y relevantes. '
          'Por ahora, tus respuestas no se han guardado.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              openHome();
            },
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conociéndote'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (currentStep + 1) / questions.length,
              ),
              const SizedBox(height: 32),
              Text(
                'Paso ${currentStep + 1} de ${questions.length}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                questions[currentStep],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                descriptions[currentStep],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: controllers[currentStep],
                maxLines: 3,
                enabled: !isFinishing,
                decoration: const InputDecoration(
                  hintText: 'Escribe aquí si deseas compartirlo...',
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              const Text(
                'Todas las preguntas son opcionales. '
                'Tú decides qué compartir.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (currentStep > 0)
                    TextButton(
                      onPressed: isFinishing ? null : previousStep,
                      child: const Text('Anterior'),
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: isFinishing ? null : nextStep,
                    child: const Text('Omitir'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isFinishing ? null : nextStep,
                    child: Text(
                      currentStep == questions.length - 1
                          ? 'Finalizar'
                          : 'Continuar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
