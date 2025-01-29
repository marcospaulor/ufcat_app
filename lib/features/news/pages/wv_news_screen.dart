import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/models/handle_url.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ufcat_app/theme/theme.dart';

class NewsWebView extends StatefulWidget {
  final String url;
  final String titleAppBar;

  const NewsWebView({super.key, required this.url, required this.titleAppBar});

  @override
  NewsWebViewState createState() => NewsWebViewState();
}

class NewsWebViewState extends State<NewsWebView> {
  String handleUrl = '';
  bool isLoading = true;
  bool showWebView = false;
  // final _key = UniqueKey();
  // late final WebViewController _controller;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? _controller;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: true,
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
    mediaPlaybackRequiresUserGesture: false,
    transparentBackground: true,
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
    return titleMapping[title.toLowerCase()] ?? title;
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
    return Scaffold(
      appBar: MyAppBar(
        icon: FontAwesomeIcons.arrowLeft,
        title: handleTitle(widget.titleAppBar),
      ),
      body: Stack(
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
            child: Padding(
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
                onLoadStart: (controller, url) {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                onLoadStop: (controller, url) async {
                  try {
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
                  } catch (e) {
                    print('Erro ao remover elementos da página: $e');
                  }

                  if (mounted) {
                    setState(() {
                      isLoading = false;
                      showWebView = true;
                    });
                  }
                },
                onProgressChanged: (controller, progress) {
                  if (mounted) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  }
                },
                pullToRefreshController: pullToRefreshController,
                onDownloadStartRequest: (controller, downloadRequest) async {
                  final BuildContext? context = webViewKey.currentContext;
                  final String url = downloadRequest.url.toString();
                  final Uri uri = Uri.parse(url);

                  final scaffoldMessenger = ScaffoldMessenger.of(context!);
                  bool isMounted = scaffoldMessenger.mounted;

                  if (Platform.isAndroid || Platform.isIOS) {
                    if (isMounted) {
                      scaffoldMessenger.showSnackBar(SnackBar(
                        content: Text('Download iniciado: $url'),
                      ));
                    }
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      if (isMounted) {
                        scaffoldMessenger.showSnackBar(SnackBar(
                          content: Text('Não foi possível abrir o link: $url'),
                        ));
                      }
                    }
                  }
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final String host =
                      Uri.parse(navigationAction.request.url.toString()).host;
                  final String url = navigationAction.request.url.toString();

                  final List<String> allowedHosts = [
                    'ufcat.edu.br',
                    'biblioteca.sophia.com.br',
                    'prod.ufcat.edu.br',
                    'cppg.catalao.ufg.br',
                    'ppgep.catalao.ufg.br',
                    'files.cercomp.ufg.br',
                  ];

                  if (allowedHosts.contains(host)) {
                    return NavigationActionPolicy.ALLOW;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Abrindo link externo no navegador...'),
                  ));
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Não foi possível abrir o link.'),
                    ));
                  }

                  return NavigationActionPolicy.CANCEL;
                },
              ),
            ),
          ),
          if (isLoading || !showWebView)
            Stack(children: [
              Container(
                color: Colors.white,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator(color: orangeUfcat)
                      : const CupertinoActivityIndicator(),
                ),
              ),
            ]),
        ],
      ),
    );
  }
}
