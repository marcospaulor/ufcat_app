import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          image: AssetImage('assets/logo.png'),
          height: 50,
        ),
        // Menu button in the top left corner
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.bars),
          onPressed: () {
            // Open the drawer
            // Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
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
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    height: 174.0,
                    width: width,
                    child: CarouselSlider(
                      items: <Widget>[
                        SizedBox(
                          width: 600,
                          height: 400,
                          child: Image.network(
                              "https://files.cercomp.ufg.br/weby/up/519/o/AAEI_%282%29.pdf_%281200_%C3%97_230_px%29.png?1659632704"),
                        ),
                        SizedBox(
                          width: 600,
                          height: 400,
                          child: Image.network(
                              "https://files.cercomp.ufg.br/weby/up/519/o/monitoria_hab_clinicas.jpg?1666187039"),
                        ),
                        SizedBox(
                          width: 600,
                          height: 400,
                          child: Image.network(
                              "https://files.cercomp.ufg.br/weby/up/519/o/Vamos_conversar_sobre_a_Pol%C3%ADtica_de_A%C3%A7%C3%B5es_Afirmativas_-_atualizado.png?1666268795"),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 400.0,
                        enableInfiniteScroll: true,
                        initialPage: 0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    height: 103.0,
                    width: width,
                    color: Colors.white,
                    child: Text("Atalhos"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    height: 245.0,
                    width: width,
                    color: Colors.white,
                    child: Text("Últimas Notícias"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    height: 245.0,
                    width: width,
                    color: Colors.white,
                    child: Text("Últimas Editais"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    height: 245.0,
                    width: width, // Largura total da tela
                    color: Colors.white,
                    child: Text("Últimas Notícias"),
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
