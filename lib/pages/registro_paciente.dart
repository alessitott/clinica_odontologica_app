// registro del paciente
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistroPaciente extends StatefulWidget {
  const RegistroPaciente({super.key});

  @override
  State<RegistroPaciente> createState() => _RegistroPacienteState();
  //validacion de datos: nombre, cedula y seleccion:( Limpieza, Ortodoncia, Endodoncia, Estética)
}

class _RegistroPacienteState extends State<RegistroPaciente> {
  //validacion que datos ingrados no esten vacios para el registro: nombre, cedula y seleccion:( Limpieza, Ortodoncia, Endodoncia, Estética)
  String nombre = 'nombre';
  int cedula = 0;
  final List<String> tratamientos = [
    'Limpieza',
    'Ortodoncia',
    'Endodoncia',
    'Estética',
  ];
  String mensaje = '';
  void validarDatos() {
    if (nombre.isEmpty || cedula == 0) {
      setState(() {
        mensaje = 'Complete todos los campos obligatorios.';
      });
      return;
    }

    setState(() {
      mensaje = 'Registro exitoso.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Paciente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),

      //formulario de registro de paciente con campos de texto para nombre, cedula y
      // un dropdown para seleccionar el tratamiento, usar validarDatos
      //en el boton de registrar paciente
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              onChanged: (value) {
                nombre = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Cédula'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                cedula = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Tratamiento'),
              items: tratamientos
                  .map(
                    (tratamiento) => DropdownMenuItem(
                      value: tratamiento,
                      child: Text(tratamiento),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                // Manejar selección de tratamiento si es necesario
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: validarDatos,
              child: const Text('Registrar Paciente'),
            ),
            const SizedBox(height: 16),
            Text(mensaje, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
