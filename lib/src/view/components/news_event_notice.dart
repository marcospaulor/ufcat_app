class NewsEventNotice {
  final List newsEventNotice;
  final String category;
  List title = [];
  List description = [];

  NewsEventNotice(this.category, this.newsEventNotice) {
    for (var i = 0; i < newsEventNotice.length; i++) {
      if (newsEventNotice[i]['attributes']['category']['data']['attributes']
              ['name'] ==
          category) {
        title += [newsEventNotice[i]['attributes']['Titulo']];
        description += [newsEventNotice[i]['attributes']['Descricao']];
      }
    }
  }

  int length() {
    return title.length;
  }
}
