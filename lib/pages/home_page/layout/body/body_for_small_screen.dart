import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePageBodyForSmallScreen extends StatelessWidget {
  const HomePageBodyForSmallScreen(
      {super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: webViewController,
    );
  }
}
