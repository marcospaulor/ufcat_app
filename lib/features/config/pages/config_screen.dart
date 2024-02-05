import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  List<String> menuItems = [
    'Configurações',
    'Sobre',
    'Ajuda',
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(
          title: 'Configurações',
          icon: FontAwesomeIcons.arrowLeft,
        ),
        body: Center(child: Text('Em breve...')));
  }
}
