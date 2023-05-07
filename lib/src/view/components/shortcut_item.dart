import 'package:flutter/material.dart';
import 'package:ufcat_app/src/view/screens/calendar_screen.dart';
import 'package:ufcat_app/src/view/screens/about.dart';
import 'package:ufcat_app/src/view/screens/home_screen.dart';
import 'package:ufcat_app/src/view/screens/ru_screen.dart';
import 'package:ufcat_app/src/view/components/webview.dart';
import 'package:ufcat_app/src/view/screens/security_screen.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/screens/mapa_screen.dart';
import 'package:ufcat_app/src/view/screens/tab_screen.dart';
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
      'Calendário': FontAwesomeIcons.solidCalendarMinus,
      'OS': FontAwesomeIcons.screwdriverWrench,
      'Segurança': FontAwesomeIcons.shieldHalved,
      'Sobre': FontAwesomeIcons.circleInfo,
      'Ajuda': FontAwesomeIcons.solidCircleQuestion,
    };
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double iconSize = (width * (1 / 60)) * (height * (1 / 60));

    return GridView.count(
      crossAxisCount: 2,

      physics: const NeverScrollableScrollPhysics(),
      // childAspectRatio: width / (height / (1 / (iconSize / 100) + 1.25)),
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      shrinkWrap: true,
      children: atalhos.entries
          .map(
            (item) => Container(
              // height: 2000,
              // padding: const EdgeInsets.symmetric(
              //   horizontal: 10.0,
              // ),
              alignment: Alignment.center,
              child: ElevatedButton(
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
                          case 'Sobre':
                            return const About();
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
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: width * 0.09,
                  //   vertical: height * 0.03,
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.value, size: iconSize),
                      SizedBox(height: height * 0.01),
                      Text(
                        item.key,
                        // maxLines: 1,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        // style: const TextStyle(
                        //   color: Colors.white,
                        //   fontSize: 20,
                        // ),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
