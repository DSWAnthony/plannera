import 'package:flutter/material.dart';
import 'package:plannera/core/routes/app_router.dart';
import 'package:plannera/core/security/state/auth_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Añade esta importación

class PlannerApp extends StatelessWidget {
  final AuthCubit authCubit;
  const PlannerApp({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Plannera',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Inglés
        Locale('es', ''), // Español
      ],
      locale: const Locale('es','ES'),
      routerConfig: createRouter(authCubit),
      debugShowCheckedModeBanner: false,
    );
  }
}
