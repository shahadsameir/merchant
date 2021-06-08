import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class webview extends StatefulWidget {
  final String token;
  webview({this.token});

  @override
  _webviewState createState() => _webviewState();
}

class _webviewState extends State<webview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: WebView(

          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://delivery.dtc.iq/merchant/api_webview?token=${widget.token}',
        ),
      ),
    );
  }
}
