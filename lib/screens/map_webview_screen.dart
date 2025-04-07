import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:webview_flutter/webview_flutter.dart';

class MapWebViewScreen extends StatefulWidget {
  @override
  State<MapWebViewScreen> createState() => _MapWebViewScreenState();
}

class _MapWebViewScreenState extends State<MapWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize controller with platform-agnostic params
    final PlatformWebViewControllerCreationParams params =
    const PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent);

    _loadHtmlFromAssets();
  }

  Future<void> _loadHtmlFromAssets() async {
    final htmlContent = await rootBundle.loadString('assets/html/index.html');
    _controller.loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
