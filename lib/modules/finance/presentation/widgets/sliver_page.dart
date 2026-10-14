import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DynamicCalendarScreen extends StatefulWidget {
  const DynamicCalendarScreen({super.key});

  @override
  State<DynamicCalendarScreen> createState() => _DynamicCalendarScreenState();
}

class _DynamicCalendarScreenState extends State<DynamicCalendarScreen> {
  final ScrollController _scrollController = ScrollController();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  double _lastScrollOffset = 0;

  // Lista de eventos de ejemplo
  final List<Map<String, dynamic>> _events = [
    {'title': 'Reunión de equipo', 'time': '10:00 AM'},
    {'title': 'Almuerzo con cliente', 'time': '1:30 PM'},
    {'title': 'Revisión de proyecto', 'time': '3:00 PM'},
    {'title': 'Entrenamiento', 'time': '5:00 PM'},
    {'title': 'Reunión de equipo', 'time': '10:00 AM'},
    {'title': 'Almuerzo con cliente', 'time': '1:30 PM'},
    {'title': 'Revisión de proyecto', 'time': '3:00 PM'},
    {'title': 'Entrenamiento', 'time': '5:00 PM'},
    {'title': 'Reunión de equipo', 'time': '10:00 AM'},
    {'title': 'Almuerzo con cliente', 'time': '1:30 PM'},
    {'title': 'Revisión de proyecto', 'time': '3:00 PM'},
    {'title': 'Entrenamiento', 'time': '5:00 PM'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final double currentOffset = _scrollController.offset;
    final double threshold = 100.0; // Umbral para cambiar de vista

    // Detectar cuando el usuario hace scroll hacia arriba más allá del tope
    if (currentOffset < _lastScrollOffset && currentOffset <= -threshold) {
      // Cambiar a vista mensual
      if (_calendarFormat != CalendarFormat.month) {
        setState(() {
          _calendarFormat = CalendarFormat.month;
        });
      }
    } 
    // Detectar cuando el usuario hace scroll hacia abajo
    else if (currentOffset > _lastScrollOffset && currentOffset > 0) {
      // Cambiar a vista semanal
      if (_calendarFormat != CalendarFormat.week) {
        setState(() {
          _calendarFormat = CalendarFormat.week;
        });
      }
    }

    _lastScrollOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          // SliverAppBar que se expande dinámicamente pero siempre está visible
          SliverAppBar(
            pinned: true, // Siempre fija en la parte superior
            floating: false,
            snap: false,
            expandedHeight: _calendarFormat == CalendarFormat.month ? 400.0 : 170.0,
            // Forzar que siempre esté expandida cuando está en vista semanal
            collapsedHeight: _calendarFormat == CalendarFormat.week ? 170.0 : kToolbarHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Lista de eventos
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final event = _events[index % _events.length];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(event['title']),
                  subtitle: Text(event['time']),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
              childCount: _events.length * 3,
            ),
          ),
        ],
      ),
    );
  }
}