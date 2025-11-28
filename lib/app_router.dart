import 'package:go_router/go_router.dart';

import 'pages/agenda_semanal.dart';
import 'pages/home_page.dart';
import 'pages/presupuesto_tratamiento.dart';
import 'pages/registro_paciente.dart';
import 'pages/tratamiento_del_dia.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const ClinicHomePage()),
    GoRoute(path: '/registro', builder: (_, __) => const RegistroPaciente()),
    GoRoute(path: '/presupuesto',builder: (_, __) => const PresupuestoTratamiento()),
    GoRoute(path: '/agenda',builder: (_, __) => const AgendaSemanal()),
    // GoRoute(path: '/tratamiedo_dia', builder: (_, __) => const AtmFeePage()),
  ],
);
