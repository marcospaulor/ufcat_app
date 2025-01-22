import 'package:flutter/material.dart';
import 'package:loadmore_listview/loadmore_listview.dart';
import 'package:ufcat_app/features/tabs/widgets/news_card.dart';
import 'package:ufcat_app/providers/firebase_api.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class NewsList extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> futureInfos;
  final String category;

  const NewsList({
    super.key,
    required this.futureInfos,
    required this.category,
  });

  @override
  NewsListState createState() => NewsListState();
}

class NewsListState extends State<NewsList> {
  late Future<List<Map<String, dynamic>>> _futureInfos;
  late List<Map<String, dynamic>> _allInfos = [];
  late List<Map<String, dynamic>> _visibleInfos = [];
  int _visibleItemCount = 8;
  bool _hasMoreItems = true; // Controle de itens adicionais

  @override
  void initState() {
    super.initState();
    _futureInfos = widget.futureInfos;
  }

  Future<List<Map<String, dynamic>>> _loadDataFromFirebase() async {
    return FirebaseApi().getData();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _futureInfos = _loadDataFromFirebase();
        _visibleItemCount = 8;
        _hasMoreItems = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureInfos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => NewsCard(
              imageUrl: '',
              title: '',
              date: '',
              link: '',
              category: widget.category,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available.'),
          );
        }

        _allInfos = snapshot.data!;
        final filteredInfos = _allInfos
            .where((info) => info['type'] == widget.category)
            .toList();

        _visibleInfos = filteredInfos.take(_visibleItemCount).toList();
        _hasMoreItems = _visibleInfos.length < filteredInfos.length;

        return LoadMoreListView.builder(
          hasMoreItem: _hasMoreItems,
          onLoadMore: _loadMore,
          onRefresh: _handleRefresh,
          refreshBackgroundColor: orangeUfcat,
          loadMoreWidget: Container(
            margin: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(orangeUfcat),
            ),
          ),
          itemCount: _visibleInfos.length,
          itemBuilder: (context, index) {
            final info = _visibleInfos[index];
            return NewsCard(
              imageUrl: info['image_url'].toString(),
              title: info['title'].toString(),
              date: info['date'].toString(),
              link: info['link'].toString(),
              category: widget.category,
            );
          },
        );
      },
    );
  }

  Future<void> _loadMore() async {
    if (!_hasMoreItems) return;

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      final filteredInfos = _allInfos
          .where((info) => info['type'] == widget.category)
          .toList();

      final remainingItems = filteredInfos.length - _visibleInfos.length;
      final itemsToLoad = remainingItems > 8 ? 8 : remainingItems;

      _visibleInfos.addAll(
        filteredInfos.skip(_visibleInfos.length).take(itemsToLoad),
      );

      _visibleItemCount += itemsToLoad;
      _hasMoreItems = _visibleInfos.length < filteredInfos.length;
    });
  }
}
