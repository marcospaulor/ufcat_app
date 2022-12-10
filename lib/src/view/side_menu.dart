import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/webview.dart';
import 'package:ufcat_app/src/view/mapa_screen.dart';
import 'package:ufcat_app/src/view/style/const.dart';

import 'tab_screen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  static const MaterialColor textColor = grayUfcat;
  final MaterialColor iconColor = grayUfcat;

  @override
  Widget build(BuildContext context) {
    final List<Map> items = [
      {
        'title': 'Home',
        'icon': FontAwesomeIcons.house,
      },
      {
        'title': 'Notícias',
        'icon': FontAwesomeIcons.solidNewspaper,
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
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            margin: const EdgeInsets.all(25.0),
            height: 125,
            child: Image.asset('assets/images/logo_plana.png'),
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
                splashColor: redUfcat,
                highlightColor: redUfcat,
              ),
              child: Wrap(
                children: items
                    .map(
                      (item) => item['divider'] == null
                          ? ListTile(
                              leading: Icon(
                                item['icon'],
                                semanticLabel: item['title'],
                                // TODO: acessibilidade
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
                                      if (item['title'] == "Mapa") {
                                        return const MapScreen();
                                      }
                                      if (item['title'] == "Biblioteca") {
                                        return const WebViewPage(
                                          url:
                                              'https://biblioteca.sophia.com.br/terminal/9396/',
                                        );
                                      }

                                      return const TabScreen(index: 0);
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
