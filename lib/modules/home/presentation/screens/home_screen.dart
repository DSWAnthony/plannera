import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(

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

              _buildCard(
                context, 
                Icons.monetization_on_rounded, 
                'Balance Mensual', 
                '\$2.450', 
                '+\$150'
              ),

              const SizedBox(height: 20 ,),

              _buildCard(
                context, 
                Icons.task_alt_rounded, 
                'Tareas Completadas', 
                '23/30', 
                '77%'
              ),

              const SizedBox(height: 20,),

              _buildCard(
                context, 
                Icons.date_range_outlined, 
                'Rutinas de Hoy', 
                '5/8', 
                '63%'
              ),

              const SizedBox(height: 20,),

              Semantics(
                container: true,
                label: 'Actividades Recientes',
                child: Container(
                  width: 600,
                  height: 900,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Icon(Icons.analytics_outlined),
                              const SizedBox(width: 20,),
                              Text(
                                'Actividad Reciente',
                                style: TextStyle(
                                  fontSize: 25
                                ),
                              ),
                            ],
                          )
                        ),


                        Card(                    
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          elevation: 1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text('Ejercicio Matutino'),
                                  Text('Hace 2 Horas', style: TextStyle(color: Colors.grey[500]),)
                              ],
                            )
                          ),
                        ),
                        Card(                    
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          elevation: 1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text('Ingreso Freelance'),
                                  Text('Hace 2 Horas', style: TextStyle(color: Colors.grey[500]),)
                              ],
                            )
                          ),
                        ),
                    ],
                  )
                )
                
              )

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCard(
    BuildContext context,
    IconData icon,
    String title,
    String balance,
    String porcent
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Semantics(
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

                        CircleAvatar(
                          radius: 28,
                          backgroundColor: theme.colorScheme.primary,
                          child: Icon(icon, color: Colors.white, size: 28),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( title, style: textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(balance, style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_outward_rounded, color: Colors.green, size: 16),
                            SizedBox(height: 2),
                            Text(porcent, style: TextStyle(color: Colors.green, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
