import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ufcat_app/view/const.dart';
import 'package:ufcat_app/view/components/item_atalho.dart';
import 'package:ufcat_app/view/side_menu.dart';

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
          image: AssetImage('assets/images/logo.png'),
          height: 50,
        ),
        // Menu button in the top left corner
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(FontAwesomeIcons.bars),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: grayUfcat,
            child: Column(
              children: [
                Container(
                  height: 174.0,
                  width: width,
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 7.5,
                  ),
                  child: CarouselSlider(
                    items: <Widget>[
                      SizedBox(
                        width: 600,
                        height: 400,
                        child: Image.network(
                          "https://files.cercomp.ufg.br/weby/up/519/o/AAEI_%282%29.pdf_%281200_%C3%97_230_px%29.png?1659632704",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        height: 400,
                        child: Image.network(
                          "https://files.cercomp.ufg.br/weby/up/519/o/monitoria_hab_clinicas.jpg?1666187039",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 600,
                        height: 400,
                        child: Image.network(
                            "https://files.cercomp.ufg.br/weby/up/519/o/Vamos_conversar_sobre_a_Pol%C3%ADtica_de_A%C3%A7%C3%B5es_Afirmativas_-_atualizado.png?1666268795",
                            fit: BoxFit.fill),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 400.0,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: Container(
                    height: 105.0,
                    width: width,
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: AtalhoIcon(
                            icon: FontAwesomeIcons.solidNewspaper,
                            text: 'Notícias',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: AtalhoIcon(
                            icon: FontAwesomeIcons.solidFileLines,
                            text: 'Editais',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: AtalhoIcon(
                            icon: FontAwesomeIcons.utensils,
                            text: 'RU',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: AtalhoIcon(
                            icon: FontAwesomeIcons.locationDot,
                            text: 'Mapa',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: AtalhoIcon(
                            icon: FontAwesomeIcons.book,
                            text: 'Biblioteca',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: Container(
                    height: 245.0,
                    width: width,
                    color: Colors.white,
                    child: const Text("Últimas Notícias"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: Container(
                    height: 245.0,
                    width: width,
                    color: Colors.white,
                    child: const Text("Últimas Editais"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: Container(
                    height: 245.0,
                    width: width, // Largura total da tela
                    color: Colors.white,
                    child: const Text("Últimas Notícias"),
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
