import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/star_rating.dart';
import 'package:ufcat_app/shared/side_menu.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: drawerKey,
      appBar: const MyAppBar(
        title: 'Avaliação',
        icon: FontAwesomeIcons.arrowLeft,
      ),
      endDrawer: const MyNavigationDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.9,
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Icon(
                        FontAwesomeIcons.heartCircleCheck,
                        color: greenUfcat,
                        size: 150,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Avalie a refeição!',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: primaryBlack),
                    ),
                  ),
                  Container(
                    width: width * 0.6,
                    height: height * 0.075,
                    margin: const EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: grayUfcat,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: StarRating(
                      padding: 10.0,
                      size: 30.0,
                    ),
                  ),
                  // input area
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: width * 0.8,
                    child: const TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        hintText: 'Digite seu comentário aqui...',
                        filled: true,
                        fillColor: grayUfcat,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 0.4, height * 0.05),
                        backgroundColor: orangeUfcat,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('ENVIAR'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
