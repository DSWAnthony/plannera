import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      // si quieres AppBar lo añades aquí
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado
              Text('Home', style: textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Bienvenido de vuelta, aquí tienes tu resumen diario',
                style: textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              // Card resumen (mejor semántica y contraste)
              Semantics(
                container: true,
                label: 'Resumen de balance mensual. Muestra el balance y la variación.',
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Leading icon con buen contraste
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: theme.colorScheme.primary,
                          child: Icon(Icons.monetization_on_rounded, color: Colors.white, size: 28),
                        ),

                        const SizedBox(width: 12),

                        // Texto principal (expandible)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Balance Mensual', style: textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text('\$2,450', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),

                        // Cambio (pequeño, alineado)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Icon(Icons.arrow_outward_rounded, color: Colors.green, size: 16),
                            SizedBox(height: 2),
                            Text('+\$150', style: TextStyle(color: Colors.green, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ... más contenido aquí
            ],
          ),
        ),
      ),
    );
  }
}
