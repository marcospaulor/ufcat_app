import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/style/const.dart';
import 'package:ufcat_app/src/view/components/appBar.dart';

class NewsScreen extends StatefulWidget {
  // atributos title, image, description, date
  const NewsScreen(
      {Key? key,
      required this.title,
      required this.image,
      required this.description,
      required this.date})
      : super(key: key);

  final String title;
  final String image;
  final String description;
  final String date;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const MyAppBar(icon: FontAwesomeIcons.arrowLeft, title: 'Notícias'),
      body: const Center(
        child: Text('Notícias'),
      ),
    );
  }
}
