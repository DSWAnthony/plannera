import 'package:flutter/material.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado
              Text('Finance', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Aquí puedes gestionar tus finanzas personales',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              // Aquí puedes agregar más widgets relacionados con finanzas
              // como gráficos, tablas, etc.
            ],
          ),
        ),
      )
    );
  }
}
