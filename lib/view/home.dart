import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/components/myAppBar.dart';
import 'package:ufcat_app/view/components/search_bar.dart';
import 'package:ufcat_app/view/const.dart';
import 'package:ufcat_app/view/components/carousel.dart';
import 'package:ufcat_app/view/components/item_atalho.dart';
import 'package:ufcat_app/view/side_menu.dart';
import 'package:ufcat_app/view/components/card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.bars,
        title: 'assets/images/logo.png',
      ),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: grayUfcat,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 10.0,
                  ),
                  height: 174.0,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Carousel(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  height: 103.0,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const AtalhoIcon(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  // alignment: Alignment.center,
                  height: 245.0,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CardButton.buildCards(
                    'Últimas Notícias',
                    <CardButton>[
                      const CardButton(
                        imagePath:
                            'https://files.cercomp.ufg.br/weby/up/519/m/Homologa%C3%A7%C3%A3o_de_inscri%C3%A7%C3%B5es_UFCAT.png?1582891082',
                        title:
                            'Homologação final das inscrições para Eleição de Representantes nas instâncias deliberativas da UFCAT',
                      ),
                      const CardButton(
                        imagePath:
                            'https://files.cercomp.ufg.br/weby/up/519/m/Curso_de_Matem%C3%A1tica_colabora_na_prepara%C3%A7%C3%A3o_de_estudantes_para_o_SAEGO_-_capa.jpg?1666621238',
                        title:
                            'Curso de Matemática colabora na preparação de estudantes para o SAEGO',
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  height: 245.0,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CardButton.buildCards(
                    'Últimos Editais',
                    <CardButton>[
                      const CardButton(
                        imagePath:
                            'https://files.cercomp.ufg.br/weby/up/519/m/Edital_de_Monitoria_-_Curso_de_Medicina.jpg?1665769970',
                        title:
                            'Curso de Medicina divulga edital de processo seletivo de monitoria de Habilidades Clínicas',
                      ),
                      const CardButton(
                        imagePath:
                            'https://files.cercomp.ufg.br/weby/up/519/m/SiSU_2022_Not%C3%ADcia.jpg?1643918652',
                        title: 'SiSU 2022',
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  height: 245.0,
                  width: width, // Largura total da tela
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CardButton.buildCards(
                    'Últimos Eventos',
                    <CardButton>[
                      const CardButton(
                        imagePath:
                            'https://files.cercomp.ufg.br/weby/up/519/m/I_Semana_do_Livro_e_da_Biblioteca_da_UFCAT_-_capa.png?1666356848',
                        title: 'I Semana do Livro e da Biblioteca na UFCAT',
                      ),
                      const CardButton(
                        imagePath:
                            'https://files.cercomp.ufg.br/weby/up/519/m/Caf%C3%A9Filos%C3%B3ficoItinerante.jpg?1666096380',
                        title:
                            'Café Filosófico Itinerante: "As dobras da docência: ver o mundo, estar no mundo e ser mundo"',
                      ),
                    ],
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
