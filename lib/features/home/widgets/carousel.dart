import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ufcat_app/features/news/pages/wv_news_screen.dart';
import 'package:ufcat_app/providers/firebase_api.dart';
import 'package:ufcat_app/theme/theme.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late Future<List<Map<String, dynamic>>> _futureInfos;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _futureInfos = _loadDataFromFirebase();
  }

  Future<List<Map<String, dynamic>>> _loadDataFromFirebase() async {
    return FirebaseApi().getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureInfos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final dataList = snapshot.data!;
          final titleWidgets = _buildTitleWidgets(dataList);
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/images/UFCAT_aerea.png',
                height: MediaQuery.of(context).size.height * (1 / 3),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.50),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo_completa.png',
                  height: MediaQuery.of(context).size.height * (1 / 8),
                  cacheHeight: 300,
                  fit: BoxFit.contain,
                ),
              ),
              CarouselSlider(
                items: titleWidgets,
                carouselController: CarouselController(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  initialPage: _current,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: titleWidgets.asMap().entries.map((entry) {
                  final int index = entry.key;
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? orangeUfcat.withOpacity(0.9)
                          : grayUfcat.withOpacity(0.9),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _current == index ? orangeUfcat : grayUfcat,
                          _current == index
                              ? orangeUfcat.shade600
                              : grayUfcat.shade600,
                          _current == index
                              ? orangeUfcat.shade700
                              : grayUfcat.shade700,
                          _current == index
                              ? orangeUfcat.shade800
                              : grayUfcat.shade800,
                          _current == index
                              ? orangeUfcat.shade900
                              : grayUfcat.shade900,
                          Colors.black,
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    );
  }

  List<Widget> _buildTitleWidgets(List<Map<String, dynamic>> dataList) {
    final List<Widget> titleWidgets = [];

    for (var i = 0; i < 5 && i < dataList.length; i++) {
      final item = dataList[i];
      final String title = item['title'];
      final String link = item['link'];
      final String type = item['type'];

      titleWidgets.add(
        Container(
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: 40.0,
            horizontal: 25.0,
          ),
          child: UnconstrainedBox(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsWebView(url: link, titleAppBar: type),
                  ),
                );
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(0, 0),
                maximumSize:
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.85),
              ),
              child: Text(
                title,
                softWrap: false,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.apply(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
          ),
        ),
      );
    }

    return titleWidgets;
  }
}
