import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  String url;

  MyWebView(@required this.url, {Key? key}) : super(key: key);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  double _lineProgress = 0.0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('---WebView build');
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back)),
        title: const Text('Flutter WebView Title'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Visibility(
            visible: (_lineProgress >= 1.0 ? false : true),
            child: LinearProgressIndicator(
              value: _lineProgress == 1.0 ? 0 : _lineProgress,
            ),
          ),
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          setState(() {
            _lineProgress = progress * 0.01;
            print('_lineProgress$_lineProgress');
          });
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton(
            onPressed: () async {
              String? url;
              if (controller.hasData) {
                url = await controller.data!.currentUrl();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    controller.hasData
                        ? 'Favorited $url'
                        : 'Unable to favorite',
                  ),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          );
        });
  }
}
