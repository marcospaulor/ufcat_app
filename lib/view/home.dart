import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/components/carousel.dart';
import 'package:ufcat_app/view/components/item_atalho.dart';
import 'package:ufcat_app/view/const.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // align logo to the center
        centerTitle: true,
        title: const Image(
          image: AssetImage('assets/images/logo_logo.png'),
          height: 50,
        ),
        // Menu button in the top left corner
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.bars),
          iconSize: width * 0.04,
          onPressed: () {
            // Open the drawer
            // Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            iconSize: width * 0.04,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: grayUfcat,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: 174.0,
                    width: width,
                    child: const Carousel(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 103.0,
                    width: width,
                    color: Colors.white,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
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
                        AtalhoIcon(
                          icon: FontAwesomeIcons.book,
                          text: 'Biblioteca',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 245.0,
                    width: width,
                    color: Colors.white,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [Text("Últimas Notícias")],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 245.0,
                    width: width,
                    color: Colors.white,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [Text("Últimas Editais")],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 245.0,
                    width: width, // Largura total da tela
                    color: Colors.white,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [Text("Últimas Eventos")],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
