import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_my/components/load_view.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  var itemUrl;
  var tital;

  MyWebView(this.tital, this.itemUrl);

  @override
  State<StatefulWidget> createState() {
    return MyWebViewState();
  }
}

class MyWebViewState extends State<MyWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  var currentUrl;

  @override
  void initState() {
    super.initState();
    currentUrl = widget.itemUrl;
    flutterWebviewPlugin.onDestroy.listen((Null) {
      //该监听用于处理进入第二个页面，并回到首页的返回监听
      Navigator.pop(context);
    });
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      currentUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: WebviewScaffold(
          url: widget.itemUrl,
          appBar: AppBar(
//              leading: IconButton(//只要重写，继承WebviewScaffold的点击事件不响应
//                  icon: Icon(Icons.arrow_back_ios), onPressed: _requestPop),
            title: Text(widget.tital),
            centerTitle: true,
          ),
          withZoom: false,
          withLocalStorage: true,
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    //处理标题返回监听、及首次进入的返回监听
    //  ///弹出页面并传回int值100，用于上一个界面的回调
    if (currentUrl == widget.itemUrl) {
      Navigator.of(context).pop();
    } else {
      flutterWebviewPlugin.goBack();
    }

    return new Future.value(false);
  }
}
