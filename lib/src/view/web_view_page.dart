// ignore_for_file: unnecessary_string_escapes

//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_payments/src/values/k_colors.dart';
import 'package:flutter_payments/src/view/web_view_page_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../components/common/loading_component.dart';

class WebViewPage extends StatefulWidget {
  final Uri? url;
  const WebViewPage(
    this.url, {
    Key? key,
  }) : super(key: key);
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends StateMVC<WebViewPage> {
  late WebViewPageController _con;

  WebViewPageState() : super(WebViewPageController()) {
    _con = WebViewPageController.con;
  }
  @override
  void initState() {
    _con.initPage(url: widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _con.onBack(context),
        child: Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kPrimary,
            elevation: 0,
            // title: const Text("CPACF Web"),
            leading: GestureDetector(
              onTap: () {
                _con.onBack(context);
              },
              child: const Icon(
                Icons.keyboard_backspace,
                color: kWhite,
              ),
            ),
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: _con.webViewController),
              /* InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useOnDownloadStart: true,
                    transparentBackground: true,
                  ),
                ),
                initialUrlRequest: URLRequest(url: _con.url),
                onWebViewCreated: (controller) {
                  _con.webViewController = controller;
                },
                /* shouldOverrideUrlLoading: (controller, navigationAction) async {
                  if (!kIsWeb) {
                    if (navigationAction.request.url!.pathSegments.last
                        .contains(RegExp("\..+"))) {
                      await _con.downloadFile(navigationAction.request.url!);
                    }
                    return NavigationActionPolicy.ALLOW;
                  }
                  return NavigationActionPolicy.CANCEL;
                },
                onDownloadStartRequest:
                    (controller, downloadStartRequest) async {
                  await _con.downloadFile(downloadStartRequest.url);
                }, */
                onLoadStart: (controller, url) {
                  _con.setLoading(true);
                },
                onLoadStop: (controller, url) {
                  _con.setLoading(false);
                },
              ), */
              Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: _con.isLoading,
                  child: loadingComponent(
                    true,
                    color: kPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
