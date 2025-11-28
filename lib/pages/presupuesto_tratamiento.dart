import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PresupuestoTratamiento extends StatefulWidget {
  const PresupuestoTratamiento({super.key});

  @override
  State<PresupuestoTratamiento> createState() =>
      _PresupuestoTratamientoState();
}

class _PresupuestoTratamientoState extends State<PresupuestoTratamiento> {
  String? tipoTratamiento;
  final sesionesController = TextEditingController();
  String resultado = '';

  // Tabla de precios ficticia en memoria
  final Map<String, int> precios = {
    'Limpieza': 20,
    'Caries': 30,
    'Ortodoncia': 50,
  };

  void calcularPresupuesto() {
    if (tipoTratamiento == null) {
      setState(() {
        resultado = 'Por favor seleccione un tipo de tratamiento';
      });
      return;
    }

    final sesionesTexto = sesionesController.text;
    if (sesionesTexto.isEmpty) {
      setState(() {
        resultado = 'Por favor ingrese la cantidad de sesiones';
      });
      return;
    }

    final sesiones = int.tryParse(sesionesTexto);
    if (sesiones == null || sesiones <= 0) {
      setState(() {
        resultado = 'Por favor ingrese un número válido de sesiones';
      });
      return;
    }

    // Obtener precio por sesión
    final precioPorSesion = precios[tipoTratamiento]!;

    // Calcular total: total = precioPorSesion x sesiones
    final total = precioPorSesion * sesiones;

    // Mostrar mensaje con tipo de tratamiento y total
    setState(() {
      resultado = 'Tratamiento: $tipoTratamiento\n'
          'Sesiones: $sesiones\n'
          'Precio por sesión: \$$precioPorSesion\n'
          'Total: \$$total';
    });
  }

  @override
  void dispose() {
    sesionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuesto de Tratamiento'),
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
              'Seleccione el tipo de tratamiento:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: tipoTratamiento,
              hint: const Text('Seleccione un tratamiento'),
              isExpanded: true,
              items: precios.keys.map((String tratamiento) {
                return DropdownMenuItem<String>(
                  value: tratamiento,
                  child: Text(tratamiento),
                );
              }).toList(),
              onChanged: (String? nuevoValor) {
                setState(() {
                  tipoTratamiento = nuevoValor;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingrese la cantidad de sesiones:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: sesionesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ejemplo: 5',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularPresupuesto,
              child: const Text('Calcular presupuesto'),
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
                    ? 'El resultado aparecerá aquí'
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
