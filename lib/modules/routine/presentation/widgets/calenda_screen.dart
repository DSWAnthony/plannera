import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// =======================
// Modelo del Evento
// =======================
class Event {
  final String title;
  final TimeOfDay start;
  final Duration duration;

  Event({required this.title, required this.start, required this.duration});
}

// Helper para normalizar fechas
DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

class CalendarWithDayView extends StatefulWidget {
  const CalendarWithDayView({super.key});

  @override
  State<CalendarWithDayView> createState() => _CalendarWithDayViewState();
}

class _CalendarWithDayViewState extends State<CalendarWithDayView> {
  final DateTime firstDay = DateTime.utc(2025, 1, 1);
  final DateTime lastDay = DateTime.utc(2025, 12, 31);

  late Map<DateTime, List<Event>> _events;

  DateTime _focusedDay = _dateOnly(DateTime.now());
  DateTime _selectedDay = _dateOnly(DateTime.now());
  
  // Estados para controlar la expansión del calendario
  double _calendarHeight = 200; // Altura inicial (vista semanal)
  bool _isCalendarExpanded = false;
  final double _minCalendarHeight = 200; // Vista semanal
  final double _maxCalendarHeight = 600; // Vista mensual expandida

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  // Controladores para la animación
  final GlobalKey _calendarKey = GlobalKey();
  final ValueNotifier<double> _dragProgress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();

    // Ejemplo de eventos
    _events = {
      _dateOnly(DateTime(2025, 8, 18)): [
        Event(title: "Evento A", start: const TimeOfDay(hour: 9, minute: 0), duration: const Duration(hours: 1)),
      ],
      _dateOnly(DateTime(2025, 8, 19)): [
        Event(title: "Reunión", start: const TimeOfDay(hour: 10, minute: 0), duration: const Duration(hours: 1)),
        Event(title: "Llamada", start: const TimeOfDay(hour: 15, minute: 30), duration: const Duration(minutes: 45)),
      ],
      _dateOnly(DateTime(2025, 8, 20)): [
        Event(title: "Pago servicios", start: const TimeOfDay(hour: 8, minute: 0), duration: const Duration(minutes: 30)),
      ],
    };

