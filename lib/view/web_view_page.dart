import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacker_news_proj/service/navigation_controls.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  final String endPoint;
  final Completer<WebViewController> controller;
  const WebViewStack(
      {required this.endPoint, required this.controller, super.key});

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.endPoint, // use Widget.parameter or field you want to grab from the stateful widget above.
            onWebViewCreated: (webViewController) {
              widget.controller.complete(webViewController);
            },
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              color: Colors.red,
              minHeight: 5,
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({required this.urlData, super.key});
  final String urlData;

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff457B9D),
        title: const Text('Web View'),
        actions: [
          NavigationControls(controller: controller),
        ],
      ),
      body: SafeArea(
        child: WebViewStack(
          endPoint: widget.urlData,
          controller: controller,
        ),
      ),
    );
  }
}
