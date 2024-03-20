import 'package:flutter/material.dart';
import 'result_list.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  final List<Map<String, dynamic>> data;

  const ResultScreen({super.key, required this.query, required this.data});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> results = data
        .where((element) =>
            element['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      body: ResultList(results: results),
    );
  }
}
