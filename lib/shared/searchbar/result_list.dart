import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Importe esta biblioteca
import 'package:loadmore/loadmore.dart'; // Importe esta biblioteca
import 'package:ufcat_app/features/news/pages/wv_news_screen.dart';

class ResultList extends StatefulWidget {
  final List<Map<String, dynamic>> results;

  const ResultList({Key? key, required this.results}) : super(key: key);

  @override
  _ResultListState createState() => _ResultListState();
}

class _ResultListState extends State<ResultList> {
  late List<Map<String, dynamic>> _visibleResults;
  late int _visibleItemCount;
  bool _isLoadingMore = false; // Adicione esta variável de estado

  @override
  void initState() {
    super.initState();
    _visibleResults = widget.results;
    _visibleItemCount = widget.results.length > 10 ? 10 : widget.results.length;
  }

  @override
  Widget build(BuildContext context) {
    return LoadMore(
      isFinish: _visibleItemCount >= widget.results.length,
      textBuilder: textLoadMore,
      onLoadMore:
          _loadMore, // Use uma função separada para lidar com o carregamento de mais itens
      child: ListView.builder(
        itemBuilder: (context, index) {
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
        },
        itemCount: _visibleItemCount,
      ),
    );
  }

  Future<bool> _loadMore() async {
    if (_isLoadingMore) return false; // Se já estiver carregando, não faça nada

    _isLoadingMore = true; // Marque que estamos carregando
    await Future.delayed(Duration(seconds: 2)); // Simule uma carga assíncrona

    if (mounted) {
      // Verifique se o estado do widget ainda está montado
      setState(() {
        _visibleItemCount += 10;
        _visibleResults = widget.results.sublist(0, _visibleItemCount);
      });
    }

    _isLoadingMore = false; // Marque que terminamos de carregar
    return true; // Indica que ainda há mais itens para carregar
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        // Substitua o Image.network pelo CachedNetworkImage
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
    } else {
      return Image.asset(
        'assets/images/placeholder.png',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
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
