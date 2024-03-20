class HandleUrl {
  String _url;
  static const String _baseUrl = 'https://ufcat.edu.br';

  HandleUrl(this._url) {
    _url = _handleUrl(_url); // Agora _url já foi inicializado corretamente
  }

  String get url => _url;

  // Método privado para tratar a URL de acordo com a categoria
  String _handleUrl(String url) {
    // Verifica se a categoria está mapeada e retorna a URL correspondente
    if (url.startsWith('http') || url.startsWith('https')) {
      return url;
    }
    return '$_baseUrl$url';
  }
}
