import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/const.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   child: Image.asset('assets/images/logo_plana.png'),
          // ),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            margin: const EdgeInsets.only(bottom: 10),
            color: greenUfcat,
            height: 200,
            child: Image.asset('assets/images/logo_plana.png'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              indent: 15,
              endIndent: 15,
              thickness: 2,
              color: darkUfcat,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(FontAwesomeIcons.house),
                  iconColor: darkUfcat,
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.solidNewspaper),
                  iconColor: darkUfcat,
                  title: const Text('Notícias'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.solidFileLines),
                  iconColor: darkUfcat,
                  title: const Text('Editais'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.utensils),
                  iconColor: darkUfcat,
                  title: const Text('RU'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.locationDot),
                  iconColor: darkUfcat,
                  title: const Text('Mapa'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.book),
                  iconColor: darkUfcat,
                  title: const Text('Biblioteca'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.solidCalendarMinus),
                  iconColor: darkUfcat,
                  title: const Text('Calendário'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.screwdriverWrench),
                  iconColor: darkUfcat,
                  title: const Text('Ordem de Serviço'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.shieldHalved),
                  iconColor: darkUfcat,
                  title: const Text('Segurança'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 2,
                  color: darkUfcat,
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.circleInfo),
                  iconColor: darkUfcat,
                  title: const Text('Sobre'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.solidCircleQuestion),
                  iconColor: darkUfcat,
                  title: const Text('Ajuda'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
