import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicHomePage extends StatelessWidget {
  const ClinicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clínica Odontológica')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Nuestra prioridad es tu salud dental.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 24),
            const Text(
              'Seleccione una opción:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => context.go('/registro'),
              child: const Text('Registro de paciente'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/loan'),
              child: const Text('Presupuesto de tratamiento'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/atm'),
              child: const Text('Agenda de la semana'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/atm'),
              child: const Text('Tratamientos del dìa'),
            ),
          ],
        ),
      ),
    );
  }
}
