import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/const.dart';
import 'package:ufcat_app/view/tabScreen.dart';
import 'package:page_transition/page_transition.dart';

class CardButton extends StatelessWidget {
  final String label;

  const CardButton({
    Key? key,
    required this.label,
  }) : super(key: key);

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
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: Container(
            height: 25,
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label == 'noticias'
                      ? 'Últimas Notícias'
                      : label == 'eventos'
                          ? 'Últimos Eventos'
                          : 'Últimos Editais',
                  style: const TextStyle(
                    color: darkUfcat,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: TabScreen(
                            index: label == 'noticias'
                                ? 0
                                : label == 'eventos'
                                    ? 1
                                    : 2),
                      ),
                    );
                  },
                  child: const Icon(
                    FontAwesomeIcons.angleRight,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            children: [
              ...info[label]!
                  .map(
                    (item) => UnconstrainedBox(
                      child: SizedBox(
                        width: 318,
                        height: 206,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.all(10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {},
                            splashColor: Colors.black.withOpacity(0.25),
                            highlightColor: Colors.transparent,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 108,
                                  child: Ink.image(
                                    image: NetworkImage(item['imagePath']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  alignment: Alignment.center,
                                  height: 78,
                                  child: Text(
                                    item['title'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: darkUfcat,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: TabScreen(
                          index: label == 'noticias'
                              ? 0
                              : label == 'eventos'
                                  ? 1
                                  : 2),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Ver mais',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: darkUfcat,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.5),
                        child: Icon(
                          FontAwesomeIcons.angleRight,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
