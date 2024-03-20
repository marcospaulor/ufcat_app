import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/providers/api_key.dart';
import 'package:http/http.dart' as http;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  Map<DateTime, List<dynamic>> _events = {
    DateTime.utc(2024, 1, 1): [
      'New Year\'s Day',
    ],
  };
  late final ValueNotifier<List<dynamic>> _selectedEvents;

  final BoxDecoration _defaultDecoration = const BoxDecoration(
    color: Colors.transparent,
    shape: BoxShape.circle,
  );

  final String _apiKey = calendarApiKey;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_events[_selectedDay] ?? []);
    _getCalendarData(_selectedDay).then((events) {
      setState(() {
        _events = events;
        _selectedEvents.value = _events[_selectedDay] ?? [];
      });
    });
  }

  Future<Map<DateTime, List<dynamic>>> _getCalendarData(DateTime day) async {
    var year = day.year;

    final response = await http.get(
      Uri.parse(
          'https://api.invertexto.com/v1/holidays/$year?token=$_apiKey&state=go'),
    );
    final Map<DateTime, List<dynamic>> eventsMap = {};
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      for (var event in data) {
        final eventDate = DateTime.parse(event['date'] + 'T' + '00:00:00.000Z');
        eventsMap.putIfAbsent(eventDate, () => [event['name']]);
      }
    }

    return eventsMap;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      final events = await _getCalendarData(selectedDay);
      setState(() {
        _events = events;
        _selectedEvents.value = _events[selectedDay] ?? [];
      });
    }
  }

  Widget _buildCalendar() {
    return TableCalendar(
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
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      eventLoader: (day) {
        if (_events.containsKey(day)) {
          return _events[day]!;
        }
        return [];
      },
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ValueListenableBuilder<List<dynamic>>(
        valueListenable: _selectedEvents,
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final eventDate = DateFormat('dd/MM/yyyy').format(_selectedDay);
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
                    '$eventDate - ${value[index]}',
                    style: const TextStyle(
                      color: darkUfcat,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Calendário',
      ),
      endDrawer: const MyNavigationDrawer(),
      body: Column(
        children: [
          _buildCalendar(),
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
          _buildEventList(),
        ],
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
