import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/providers/handle_url.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

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
  final _key = UniqueKey();
  bool isLoading = true;
  late final WebViewController _controller;

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

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    controller
      ..clearCache()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (finish) {
            if (mounted) {
              setState(() {
                isLoading = true;
              });
            }
          },
          onPageFinished: (finish) async {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
            await controller.runJavaScript('''
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
          onWebResourceError: (error) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            final String host = Uri.parse(request.url).host;
            print('host: $host');
            if (host == 'ufcat.edu.br') {
              return NavigationDecision.navigate;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Não é possível abrir links externos.'),
                duration: Duration(seconds: 3),
              ),
            );
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(handleUrl),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Mobile Safari/537.36',
        },
        method: LoadRequestMethod.get,
      );

    _controller = controller;
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
              _controller.goBack();
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
              child: WebViewWidget(
                key: _key,
                controller: _controller,
              ),
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
