import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/newsScreen.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/components/appBar.dart';

class TabScreen extends StatelessWidget {
  final int index;

  const TabScreen({
    Key? key,
    required this.index,
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
      initialIndex: index,
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
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                elevation: 5.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewsScreen(
                          label: "Noticia",
                          title:
                              "Nota sobre bloqueio, corte e repasses financeiros à UFCAT e Convocação de Assembleia Universitária",
                          data: "06/12/22",
                          img:
                              "https://files.cercomp.ufg.br/weby/up/519/m/assembleia.jpeg?1670358362",
                          text:
                              "A Reitoria da Universidade Federal de Catalão (UFCAT), com informações da Pró-Reitoria de Administração e Finanças (PROAF), vem contextualizar os fatos relacionados aos bloqueios orçamentários ocorridos na semana passada. Na última quinta-feira, 1º/12/2022, o governo federal efetivou bloqueio orçamentário no Ministério da Educação (MEC), significando o corte de mais de R\$ 2 milhões do orçamento da Universidade. Além dos R1,2 milhões que já estavam bloqueados desde do mês de junho. Com este último bloqueio as despesas que já haviam sido empenhadas também foram impactadas, deixando as contas da UFCAT no negativo. Agora, lamentavelmente, a UFCAT não poderá executar despesas restantes, nem contratar processos licitatórios e editais, concluídos ou em andamento, após meses de planejamento e execução, nem mesmo proceder com qualquer despesa emergencial. Se não bastassem os prejuízos desta medida, o governo editou, no dia 30/11/2022, o Decreto nº 11.269, que alterou os anexos do Decreto nº 10.961, de 11/02/2022 – Decreto de Programação Orçamentária e Financeira (DPOF), que dispõe sobre a programação orçamentária e financeira e estabelece o cronograma de execução mensal de desembolso do Poder Executivo Federal para 2022. Dentre outras providências, o novo decreto zerou o limite de pagamentos das despesas discricionárias (anexo II do DPOF) do MEC previsto para o mês de dezembro. As implicações do instrumento legal estão reiteradas na Mensagem SIAFI 2022/3095354, enviada pela Setorial Financeira do MEC, na noite de 1º/12/2022, elucidando que a impossibilidade de repasse financeiro se estende a toda a Administração Pública Federal. Com a medida, as universidades e institutos federais não receberão repasses financeiros para seus compromissos básicos que apontam para a indissociabilidade entre o ensino, pesquisa, extensão e assistência estudantil. Rotineiramente, no primeiro dia útil de cada mês, a UFCAT recebe recursos financeiros para pagamento das despesas liquidadas no mês anterior. Entretanto, até o presente momento, a Universidade não recebeu nada. Cabe destacar que a situação da UFCAT em relação aos contratos com os terceirizados é de adimplência. A partir do mês de dezembro poderá haver impacto no pagamento das empresas. A UFCAT tem R\$ 2.566.171,72 liquidados em novembro, ou seja, este é o valor até então apto para pagamento imediato de atividades já realizadas, que aguarda recursos financeiros que não foram disponibilizados e que, segundo o novo Decreto, não serão disponibilizados no mês de dezembro. A UFCAT, em seus quase 5 anos de existência, sempre primou pelo planejamento e manutenção de seus compromissos. Infelizmente, diante deste cenário, corremos o risco de, pela primeira vez, passar para 2023 com uma dívida referente aos meses de novembro e dezembro. \n Os processos licitatórios, em andamento, terão o prosseguimento e sua conclusão, mas sem a emissão de empenhos. Contudo, vale ressaltar que, caso não haja o desbloqueio, os mesmos poderão ser aproveitados em 2023, com anuência do fornecedor, mas com recursos e impactos prováveis no próximo ano. A reitoria acompanha de perto a situação com o grau de seriedade que o assunto exige, mantendo a comunidade interna e externa a par do assunto. Informamos ainda que, nos próximos dias, a Reitora, professora Roselma Lucchese, em conjunto com os demais reitores(as) que compõem a ANDIFES, estarão em Brasília/DF na tentativa de reverter os bloqueios orçamentários junto ao MEC. Enfatizamos que não há nada que as universidades possam fazer isoladamente, já que o corte, o bloqueio orçamentário e o cancelamento de repasses financeiros constituem medidas unilaterais adotadas pelo governo federal, ainda que um pacote de esforços tenha sido feito ao longo de 2022 para que pudéssemos concluí-lo como programado. Diante do exposto, convocamos toda comunidade acadêmica para a Assembleia Geral Universitária, que será realizada no dia 12/12/2022 (segunda-feira) das 19:00h às 21:00h, no auditório Prof.ª Lívia Abrahão do Nascimento (Bloco Didático II).",
                        ),
                      ),
                    );
                  },
                  splashColor: Colors.black.withOpacity(0.25),
                  highlightColor: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:
                            MediaQuery.of(context).size.height * 0.25 * 0.65,
                        child: Ink.image(
                          image: NetworkImage(item['imagePath']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height:
                            MediaQuery.of(context).size.height * 0.25 * 0.35,
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
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
