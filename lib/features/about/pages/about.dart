import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: 'Sobre',
      ),
      endDrawer: const MyNavigationDrawer(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
              'Este app foi desenvolvido pelos alunos Marcio Filho e Marcos Paulo da Universidade Federal de Catalão',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              )),
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}