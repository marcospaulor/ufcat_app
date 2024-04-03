import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/providers/handle_url.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsWebView extends StatefulWidget {
  final String url;
  final String titleAppBar;

  NewsWebView({Key? key, required this.url, required this.titleAppBar})
      : super(key: key);

  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  String handleUrl = '';
  bool isLoading = true;
  // final _key = UniqueKey();
  // late final WebViewController _controller;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? _controller;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: true,
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
    mediaPlaybackRequiresUserGesture: false,
    userAgent:
        'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Mobile Safari/537.36',
  );

  PullToRefreshController? pullToRefreshController;
  double progress = 0;
  final urlController = TextEditingController();

  String handleTitle(String title) {
    // Mapa para mapear títulos para categorias correspondentes
    Map<String, String> titleMapping = {
      "noticia": "Notícia",
      "evento": "Evento",
      "edital": "Edital",
    };

    // Obtém a categoria correspondente ou retorna uma string vazia se não encontrada
    return titleMapping[title.toLowerCase()] ?? '';
  }

  @override
  void initState() {
    super.initState();

    handleUrl = HandleUrl(widget.url).url;

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          await _controller?.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          await _controller?.loadUrl(
            urlRequest: URLRequest(
              url: await _controller?.getUrl(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PopScope(
          onPopInvoked: (pop) {
            if (pop) {
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
              }
              _controller?.goBack();
            } else {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            appBar: MyAppBar(
              icon: FontAwesomeIcons.arrowLeft,
              title: handleTitle(widget.titleAppBar),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(handleUrl)),
                initialSettings: settings,
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
                onReceivedServerTrustAuthRequest:
                    (controller, challenge) async {
                  return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED,
                  );
                },
                onReceivedHttpError: ((controller, request, errorResponse) =>
                    print('http error: $errorResponse')),
                onLoadStart: (controller, url) {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                onLoadStop: (controller, url) async {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  await controller.evaluateJavascript(source: '''
                    var mainContent = document.querySelector('.main-content');
                    if (mainContent) {
                      document.body.innerHTML = '';
                      document.body.appendChild(mainContent);
                    }
                    var shareGroup = document.querySelector('.sharegroup-horizontal');
                    if (shareGroup) {
                      shareGroup.remove();
                    }
                  ''');
                },
                onProgressChanged: (controller, progress) {
                  print('WebView is loading (progress : $progress%)');
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print('console message: ${consoleMessage.message}');
                },
                onDownloadStartRequest: (controller, url) {
                  print('download url: $url');
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final String host =
                      Uri.parse(navigationAction.request.url as String).host;
                  print('host: $host');
                  if (host == 'ufcat.edu.br') {
                    return NavigationActionPolicy.ALLOW;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Não é possível abrir links externos.'),
                  ));
                  return NavigationActionPolicy.CANCEL;
                },
              ),
              // WebViewWidget(
              //   key: _key,
              //   controller: _controller,
              // ),
            ),
          ),
        ),
        if (isLoading)
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(),
            ),
          ),
      ],
    );
  }
}
