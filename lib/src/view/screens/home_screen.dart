import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/app_bar.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/components/carousel.dart';
import 'package:ufcat_app/src/view/components/shortcut_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MyAppBar(
        // icon: FontAwesomeIcons.bars,
        title: 'Serviços UFCAT',
        isSearch: true,
      ),
      // drawer: const NavigationDrawer(),
      backgroundColor: grayUfcat,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 5.0,
            ),
            height: MediaQuery.of(context).size.height * (1 / 3.5),
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
            margin: const EdgeInsets.only(top: 5.0),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            width: width,
            alignment: Alignment.center,
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
        ],
      ),
    );
  }
}
