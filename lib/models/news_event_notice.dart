class NewsEventNotice {
  final List<Map<String, dynamic>> newsEventNotice;
  final String category;
  List<String> link = [];
  List<String> title = [];
  List<String> date = [];
  List<String> imageUrl = [];

  NewsEventNotice(this.category, this.newsEventNotice) {
    newsEventNotice
        .where((element) => element['type'] == category)
        .forEach((element) {
      link.add(element['link'] ?? '');
      title.add(element['title'] ?? '');
      date.add(element['date'] ?? '');
      imageUrl.add(element['image_url'] ?? '');
    });
  }

  int get length => title.length;
}
