import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/const.dart';
import 'package:ufcat_app/view/components/myAppBar.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List> info = {
      'noticias': [
        {
          'imagePath':
              'https://files.cercomp.ufg.br/weby/up/519/m/Homologa%C3%A7%C3%A3o_de_inscri%C3%A7%C3%B5es_UFCAT.png',
          'title':
              'Homologação final das inscrições para Eleição de Representantes nas instâncias deliberativas da UFCAT'
        },
        {
          'imagePath':
              'https://files.cercomp.ufg.br/weby/up/519/m/Curso_de_Matem%C3%A1tica_colabora_na_prepara%C3%A7%C3%A3o_de_estudantes_para_o_SAEGO_-_capa.jpg',
          'title':
              'Curso de Matemática colabora na preparação de estudantes para o SAEGO'
        },
      ],
      'eventos': [
        {
          'imagePath':
              'https://files.cercomp.ufg.br/weby/up/519/m/I_Semana_do_Livro_e_da_Biblioteca_da_UFCAT_-_capa.png',
          'title': 'I Semana do Livro e da Biblioteca na UFCAT'
        },
        {
          'imagePath':
              'https://files.cercomp.ufg.br/weby/up/519/m/Caf%C3%A9Filos%C3%B3ficoItinerante.jpg',
          'title':
              'Café Filosófico Itinerante: "As dobras da docência: ver o mundo, estar no mundo e ser mundo"'
        },
      ],
      'editais': [
        {
          'imagePath':
              'https://files.cercomp.ufg.br/weby/up/519/m/Edital_de_Monitoria_-_Curso_de_Medicina.jpg',
          'title':
              'Curso de Medicina divulga edital de processo seletivo de monitoria de Habilidades Clínicas'
        },
        {
          'imagePath':
              'https://files.cercomp.ufg.br/weby/up/519/m/SiSU_2022_Not%C3%ADcia.jpg',
          'title': 'SiSU 2022'
        },
      ],
    };

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const MyAppBar(
          icon: FontAwesomeIcons.arrowLeft,
          title: 'assets/images/logo.png',
          height: 2 * kToolbarHeight,
          bottom: TabBar(
            labelColor: orangeUfcat,
            unselectedLabelColor: grayUfcat,
            indicatorColor: orangeUfcat,
            tabs: [
              Tab(
                icon: Text('NOTÍCIAS'),
              ),
              Tab(
                icon: Text('EVENTOS'),
              ),
              Tab(
                icon: Text('EDITAIS'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildLista(
              lista: info['noticias']!,
              context: context,
            ),
            buildLista(
              lista: info['eventos']!,
              context: context,
            ),
            buildLista(
              lista: info['editais']!,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  ListView buildLista({required List lista, required BuildContext context}) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      children: lista
          .map(
            (item) => Container(
              height: MediaQuery.of(context).size.height * 0.25,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                ),
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      return Wrap(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height *
                                0.25 *
                                0.65,
                            child: Image.network(
                              item['imagePath'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height *
                                0.25 *
                                0.35,
                            child: Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          )
          .toList(),
    );
  }
}
