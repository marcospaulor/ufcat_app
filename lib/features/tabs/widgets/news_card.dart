import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ufcat_app/features/news/pages/wv_news_screen.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String link;
  final String category;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.link,
    required this.category,
  });

  Future<bool> isValidUrl(String url) async {
    try {
      Uri uri = Uri.parse(url);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  bool _isDocumentUrl(String url) {
    // Lista de extensões de arquivo que você quer considerar como documentos
    final documentExtensions = ['.pdf', '.docx', '.pptx', '.xlsx'];

    // Verifique se o URL termina com uma extensão de arquivo conhecida
    return documentExtensions.any((extension) => url.endsWith(extension));
  }

  Widget buildImage(BuildContext context) {
    const double imageHeight = 0.30;
    final double containerHeight =
        MediaQuery.of(context).size.height * imageHeight;
    const double containerWidth = double.infinity;

    return FutureBuilder<bool>(
      future: isValidUrl(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SkeletonAnimation(
            shimmerDuration: 1000,
            child: Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
          );
        }
        
        if (snapshot.hasData && snapshot.data == true) {
            return SizedBox(
              width: containerWidth,
              height: containerHeight,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.scaleDown,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/placeholder.png',
                  fit: BoxFit.contain,
                  width: containerWidth,
                  height: containerHeight,
                ),
              ),
            );
          }

          return Image.asset(
              'assets/images/placeholder.png',
              fit: BoxFit.contain,
              width: containerWidth,
              height: MediaQuery.of(context).size.height * imageHeight,
            );

      },
    );
  }

  Widget buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.25 * 0.35,
      width: MediaQuery.of(context).size.width,
      child: title.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title.trim(),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge,
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
      width: MediaQuery.of(context).size.width,
      child: date.isNotEmpty
          ? Text(
              date.trim(),
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
          if (_isDocumentUrl(link)) {
            var uri = Uri.parse(link);
            launchUrl(uri);
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsWebView(
                url: link,
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
