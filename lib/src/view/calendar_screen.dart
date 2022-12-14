import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ufcat_app/src/view/components/app_bar.dart';
import 'package:ufcat_app/src/view/style/const.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<dynamic>> _events = {
    DateTime.utc(2022, 12, 16): const [
      'Recesso de Natal',
    ],
  };
  late final ValueNotifier<List<dynamic>> _selectedEvents;

  BoxDecoration _defaultDecoration = const BoxDecoration(
    color: Colors.transparent,
    shape: BoxShape.circle,
  );

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_events[_selectedDay!] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Calendário',
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: greenUfcat,
                fontSize: 20,
              ),
            ),
            calendarStyle: CalendarStyle(
              defaultDecoration: _defaultDecoration,
              markerSizeScale: 0.15,
              markerMargin: const EdgeInsets.only(
                top: 5.0,
                left: 0.5,
                right: 0.5,
              ),
              markerDecoration: const BoxDecoration(
                color: darkUfcat,
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: orangeUfcat,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
              ),
              todayDecoration: BoxDecoration(
                color: orangeUfcat.withOpacity(0.50),
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(
                color: Colors.white,
              ),
              outsideDaysVisible: true,
            ),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                final text = DateFormat.E('pt_BR').format(day);

                return Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: greenUfcat,
                      fontSize: 11,
                    ),
                  ),
                );
              },
            ),
            locale: 'PT_BR',
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Mês',
              CalendarFormat.twoWeeks: '2 Semanas',
              CalendarFormat.week: 'Semana',
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(
                  () {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedEvents.value = _events[selectedDay] ?? [];
                  },
                );
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(
                  () {
                    _calendarFormat = format;
                  },
                );
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              if (day.isAfter(DateTime.utc(2022, 12, 16)) &&
                  day.isBefore(DateTime.utc(2023, 1, 6))) {
                _defaultDecoration = const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                );
              }
              if (_events.containsKey(day)) {
                return _events[day]!;
              }

              return [];
            },
          ),
          Container(
            height: 2,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 20,
            ),
            color: grayUfcat,
          ),
          Expanded(
            child: ValueListenableBuilder<List<dynamic>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    if (value.isEmpty) {
                      return Center(
                        child: Container(
                          color: Colors.black,
                          height: 100,
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: darkUfcat,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(
                            value[index],
                            style: const TextStyle(
                              color: darkUfcat,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
