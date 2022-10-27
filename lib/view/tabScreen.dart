import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/view/const.dart';
import 'package:ufcat_app/view/components/myAppBar.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MyAppBar(
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
                icon: Text('EDITAIS'),
              ),
              Tab(
                icon: Text('EVENTOS'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Car'),
            ),
            Center(
              child: Text('Transit'),
            ),
            Center(
              child: Text('Bike'),
            ),
          ],
        ),
      ),
    );
  }
}
