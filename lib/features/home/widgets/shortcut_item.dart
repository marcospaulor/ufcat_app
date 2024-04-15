import 'package:flutter/material.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/features/calendar/pages/calendar_screen.dart';
import 'package:ufcat_app/features/about/pages/about.dart';
import 'package:ufcat_app/features/help/pages/help.dart';
import 'package:ufcat_app/features/ru/pages/ru_screen.dart';
import 'package:ufcat_app/features/library/pages/library_screen.dart';
import 'package:ufcat_app/features/security/pages/security_screen.dart';
import 'package:ufcat_app/features/map/pages/mapa_screen.dart';
import 'package:ufcat_app/features/tabs/pages/tab_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AtalhoIcon extends StatefulWidget {
  const AtalhoIcon({
    super.key,
  });

  @override
  State<AtalhoIcon> createState() => _AtalhoIconState();
}

class _AtalhoIconState extends State<AtalhoIcon> {
  @override
  Widget build(BuildContext context) {
    Map<String, IconData> atalhos = {
      'Notícias': FontAwesomeIcons.solidNewspaper,
      'Eventos': FontAwesomeIcons.solidCalendarCheck,
      'Editais': FontAwesomeIcons.solidFileLines,
      'RU': FontAwesomeIcons.utensils,
      'Mapa': FontAwesomeIcons.locationDot,
      'Biblioteca': FontAwesomeIcons.book,
      'Calendário': FontAwesomeIcons.solidCalendarMinus,
      'OS': FontAwesomeIcons.screwdriverWrench,
      'Segurança': FontAwesomeIcons.shieldHalved,
    };
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double iconSize = (width * (1 / 75)) * (height * (1 / 75));

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 25,
          crossAxisSpacing: 25,
        ),
        itemCount: atalhos.length,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    switch (atalhos.keys.toList()[index]) {
                      case 'Mapa':
                        return const MapScreen();
                      case 'RU':
                        return const RUScreen();
                      case 'Biblioteca':
                        return const LibraryScreen(
                          url:
                              'https://biblioteca.sophia.com.br/terminal/9396/',
                          title: 'Biblioteca',
                        );
                      case 'Calendário':
                        return const CalendarScreen();
                      case 'Segurança':
                        return const SecurityScreen();
                      case 'Notícias':
                        return const TabScreen(index: 0);
                      case 'Eventos':
                        return const TabScreen(index: 1);
                      case 'Editais':
                        return const TabScreen(index: 2);
                      case 'Sobre':
                        return const About();
                      case 'Help':
                        return const Help();
                      default:
                        return const Scaffold(
                          appBar: MyAppBar(
                              title: 'Em breve...',
                              icon: FontAwesomeIcons.arrowLeft),
                          body: Center(
                            child: Text(
                              'Em breve...',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          ),
                        );
                    }
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              visualDensity: VisualDensity.compact,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(atalhos.values.toList()[index], size: iconSize),
                  SizedBox(height: height * (1 / 75) * 2),
                  Text(
                    atalhos.keys.toList()[index],
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 14, // Defina um tamanho de fonte fixo aqui
                        ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
