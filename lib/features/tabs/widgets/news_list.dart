import 'package:flutter/material.dart';
import 'package:ufcat_app/features/tabs/widgets/news_card.dart';

class NewsList extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> futureInfos;
  final String category;
  final Future<List<Map<String, dynamic>>> Function() readJson;

  const NewsList({
    Key? key,
    required this.futureInfos,
    required this.category,
    required this.readJson,
  }) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late Future<List<Map<String, dynamic>>> _futureInfos;

  @override
  void initState() {
    super.initState();
    _futureInfos = widget.futureInfos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureInfos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return NewsCard(
                imageUrl: '',
                title: '',
                date: '',
                link: '',
                category: widget.category,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available.'),
          );
        } else {
          final infos = snapshot.data!;
          final filteredInfos =
              infos.where((info) => info['type'] == widget.category).toList();

          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                _futureInfos = widget.readJson();
              });
            },
            child: ListView.builder(
              itemCount: filteredInfos.length,
              itemBuilder: (context, index) {
                return NewsCard(
                  imageUrl: filteredInfos[index]['image_url'].toString(),
                  title: filteredInfos[index]['title'].toString(),
                  date: filteredInfos[index]['date'].toString(),
                  link: filteredInfos[index]['link'].toString(),
                  category: widget.category,
                );
              },
            ),
          );
        }
      },
    );
  }
}
