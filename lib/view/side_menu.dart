import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/const.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  static const MaterialColor textColor = grayUfcat;
  final MaterialColor iconColor = darkUfcat;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: greenUfcat,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              margin: const EdgeInsets.only(bottom: 10),
              height: 200,
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
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.house),
                    iconColor: iconColor,
                    title: const Text(
                      'Home',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.solidNewspaper),
                    iconColor: iconColor,
                    title: const Text(
                      'Notícias',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.solidFileLines),
                    iconColor: iconColor,
                    title: const Text(
                      'Editais',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.utensils),
                    iconColor: iconColor,
                    title: const Text(
                      'RU',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.locationDot),
                    iconColor: iconColor,
                    title: const Text(
                      'Mapa',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.book),
                    iconColor: iconColor,
                    title: const Text(
                      'Biblioteca',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.solidCalendarMinus),
                    iconColor: iconColor,
                    title: const Text(
                      'Calendário',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.screwdriverWrench),
                    iconColor: iconColor,
                    title: const Text(
                      'Ordem de Serviço',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.shieldHalved),
                    iconColor: iconColor,
                    title: const Text(
                      'Segurança',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(
                    indent: 15,
                    endIndent: 15,
                    thickness: 2,
                    color: textColor,
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.circleInfo),
                    iconColor: iconColor,
                    title: const Text(
                      'Sobre',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.solidCircleQuestion),
                    iconColor: iconColor,
                    title: const Text(
                      'Ajuda',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
