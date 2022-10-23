import 'package:carousel_slider/carousel_slider.dart';
import 'package:ufcat_app/view/const.dart';
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
        CarouselSlider(
          items: imgList
              .map((item) => Container(
                    child: Center(
                        child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                    )),
                  ))
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
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current == index ? orangeUfcat : grayUfcat,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
