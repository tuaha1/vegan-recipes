import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayYoutubeVideos extends StatelessWidget {

  const DisplayYoutubeVideos({Key? key, required this.choice, required this.title}) : super(key: key);
  final String title;
  final String choice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl: choice,
            javascriptMode: JavascriptMode.unrestricted,
          );
        },
      ),
    );
  }
}