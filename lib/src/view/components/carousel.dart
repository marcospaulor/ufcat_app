import 'package:carousel_slider/carousel_slider.dart';
import 'package:ufcat_app/src/view/news_screen.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/style/fonts_style.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List imgList = [
    "https://files.cercomp.ufg.br/weby/up/519/o/BANNER_1000x230px_%281%29.jpg?1661861040",
    "https://files.cercomp.ufg.br/weby/up/519/o/AAEI_%282%29.pdf_%281200_%C3%97_230_px%29.png?1659632704",
    "https://files.cercomp.ufg.br/weby/up/519/o/monitoria_hab_clinicas.jpg?1666187039",
    "https://files.cercomp.ufg.br/weby/up/519/o/Vamos_conversar_sobre_a_Pol%C3%ADtica_de_A%C3%A7%C3%B5es_Afirmativas_-_atualizado.png?1666268795",
  ];
  List titleList = [
    "Equipe Gestora da MUC cria e divulga \"Guia Prático de Convivência\"",
    "Reitora da UFCAT participa de reunião com presidente Lula e reitores",
    "Diretoria de Cultura/PROEC promove Mapeamento Artístico Cultural na UFCAT",
    "UFCAT monitora denúncias de participação de membros da comunidade universitária nos atos",
    "Protocolo de Biossegurança, Espaço Físico, Protocolos Sanitários e Monitoramento da COVID-19 na..."
  ];
  var current = 0;
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      children: [
        Image.network(
          'https://files.cercomp.ufg.br/weby/up/519/o/UFCAT_aerea.png',
          height: height * (1 / 3),
          width: width,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.50),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/logo_completa.png',
            height: height * (1 / 8),
            cacheHeight: 300,
            fit: BoxFit.contain,
          ),
        ),
        CarouselSlider(
          items: titleList
              .map(
                (item) => Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 25.0,
                  ),
                  child: UnconstrainedBox(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewsScreen(
                              label: "Notícia",
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
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        maximumSize: Size.fromWidth(width * 0.85),
                      ),
                      child: Text(item,
                          softWrap: false,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headlineLarge!.apply(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  )

                          // const TextStyle(
                          //   fontSize: 20,
                          //   color: Colors.white,
                          //   backgroundColor: Colors.transparent,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                          ),
                    ),
                  ),
                ),
              )
              .toList(),
          carouselController: controller,
          options: CarouselOptions(
              height: height,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1.0,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleList.map((url) {
            int index = titleList.indexOf(url);
            return Container(
              width: 10.0,
              height: 10.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == index
                    ? orangeUfcat.withOpacity(0.9)
                    : grayUfcat.withOpacity(0.9),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    current == index ? orangeUfcat : grayUfcat,
                    current == index
                        ? orangeUfcat.shade600
                        : grayUfcat.shade600,
                    current == index
                        ? orangeUfcat.shade700
                        : grayUfcat.shade700,
                    current == index
                        ? orangeUfcat.shade800
                        : grayUfcat.shade800,
                    current == index
                        ? orangeUfcat.shade900
                        : grayUfcat.shade900,
                    Colors.black,
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
