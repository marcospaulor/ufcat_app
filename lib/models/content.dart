import 'dart:convert';

import 'package:flutter/services.dart';

class Content {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String category;

  Content(
      {this.title,
      this.description,
      this.urlToImage,
      this.publishedAt,
      this.content,
      required this.category});

  Future<List> readJson() async {
    final String response =
        await rootBundle.loadString('assets/database/portal.json');
    final data = await json.decode(response);

    return data['data'];
  }
}
