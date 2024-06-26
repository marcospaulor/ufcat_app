import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:ufcat_app/shared/bottom_bar.dart';
import 'package:ufcat_app/shared/side_menu.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    super.key,
    required this.label,
    required this.text,
    required this.title,
    required this.data,
    required this.img,
  });

  final String label;
  final String text;
  final String title;
  final String data;
  final String img;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> drawerKey = GlobalKey();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: drawerKey,
      appBar: MyAppBar(
        title: widget.label,
        icon: FontAwesomeIcons.arrowLeft,
      ),
      endDrawer: const MyNavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: height * 0.16,
              width: width,
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Text(
                      widget.data,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(drawerKey: drawerKey),
    );
  }
}
