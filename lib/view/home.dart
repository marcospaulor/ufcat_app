import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/components/myAppBar.dart';
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
                    alignment: Alignment.center,
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
                    child: const CardButton(
                      label: 'noticias',
                    )),
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
                    child: const CardButton(
                      label: 'eventos',
                    )),
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
                    child: const CardButton(
                      label: 'editais',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
