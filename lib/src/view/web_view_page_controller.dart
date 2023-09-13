//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../interfaces/i_view_controller.dart';

class WebViewPageController extends ControllerMVC implements IViewController {
  static late WebViewPageController _this;

  factory WebViewPageController() {
    _this = WebViewPageController._();
    return _this;
  }

  static WebViewPageController get con => _this;
  WebViewPageController._();
  bool isLoading = false;

  //InAppWebViewController? webViewController;
  late WebViewController webViewController;
  Uri? url;

  @override
  void initPage({Uri? url}) {
    this.url = url;
    String lineas = "-" * 20;
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress);
          },
          onPageStarted: (String url) {
            print("\n${lineas}\nURL START: ${url}\n${lineas}\n\n");
          },
          onPageFinished: (String url) {
            print("\n${lineas}\nURL FINISH: ${url}\n${lineas}\n\n");
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            print("\n${lineas}\nURL CHANGE: ${change.url}\n${lineas}\n\n");
          },
        ),
      )
      ..loadRequest(this.url! /* Uri.parse('https://flutter.dev') */);
  }

  @override
  disposePage() {}

  /* downloadFile(Uri link) async {
    bool hasStoragePermission = await Permission.storage.isGranted;

    if (!hasStoragePermission) {
      final status = await Permission.storage.request();
      hasStoragePermission = status.isGranted;
    }

    if (hasStoragePermission) {
      await FlutterDownloader.enqueue(
        url: link.toString(),
        savedDir: ((await getTemporaryDirectory()).path),
        saveInPublicStorage: true,
        fileName: link.pathSegments.last,
      );
    }
  } */

  Future<bool> onBack(BuildContext context) async {
    Navigator.of(context).pop();
    return false;
  }

  setLoading(bool load) {
    isLoading = load;
    setState(() {});
  }
}
