import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class WebScraping {
  final Map<String, String> _urls = {
    "noticia": "https://portal.ufcat.edu.br/noticias",
    "evento": "https://portal.ufcat.edu.br/eventos",
    "edital": "https://portal.ufcat.edu.br/editais"
  };

  final String _jsonFilePath = "assets/database/data.json";

  final Dio _dio = Dio();

  Future<void> scrapeData() async {
    final allData = <Map<String, dynamic>>[];

    await Future.forEach(_urls.entries, (MapEntry<String, String> entry) async {
      final data = await _extractData(entry.value, entry.key);
      allData.addAll(data);

      print("Data for ${entry.key}:");
      print(data);
      print("\n");
    });

    await File(_jsonFilePath).writeAsString(jsonEncode(allData), flush: true);
    print("Data saved to: $_jsonFilePath");
  }

  Future<List<Map<String, dynamic>>> _extractData(
      String url, String dataType) async {
    final dataList = <Map<String, dynamic>>[];

    Future<void> getDataFromPage(dom.Document document) async {
      final tileItems = document.querySelectorAll('.tileItem');

      for (final tileItem in tileItems) {
        final link = tileItem.querySelector('a')?.attributes['href'] ?? '';
        final title = tileItem.querySelector('.tileHeadLine')?.text ?? '';

        final imageElement = tileItem.querySelector('img');
        final imageUrl = imageElement?.attributes['src'];
        final altText = imageElement?.attributes['alt'] ?? '';

        final tileDateNews = tileItem.querySelector('.tileDateNews');
        String date;

        if (tileDateNews != null) {
          final dateTexts = tileDateNews.children
              .map((element) => element.text.trim())
              .where((text) => text.isNotEmpty)
              .toList();

          date = dateTexts.join(" ");
        } else {
          date = tileItem.querySelector('.tileDate span')?.text ?? '';
        }

        dataList.add({
          'type': dataType,
          'link': link,
          'title': title,
          'date': date,
          'image_url': imageUrl,
          'alt_text': altText,
        });
      }
    }

    for (int page = 1; page <= 5; page++) {
      final pageUrl = "$url?page=$page";

      try {
        final response = await _dio.get(pageUrl);
        final document = parser.parse(response.data);
        await getDataFromPage(document);
      } catch (e) {
        print("Error fetching data from $pageUrl: $e");
      }
    }

    return dataList;
  }

  void dispose() {
    _dio.close();
  }
}
