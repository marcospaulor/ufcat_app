import 'package:flutter/material.dart';
import 'package:ufcat_app/src/view/calendar_screen.dart';
import 'package:ufcat_app/src/view/home_screen.dart';
import 'package:ufcat_app/src/view/ru_screen.dart';
import 'package:ufcat_app/src/view/components/webview.dart';
import 'package:ufcat_app/src/view/security_screen.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/mapa_screen.dart';
import 'package:ufcat_app/src/view/tab_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AtalhoIcon extends StatefulWidget {
  const AtalhoIcon({
    Key? key,
  }) : super(key: key);

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
      'Segurança': FontAwesomeIcons.shieldHalved,
      'Calendário': FontAwesomeIcons.solidCalendarMinus,
    };

    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
<<<<<<< HEAD
=======
      physics: const NeverScrollableScrollPhysics(),
>>>>>>> main
      shrinkWrap: true,
      children: atalhos.entries
          .map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            switch (item.key) {
                              case 'Mapa':
                                return const MapScreen();
                              case 'RU':
                                return const RUScreen();
                              case 'Biblioteca':
                                return const WebViewPage(
                                  url:
                                      'https://biblioteca.sophia.com.br/terminal/9396/',
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
                              default:
                                return const HomeView();
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
                      padding: const EdgeInsets.all(30.0),
                    ),
                    child: Icon(item.value, size: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      item.key,
                      style: const TextStyle(
                        color: greenUfcat,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
