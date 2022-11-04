import 'package:flutter/material.dart';
import 'package:ufcat_app/view/components/webview.dart';
import 'package:ufcat_app/view/const.dart';
import 'package:ufcat_app/view/tabScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AtalhoIcon extends StatelessWidget {
  const AtalhoIcon({
    Key? key,
  }) : super(key: key);

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
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      children: atalhos.entries
          .map(
            (e) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).padding.top,
                horizontal: 5.0,
              ),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => e.key != 'Biblioteca'
                                ? const TabScreen()
                                : const WebViewPage(
                                    url:
                                        'https://biblioteca.sophia.com.br/terminal/9396'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15.0),
                      ),
                      child: Icon(e.value, size: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        e.key,
                        style: const TextStyle(color: greenUfcat),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),

      // Padding(
      //   padding: EdgeInsets.symmetric(
      //     vertical: MediaQuery.of(context).padding.top,
      //     horizontal: 5.0,
      //   ),
      //   child: SizedBox(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children:
      // <Widget>[
      //   ElevatedButton(
      //     onPressed: () {
      //       // Navigator.pushNamed(context, '/news');
      //     },
      //     style: ElevatedButton.styleFrom(
      //       elevation: 5,
      //       shape: const CircleBorder(),
      //       padding: const EdgeInsets.all(15.0),
      //     ),
      //     child: Icon(icon, size: 30),
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.only(top: 5),
      //     child: Text(
      //       text,
      //       style: const TextStyle(color: greenUfcat),
      //     ),
      //   ),
      // ],
      //     ),
      //   ),
      // ),
    );
  }
}
