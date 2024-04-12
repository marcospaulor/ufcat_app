import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ufcat_app/features/news/pages/wv_news_screen.dart';

class LibraryScreen extends StatefulWidget {
  final String url;
  final String title;

  const LibraryScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NewsWebView(
      url: widget.url,
      titleAppBar: widget.title,
    );
  }
}
