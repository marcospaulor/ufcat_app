import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List imgList = [
    "https://files.cercomp.ufg.br/weby/up/519/o/AAEI_%282%29.pdf_%281200_%C3%97_230_px%29.png?1659632704",
    "https://files.cercomp.ufg.br/weby/up/519/o/monitoria_hab_clinicas.jpg?1666187039",
    "https://files.cercomp.ufg.br/weby/up/519/o/Vamos_conversar_sobre_a_Pol%C3%ADtica_de_A%C3%A7%C3%B5es_Afirmativas_-_atualizado.png?1666268795",
  ];
  var current = 0;
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      items: imgList
          .map((url) => Center(
                  child: Image.network(
                url,
                fit: BoxFit.cover,
                height: height,
              )))
          .toList(),
      // items: imgList.map((url) {
      //   return Container(
      //     margin: EdgeInsets.zero,
      //     child: Image.network(
      //       url,
      //       fit: BoxFit.cover,
      //       width: 1000,
      //     ),
      //   );
      // }).toList(),
      // <Widget>[
      //   // Mostrando imagens de forma dinâmica
      //   for (var i = 0; i < imgList.length; i++)
      //     SizedBox(
      //       child: Image.network(
      //         imgList[i],
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      // ],

      options: CarouselOptions(
        height: height,
        enableInfiniteScroll: true,
        initialPage: 0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        onPageChanged: (index, reason) {
          setState(() {
            current = index;
          });
        },
      ),
    );
  }
}
