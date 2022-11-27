import 'package:flutter/material.dart';
import 'package:ufcat_app/src/view/style/const.dart';

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

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 20.0,
          ),
          child: Text(
            label == 'noticias'
                ? 'Últimas Notícias'
                : label == 'eventos'
                    ? 'Últimos Eventos'
                    : 'Últimos Editais',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 20.0,
          ),
          children: info[label]!
              .map(
                (item) => Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 5,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: SizedBox(
                      width: 318,
                      height: 186,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 108,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                item['imagePath'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
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
              )
              .toList(),
        ),
      ],
    );
  }
}
