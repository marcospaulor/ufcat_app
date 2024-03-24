import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/features/about/pages/about.dart';
import 'package:ufcat_app/shared/app_bar.dart';

class PopupMenu extends StatefulWidget {
  const PopupMenu({Key? key}) : super(key: key);

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  List<String> menuItems = [
    'Sobre',
    'Ajuda',
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(FontAwesomeIcons.ellipsisVertical),
        onSelected: (String value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                switch (value) {
                  case 'Sobre':
                    return const About();
                  default:
                    return const Scaffold(
                      appBar: MyAppBar(
                        title: 'Ajuda',
                        icon: FontAwesomeIcons.arrowLeft,
                      ),
                      body: Center(
                        child: Text(
                          'Em breve...',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    );
                }
              },
            ),
          );
        },
        itemBuilder: (context) {
          return menuItems.map((String item) {
            return PopupMenuItem(
              value: item,
              child: Text(item, style: Theme.of(context).textTheme.labelLarge),
            );
          }).toList();
        });
  }
}
