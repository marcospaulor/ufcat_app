import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/components/app_bar.dart';
import 'package:ufcat_app/src/view/components/star_rating.dart';

class RUScreen extends StatefulWidget {
  const RUScreen({Key? key}) : super(key: key);

  @override
  State<RUScreen> createState() => _RUScreenState();
}

class _RUScreenState extends State<RUScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const MyAppBar(
          icon: FontAwesomeIcons.arrowLeft,
          height: 2 * kToolbarHeight,
          title: 'R.U.',
          bottom: TabBar(
            labelColor: orangeUfcat,
            unselectedLabelColor: grayUfcat,
            indicatorColor: orangeUfcat,
            tabs: [
              Tab(
                text: 'Almoço',
              ),
              Tab(
                text: 'Jantar',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: grayUfcat,
              child: Column(
                children: [
                  // Avaliação da refeição com estrelas e botão de enviar
                  Container(
                    height: width * 0.2,
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 13.0,
                              vertical: 1.0,
                            ),
                            child: StarRating(),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: orangeUfcat,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 51.0,
                                vertical: 10.0,
                              ),
                              child: Text('Avaliar'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Center(
                    child: Text(
                      'Almoço',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text('RU'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: const Center(
                child: Text('RU'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
