import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(top: false, child: widget.navigationShell),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueAccent,
        currentIndex: widget.navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
            tooltip: 'Inicio'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Finanzas',
            tooltip: 'Finanzas'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Tareas',
            tooltip: 'Tareas'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: 'Rutina',
            tooltip: 'Rutina'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            label: 'Configuración', 
            tooltip: 'Configuración'
          ),
        ],
        onTap: (index) {
          widget.navigationShell.goBranch(index, initialLocation: false);
        },
      ),
    );
  }
}
