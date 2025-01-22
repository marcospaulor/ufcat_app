import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';

class About extends StatelessWidget {
  const About({super.key});

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
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sobre o Aplicativo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Este aplicativo foi desenvolvido para a Universidade Federal de Catalão (UFCAT) em conjunto com o SETI (Secretaria de Tecnologia e Informação).',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Desenvolvido por (GitHub):\n Marcos Paulo Rodrigues (@marcospaulor)\n Marcio Filho (@Marcio-F)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
