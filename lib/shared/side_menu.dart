import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/features/calendar/pages/calendar_screen.dart';
import 'package:ufcat_app/features/about/pages/about.dart';
import 'package:ufcat_app/features/help/pages/help.dart';
import 'package:ufcat_app/features/library/pages/library_screen.dart';
import 'package:ufcat_app/features/home/pages/home_screen.dart';
import 'package:ufcat_app/features/map/pages/mapa_screen.dart';
import 'package:ufcat_app/features/os/pages/os_screen.dart';
import 'package:ufcat_app/features/ru/pages/ru_screen.dart';
import 'package:ufcat_app/features/security/pages/security_screen.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

import '../features/tabs/pages/tab_screen.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({super.key});

  static const MaterialColor textColor = grayUfcat;
  final MaterialColor iconColor = grayUfcat;

  @override
  Widget build(BuildContext context) {
    final List<Map> items = [
      {
        'title': 'Notícias',
        'icon': FontAwesomeIcons.solidNewspaper,
      },
      {
        'title': 'Eventos',
        'icon': FontAwesomeIcons.solidCalendarCheck,
      },
      {
        'title': 'Editais',
        'icon': FontAwesomeIcons.solidFileLines,
      },
      {
        'title': 'RU',
        'icon': FontAwesomeIcons.utensils,
      },
      {
        'title': 'Mapa',
        'icon': FontAwesomeIcons.locationDot,
      },
      {
        'title': 'Biblioteca',
        'icon': FontAwesomeIcons.book,
      },
      {
        'title': 'Calendário',
        'icon': FontAwesomeIcons.solidCalendarMinus,
      },
      {
        'title': 'Ordem de Serviço',
        'icon': FontAwesomeIcons.screwdriverWrench,
      },
      {
        'title': 'Segurança',
        'icon': FontAwesomeIcons.shieldHalved,
      },
      {
        'divider': true,
      },
      {
        'title': 'Sobre',
        'icon': FontAwesomeIcons.circleInfo,
      },
      {
        'title': 'Ajuda',
        'icon': FontAwesomeIcons.solidCircleQuestion,
      },
    ];

    return Drawer(
      backgroundColor: greenUfcat,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            margin: const EdgeInsets.all(25.0),
            height: 125,
            child: Image.asset(
              'assets/images/logo_plana.png',
              cacheHeight: 195,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              indent: 15,
              endIndent: 15,
              thickness: 2,
              color: textColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: orangeUfcat,
                highlightColor: orangeUfcat,
              ),
              child: Wrap(
                children: items
                    .map(
                      (item) => item['divider'] == null
                          ? ListTile(
                              leading: Icon(
                                item['icon'],
                                semanticLabel: item['title'],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              iconColor: iconColor.withOpacity(0.75),
                              title: Text(
                                item['title'],
                                style: const TextStyle(
                                  color: textColor,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      switch (item['title']) {
                                        case 'Mapa':
                                          return const MapScreen();
                                        case 'RU':
                                          return const RUScreen();
                                        case 'Biblioteca':
                                          return const LibraryScreen(
                                            url:
                                                'https://biblioteca.sophia.com.br/terminal/9396/',
                                            title: "Biblioteca",
                                          );
                                        case 'Calendário':
                                          return const CalendarScreen();
                                        case 'Segurança':
                                          return const SecurityScreen();
                                        case 'Ordem de Serviço':
                                          return const OSScreen();
                                        case 'Notícias':
                                          return const TabScreen(index: 0);
                                        case 'Eventos':
                                          return const TabScreen(index: 1);
                                        case 'Editais':
                                          return const TabScreen(index: 2);
                                        case 'Sobre':
                                          return const About();
                                        case 'Ajuda':
                                          return const Help();
                                        default:
                                          return const HomeView();
                                      }
                                    },
                                  ),
                                );
                              },
                            )
                          : const Divider(
                              indent: 15,
                              endIndent: 15,
                              thickness: 2,
                              color: textColor,
                            ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
