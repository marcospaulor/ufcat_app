import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:ufcat_app/features/tabs/widgets/news_card.dart';
import 'package:ufcat_app/providers/firebase_api.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class NewsList extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> futureInfos;
  final String category;

  const NewsList({
    Key? key,
    required this.futureInfos,
    required this.category,
  }) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late Future<List<Map<String, dynamic>>> _futureInfos;
  late List<Map<String, dynamic>> _allInfos = [];
  int _visibleItemCount = 8;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  int _lastLoadedIndex = 0; // Índice do último item carregado

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
      // Verifica se o widget está montado antes de chamar setState
      setState(() {
        _futureInfos = _loadDataFromFirebase();
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
          _allInfos = snapshot.data!;
          final filteredInfos = _allInfos
              .where((info) => info['type'] == widget.category)
              .toList();

          return RefreshIndicator(
            color: greenUfcat,
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: LoadMore(
              // Português: "Carregar mais"
              textBuilder: ((status) {
                return textLoadMore(status);
              }),
              isFinish: filteredInfos.length >= _allInfos.length,
              onLoadMore: () async {
                // Simulating a delay
                await Future.delayed(const Duration(seconds: 2));

                // Determine o índice do próximo item a ser carregado
                int nextIndex = _lastLoadedIndex + _visibleItemCount;
                if (nextIndex > filteredInfos.length) {
                  nextIndex = filteredInfos.length;
                }
                if (mounted) {
                  // Verifica se o widget está montado antes de chamar setState
                  setState(() {
                    _visibleItemCount =
                        nextIndex; // Carrega até o próximo índice
                    _lastLoadedIndex =
                        nextIndex; // Atualiza o índice do último item carregado
                  });
                }
                return true; // Indica que ainda há mais itens para carregar
              },
              child: ListView.builder(
                itemCount: _visibleItemCount,
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
            ),
          );
        }
      },
    );
  }

  String textLoadMore(status) {
    switch (status) {
      case LoadMoreStatus.idle:
        return 'Carregar mais';
      case LoadMoreStatus.loading:
        return 'Carregando...';
      case LoadMoreStatus.fail:
        return 'Erro ao carregar';
      case LoadMoreStatus.nomore:
        return 'Fim';
    }
    return '';
  }
}
