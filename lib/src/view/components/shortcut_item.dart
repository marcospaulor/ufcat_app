import 'package:flutter/material.dart';
import 'package:ufcat_app/src/view/calendar_screen.dart';
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
      'Editais': FontAwesomeIcons.solidFileLines,
      'RU': FontAwesomeIcons.utensils,
      'Mapa': FontAwesomeIcons.locationDot,
      'Biblioteca': FontAwesomeIcons.book,
      'Segurança': FontAwesomeIcons.shieldHalved,
      'Calendário': FontAwesomeIcons.solidCalendarMinus,
    };

    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      shrinkWrap: true,
      children: atalhos.entries
          .map(
            (e) => Container(
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
                            if (e.key == "Mapa") return const MapScreen();
                            if (e.key == "RU") return const RUScreen();
                            if (e.key == "Biblioteca") {
                              return const WebViewPage(
                                url:
                                    'https://biblioteca.sophia.com.br/terminal/9396/',
                              );
                            }
                            if (e.key == "Calendário") {
                              return const CalendarScreen();
                            }
                            if (e.key == "Segurança") {
                              return const SecurityScreen();
                            }

                            return const TabScreen(index: 0);
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30.0),
                    ),
                    child: Icon(e.value, size: 60),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      e.key,
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
