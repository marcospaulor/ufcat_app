import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/components/item_atalho.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: const <Widget>[
                      AtalhoIcon(
                        icon: FontAwesomeIcons.solidNewspaper,
                        text: 'Notícias',
                      ),
                      AtalhoIcon(
                        icon: FontAwesomeIcons.solidFileLines,
                        text: 'Editais',
                      ),
                      AtalhoIcon(
                        icon: FontAwesomeIcons.utensils,
                        text: 'RU',
                      ),
                      AtalhoIcon(
                        icon: FontAwesomeIcons.locationDot,
                        text: 'Mapa',
                      ),
                      AtalhoIcon(
                        icon: FontAwesomeIcons.book,
                        text: 'Biblioteca',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
