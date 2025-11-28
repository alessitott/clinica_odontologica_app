import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgendaSemanal extends StatefulWidget {
  const AgendaSemanal({super.key});

  @override
  State<AgendaSemanal> createState() => _AgendaSemanalState();
}

class _AgendaSemanalState extends State<AgendaSemanal> {
  final List<TextEditingController> controllers = [
    TextEditingController(), // Lunes
    TextEditingController(), // Martes
    TextEditingController(), // Miércoles
    TextEditingController(), // Jueves
    TextEditingController(), // Viernes
  ];

  String resultado = '';

  void calcularResumen() {
    // Lista para guardar las citas de cada día
    final List<int> citasPorDia = [];

    // Usar ciclo for para iterar y obtener los valores
    for (int i = 0; i < 5; i++) {
      final texto = controllers[i].text;
      if (texto.isEmpty) {
        setState(() {
          resultado = 'Por favor complete todos los campos';
        });
        return;
      }

      final citas = int.tryParse(texto);
      if (citas == null || citas < 0) {
        setState(() {
          resultado = 'Por favor ingrese números válidos';
        });
        return;
      }

      citasPorDia.add(citas);
    }

    // Calcular total usando ciclo
    int totalCitas = 0;
    for (int i = 0; i < citasPorDia.length; i++) {
      totalCitas = totalCitas + citasPorDia[i];
    }

    // Calcular promedio
    final promedio = totalCitas / 5;

    // Mostrar mensaje con el resumen
    setState(() {
      resultado = 'Resumen Semanal:\n\n'
          'Total de citas de la semana: $totalCitas\n'
          'Promedio de citas por día: ${promedio.toStringAsFixed(1)}';
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de la Semana'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingrese el número de citas programadas por día:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Usar ciclo para crear los campos
            for (int i = 0; i < 5; i++) ...[
              Text(
                dias[i],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: controllers[i],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Citas del ${dias[i]}',
                ),
              ),
              const SizedBox(height: 15),
            ],
            ElevatedButton(
              onPressed: calcularResumen,
              child: const Text('Calcular resumen semanal'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                resultado.isEmpty
                    ? 'El resumen aparecerá aquí'
                    : resultado,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