    // Escuchar scroll → actualizar calendario
    _itemPositionsListener.itemPositions.addListener(() {
      final positions = _itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final minIndex = positions
            .where((pos) => pos.itemTrailingEdge > 0)
            .reduce((a, b) => a.itemLeadingEdge < b.itemLeadingEdge ? a : b)
            .index;

        final newDay = _dateForIndex(minIndex);
        if (!isSameDay(_selectedDay, newDay)) {
          setState(() {
            _selectedDay = newDay;
            _focusedDay = newDay;
          });
        }
      }
    });
  }

  // Cantidad de días
  int get totalDays => lastDay.difference(firstDay).inDays + 1;

  // Índice ↔ fecha
  DateTime _dateForIndex(int index) =>
      _dateOnly(firstDay.add(Duration(days: index)));
  int _indexForDate(DateTime day) => day.difference(firstDay).inDays;

  List<Event> _getEventsForDay(DateTime day) => _events[_dateOnly(day)] ?? [];

  // Scroll animado al día
  void _scrollToDay(DateTime day) {
    final index = _indexForDate(day);
    if (index >= 0 && index < totalDays) {
      _itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // Animación para expandir/contraer el calendario
  void _toggleCalendarExpansion() {
    setState(() {
      _isCalendarExpanded = !_isCalendarExpanded;
      _calendarHeight = _isCalendarExpanded ? _maxCalendarHeight : _minCalendarHeight;
      _dragProgress.value = _isCalendarExpanded ? 1.0 : 0.0;
    });
  }

  // Manejar selección de día
  void _handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = _dateOnly(selectedDay);
      _focusedDay = _dateOnly(focusedDay);
    });
    
    // Si el calendario está expandido (vista mensual), cerrarlo
    if (_isCalendarExpanded) {
      _toggleCalendarExpansion();
    }
    
    _scrollToDay(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario estilo Google Day View"),
        actions: [
          IconButton(
            icon: Icon(_isCalendarExpanded ? Icons.expand_less : Icons.expand_more),
            onPressed: _toggleCalendarExpansion,
          ),
        ],
      ),
      body: Stack(
        children: [
          // =======================
          // Vista diaria scrolleable (fondo - ocupa toda la pantalla)
          // =======================
          Positioned.fill(
            child: ScrollablePositionedList.builder(
              itemCount: totalDays,
              itemScrollController: _itemScrollController,
              itemPositionsListener: _itemPositionsListener,
              itemBuilder: (context, index) {
                final day = _dateForIndex(index);
                final events = _getEventsForDay(day);
                return _DayView(day: day, events: events);
              },
            ),
          ),

          // =======================
          // Calendario superpuesto (arriba)
          // =======================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: (details) {
                // Arrastrar hacia abajo para expandir (aumentar altura)
                final newHeight = _calendarHeight + details.delta.dy;
                final clampedHeight = newHeight.clamp(_minCalendarHeight, _maxCalendarHeight);
                final progress = (clampedHeight - _minCalendarHeight) / (_maxCalendarHeight - _minCalendarHeight);
                
                _dragProgress.value = progress;
                setState(() {
                  _calendarHeight = clampedHeight;
                  _isCalendarExpanded = _calendarHeight > _minCalendarHeight + 50;
                });
              },
              onVerticalDragEnd: (details) {
                // Snap to nearest state
                final isExpanding = details.primaryVelocity! < 0; // Velocidad negativa = arrastre hacia arriba
                
                if (isExpanding || _calendarHeight > (_minCalendarHeight + _maxCalendarHeight) / 2) {
                  setState(() {
                    _calendarHeight = _maxCalendarHeight;
                    _isCalendarExpanded = true;
                  });
                } else {
                  setState(() {
                    _calendarHeight = _minCalendarHeight;
                    _isCalendarExpanded = false;
                  });
                }
                _dragProgress.value = _isCalendarExpanded ? 1.0 : 0.0;
              },
              child: AnimatedContainer(
                key: _calendarKey,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                height: _calendarHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                clipBehavior: Clip.antiAlias, // Asegura que el contenido no se desborde
                child: Column(
                  children: [
                    Expanded(
                      child: TableCalendar<Event>(
                        firstDay: firstDay,
                        lastDay: lastDay,
                        locale: 'es',
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Mes',
                          CalendarFormat.week: 'Semana',
                        },
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
                          weekendStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[700]),
                        ),
                        calendarBuilders: CalendarBuilders(
                          headerTitleBuilder: (context, day) {
                            final monthNames = [
                              'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
                              'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
                            ];
                            return Text(
                              '${monthNames[day.month - 1]} ${day.year}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (d) => isSameDay(_selectedDay, d),
                        eventLoader: _getEventsForDay,
                        onDaySelected: _handleDaySelected, // Usamos nuestra función personalizada
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        calendarStyle: const CalendarStyle(
                          markerDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        calendarFormat: _isCalendarExpanded ? CalendarFormat.month : CalendarFormat.week,
                      ),
                    ),
                    
                    // Indicador de arrastre
                    ValueListenableBuilder<double>(
                      valueListenable: _dragProgress,
                      builder: (context, progress, child) {
                        return Container(
                          height: 20,
                          color: Colors.transparent,
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 40 + (20 * progress),
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[600]!.withOpacity(0.5 + (0.5 * progress)),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =======================
// Widget: vista de un día
// =======================
class _DayView extends StatelessWidget {
  final DateTime day;
  final List<Event> events;

  const _DayView({required this.day, required this.events});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24 * 60, // 1px = 1 minuto → un día entero
      child: Row(
        children: [
          // Columna izquierda: horas
          Container(
            width: 60,
            color: Colors.grey[200],
            child: Column(
              children: List.generate(24, (i) {
                final hour = TimeOfDay(hour: i, minute: 0);
                return Container(
                  height: 60,
                  alignment: Alignment.topCenter,
                  child: Text(hour.format(context),
                      style: const TextStyle(fontSize: 12)),
                );
              }),
            ),
          ),
          // Columna derecha: grilla + eventos
          Expanded(
            child: Stack(
              children: [
                // Líneas de hora
                Column(
                  children: List.generate(
                    24,
                    (i) => Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                  ),
                ),
                // Eventos posicionados
                ...events.map((event) {
                  final startMinutes =
                      event.start.hour * 60 + event.start.minute;
                  final topOffset = startMinutes.toDouble();
                  final height = event.duration.inMinutes.toDouble();

                  return Positioned(
                    top: topOffset,
                    left: 8,
                    right: 8,
                    height: height,
                    child: Card(
                      color: Colors.blue[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(event.title,
                            style: const TextStyle(fontSize: 12)),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}