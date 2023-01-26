import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/components/app_bar.dart';
import 'package:ufcat_app/src/view/components/star_rating.dart';
import 'package:ufcat_app/src/view/style/const.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Avaliação',
        icon: FontAwesomeIcons.arrowLeft,
      ),
      body: ListView(children: [
        SizedBox(
          height: height * 0.9,
          width: double.infinity,
          child: Container(
            decoration: const BoxDecoration(
              color: grayUfcat,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            margin: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
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
                  width: width,
                  height: height * 0.1,
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: StarRating(
                      padding: 20.0,
                      size: 30.0,
                    ),
                  ),
                ),
                // input area
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: width * 0.8,
                  child: const TextField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: InputBorder.none, // no border
                      hintText: 'Digite seu comentário aqui...',
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
      ]),
    );
  }
}
