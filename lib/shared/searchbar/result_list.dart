import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loadmore_listview/loadmore_listview.dart';
import 'package:ufcat_app/features/news/pages/wv_news_screen.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class ResultList extends StatefulWidget {
  final List<Map<String, dynamic>> results;

  const ResultList({super.key, required this.results});

  @override
  ResultListState createState() => ResultListState();
}

class ResultListState extends State<ResultList> {
  late List<Map<String, dynamic>> _visibleResults;
  late int _visibleItemCount;
  bool _isLoading = false; // Para evitar carregamentos duplicados
  bool _hasMoreItems = true;

  @override
  void initState() {
    super.initState();
    _visibleResults = widget.results.take(12).toList();
    _visibleItemCount = _visibleResults.length;
    _hasMoreItems = _visibleItemCount < widget.results.length;
  }

  @override
  Widget build(BuildContext context) {
    return LoadMoreListView.builder(
      hasMoreItem: _hasMoreItems,
      onLoadMore: _loadMore,
      onRefresh: _refreshList,
      refreshBackgroundColor: orangeUfcat,
      loadMoreWidget: Container(
        margin: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(orangeUfcat),
        ),
      ),
      itemCount: _visibleItemCount,
      itemBuilder: ((context, index) {
        final result = _visibleResults[index];
        return ListTile(
          title: Text(
            result['title'].trim(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          subtitle: Text(result['date'].trim()),
          leading: _buildImage(result['image_url']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsWebView(
                  url: result['link'],
                  titleAppBar: result['type'],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Future<void> _refreshList() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      _visibleResults = widget.results.take(12).toList();
      _visibleItemCount = _visibleResults.length;
      _hasMoreItems = _visibleItemCount < widget.results.length;
    });
  }

  Future<void> _loadMore() async {
    if (!_hasMoreItems || _isLoading) return; // Evitar carregamentos duplicados

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      final remainingItems = widget.results.length - _visibleItemCount;
      final itemsToLoad = remainingItems > 12 ? 12 : remainingItems;

      _visibleResults.addAll(
        widget.results.skip(_visibleItemCount).take(itemsToLoad),
      );

      _visibleItemCount += itemsToLoad;
      _hasMoreItems = _visibleItemCount < widget.results.length;
      _isLoading = false;
    });
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/placeholder.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      'assets/images/placeholder.png',
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}
