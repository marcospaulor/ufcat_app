import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/shared/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class LibraryScreen extends StatefulWidget {
  final String url;

  const LibraryScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _key = UniqueKey();
  bool isLoading = true;
  late final WebViewController _controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      Navigator.of(context).pop();
      return Future.value(true);
    }
  }

  @override
  void initState() {
    super.initState();

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

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (finish) {
          setState(
            () {
              isLoading = true;
            },
          );
        },
        onPageFinished: (finish) {
          setState(
            () {
              isLoading = false;
            },
          );
        },
      ))
      ..loadRequest(Uri.parse(widget.url));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WillPopScope(
          onWillPop: () => _goBack(context),
          child: Scaffold(
            appBar: const MyAppBar(
              icon: FontAwesomeIcons.arrowLeft,
              title: 'Biblioteca',
            ),
            body: WebViewWidget(
              key: _key,
              controller: _controller,
              // initialUrl: widget.url,
              // javascriptMode: JavascriptMode.unrestricted,
              // onPageStarted: (finish) {
              //   setState(
              //     () {
              //       isLoading = true;
              //     },
              //   );
              //   // },
              //   onProgress: (int progress) {
              //     print('WebView is loading (progress : $progress%)');
              //   },
              //   onPageFinished: (finish) {
              //     setState(
              //       () {
              //         isLoading = false;
              //       },
              //     );
              //   },
              //   onWebViewCreated: (WebViewController webViewController) {
              //     _controllerCompleter.future
              //         .then((value) => _controller = value);
              //     _controllerCompleter.complete(webViewController);
              //   },
            ),
          ),
        ),
        isLoading
            ? Center(
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
              )
            : Stack(),
      ],
    );
  }
}
