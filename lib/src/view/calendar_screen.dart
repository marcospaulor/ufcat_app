import 'dart:collection';

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
//   final events = LinkedHashMap(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(eventSource);
//   List<Event> _getEventsForDay(DateTime day) {
//     return events[day] ?? [];
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Calendário',
      ),
      body: TableCalendar(
        calendarBuilders: CalendarBuilders(
          todayBuilder: (context, day, focusedDay) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: orangeUfcat.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          selectedBuilder: (context, day, focusedDay) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: orangeUfcat,
              shape: BoxShape.circle,
            ),
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
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
        locale: 'pt_BR',
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
      ),
    );
  }
}
