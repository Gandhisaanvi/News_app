import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget
{
   String BlogUrl;
   ArticleView({required this.BlogUrl});

  @override
  State< ArticleView >createState() => _ArticleViewState();
}

class _ArticleViewState extends State< ArticleView > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Flutter"),
              Text("News", style: TextStyle(fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),)
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: WebView(
          initialUrl:widget.BlogUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),

    );
  }
}
