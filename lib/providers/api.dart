class Api {
  String _url;
  String _category;
  static const String newsUrl = 'https://portal.ufcat.edu.br/noticias';
  static const String eventsUrl = 'https://portal.ufcat.edu.br/eventos';
  static const String noticesUrl = 'https://portal.ufcat.edu.br/artigos';

  Api(this._url, this._category) {
    _category = _category; // Movido para cima
    _url = handleUrl(_category, _url); // Agora _url já foi inicializado
    print(_url);
  }

  String get url => _url;

  // tratar a url de acordo com a categoria
  String handleUrl(category, url) {
    // verifica quais categorias são e retorna a url concatenada com a categoria
    if (category == 'noticia') {
      return newsUrl + url;
    } else if (category == 'evento') {
      return eventsUrl + url;
    } else if (category == 'edital') {
      // tratar se o link não começar com /
      if (!url.startsWith('/')) {
        return url;
      }
      return noticesUrl + url;
    }
    return _url;
  }
}
