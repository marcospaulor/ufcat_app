import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:path_provider/path_provider.dart';

class WebScrap {
  final Map<String, String> _urls = {
    "noticia": "https://portal.ufcat.edu.br/noticias",
    "evento": "https://portal.ufcat.edu.br/eventos",
    "edital": "https://portal.ufcat.edu.br/editais"
  };

  final Dio _dio = Dio();

  Future<void> checkAndScrapeData() async {
    print("Checking and scraping data");
    final String jsonFilePath = await _getJsonFilePath();
    final bool fileExists = await File(jsonFilePath).exists();

    if (!fileExists || await _isFileEmpty(jsonFilePath)) {
      await _createAndWriteJsonFile(jsonFilePath);
    }
  }

  Future<bool> _isFileEmpty(String filePath) async {
    final File file = File(filePath);
    final String fileContent = await file.readAsString();
    return fileContent.isEmpty;
  }

  Future<void> _createAndWriteJsonFile(String filePath) async {
    final allData = <Map<String, dynamic>>[];

    await Future.forEach(_urls.entries, (MapEntry<String, String> entry) async {
      final data = await _extractData(entry.value, entry.key);
      allData.addAll(data);
    });

    await _writeJsonFile(filePath, allData);
  }

  Future<void> _writeJsonFile(
      String filePath, List<Map<String, dynamic>> data) async {
    final file = File(filePath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(jsonEncode(data),
        flush: true, mode: FileMode.write);
  }

  Future<List<Map<String, dynamic>>> readJsonFile() async {
    final String jsonFilePath = await _getJsonFilePath();
    final File file = File(jsonFilePath);
    if (!await file.exists()) {
      throw const FileSystemException('File does not exist');
    }

    final String fileContent = await file.readAsString();
    return jsonDecode(fileContent).cast<Map<String, dynamic>>();
  }

  Future<String> _getJsonFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/data.json';
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

    for (int page = 1; page <= 4; page++) {
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
