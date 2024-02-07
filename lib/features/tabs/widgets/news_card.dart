import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ufcat_app/features/news/pages/wv_news_screen.dart';
import 'package:ufcat_app/providers/api.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String link;
  final String category;

  const NewsCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.link,
    required this.category,
  }) : super(key: key);

  Future<bool> isValidUrl(String url) async {
    try {
      Uri uri = Uri.parse(url);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  Widget buildImage(BuildContext context) {
    bool hasImageUrl = imageUrl.isNotEmpty;

    if (category.toLowerCase() == "eventos") {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25 * 0.65,
        child: Icon(
          Icons.event,
          size: 100,
          color: Colors.grey[300],
        ),
      );
    }

    return hasImageUrl
        ? FutureBuilder<bool>(
            future: isValidUrl(imageUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SkeletonAnimation(
                  shimmerDuration: 1000,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25 * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                  ),
                );
              } else if (snapshot.hasError || !(snapshot.data ?? false)) {
                return Image.asset(
                  'assets/images/logo_logo.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25 * 0.65,
                );
              } else {
                return SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25 * 0.65,
                  child: Ink.image(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                );
              }
            },
          )
        : Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25 * 0.65,
          );
  }

  Widget buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.25 * 0.35,
      width: MediaQuery.of(context).size.width * 0.9,
      child: title.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : SkeletonAnimation(
              shimmerDuration: 1000,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
    );
  }

  Widget buildDate(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.25 * 0.15,
      child: date.isNotEmpty
          ? Text(
              date,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
            )
          : SkeletonAnimation(
              shimmerDuration: 1000,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 10.0),
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsWebView(
                url: Api(link, category).url,
                titleAppBar: category,
              ),
            ),
          );
        },
        splashColor: Colors.black.withOpacity(0.25),
        highlightColor: Colors.transparent,
        child: Column(
          children: [
            buildImage(context),
            buildTitle(context),
            buildDate(context),
          ],
        ),
      ),
    );
  }
}