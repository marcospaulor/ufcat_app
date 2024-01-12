import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/features/rating/pages/rating_screen.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/star_rating.dart';
import 'package:ufcat_app/features/ru/widgets/container_ru.dart';
import 'package:ufcat_app/features/ru/widgets/sticky_button.dart';

class RUScreen extends StatefulWidget {
  const RUScreen({Key? key}) : super(key: key);

  @override
  State<RUScreen> createState() => _RUScreenState();
}

class _RUScreenState extends State<RUScreen> {
  final Map<String, dynamic> _cardapio = {
    'Segunda': {
      'almoco': {
        'Principal': 'Escondidinho de carne',
        'Prato Vegano': 'Escodidinho de proteína de soja',
        'Acompanhamento': 'Arroz Branco / Integral, Feijão Carioca',
        'Guarnicao': 'Legumes Sauté',
        'Salada': 'Chicória, Repolho c/ Cenoura e Passas,, beterraba palha',
        'Sobremesa': 'Laranja',
      },
      'jantar': {
        'Principal': 'Arroz, feijão, carne moida',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
    },
    'Terca': {
      'almoco': {
        'Principal': 'Arroz',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
      'jantar': {
        'Principal': 'Arroz, Feijão, Carne de Panela, Farofa, Salada',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
    },
    'Quarta': {
      'almoco': {
        'Principal': 'Arroz, Feijão, Carne de Panela, Farofa, Salada',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
      'jantar': {
        'Principal': 'Arroz, Feijão, Carne de Panela, Farofa, Salada',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
    },
    'Quinta': {
      'almoco': {
        'Principal': 'Arroz, Feijão, Carne de Panela, Farofa, Salada',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
      'jantar': {
        'Principal': 'Arroz, Feijão, Carne de Panela, Farofa, Salada',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
    },
    'Sexta': {
      'almoco': {
        'Principal': 'Arroz, Feijão, Carne de Panela, Farofa, Salada',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
      'jantar': {
        'Principal': 'Arroz, Feijão, Carne de Panela, Farofa, Salada',
        'Guarnicao': 'Batata Frita, Mandioca Frita',
        'Sobremesa': 'Pudim',
        'Suco': 'Abacaxi',
        'Salada': 'Alface, Tomate, Cenoura, Pepino',
      },
    },
  };
  String _day = 'Segunda';
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: drawerKey,
        appBar: const MyAppBar(
          icon: FontAwesomeIcons.arrowLeft,
          height: 2 * kToolbarHeight,
          title: 'R.U.',
          bottom: TabBar(
            labelColor: orangeUfcat,
            unselectedLabelColor: grayUfcat,
            indicatorColor: orangeUfcat,
            tabs: [
              Tab(
                text: 'ALMOÇO',
              ),
              Tab(
                text: 'JANTAR',
              ),
            ],
          ),
        ),
        endDrawer: const MyNavigationDrawer(),
        body: Stack(children: [
          TabBarView(
            children: [
              // Tab Almoço
              Container(
                color: grayUfcat,
                child: Column(
                  children: [
                    // Avaliação da refeição com estrelas e botão de enviar
                    Container(
                      height: width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Border on the bottom of the container
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13.0,
                                vertical: 1.0,
                              ),
                              child: StarRating(
                                padding: 6.0,
                                size: 20.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RatingScreen(
                                      dataRefeicao: _cardapio,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orangeUfcat,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 51.0,
                                  vertical: 10.0,
                                ),
                                child: Text('Avaliar'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: List<Widget>.from(
                          _cardapio[_day]['almoco'].entries.map(
                                (e) => ContainerRu(
                                  title: e.key,
                                  content: e.value,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Tab Jantar
              Container(
                color: grayUfcat,
                child: Column(
                  children: [
                    // Avaliação da refeição com estrelas e botão de enviar
                    Container(
                      height: width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Border on the bottom of the container
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13.0,
                                vertical: 1.0,
                              ),
                              child: StarRating(
                                padding: 6.0,
                                size: 20.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RatingScreen(
                                      dataRefeicao: _cardapio,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orangeUfcat,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 51.0,
                                  vertical: 10.0,
                                ),
                                child: Text('Avaliar'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: List<Widget>.from(
                          _cardapio[_day]['jantar'].entries.map(
                                (e) => ContainerRu(
                                  title: e.key,
                                  content: e.value,
                                ),
                              ),
                        ),
                        // listar todos title e content in almoco
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: height * (1 / 3) - kToolbarHeight - kTextTabBarHeight,
            child: SizedBox(
              height: height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _cardapio.entries
                    .map(
                      (e) => StickyButton(
                        label: e.key[0],
                        size: _day == e.key ? 0.2 : 0.1,
                        color: _day == e.key ? orangeUfcat : greenUfcat,
                        onPressed: () => setState(() => _day = e.key),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ]),
        bottomNavigationBar: BottomBar(drawerKey: drawerKey),
      ),
    );
  }
}
