import 'package:flutter/cupertino.dart';
import 'package:probot/config.dart';

class CommonWebView extends StatefulWidget {
  const CommonWebView({Key? key}) : super(key: key);

  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(Get.arguments))
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (NavigationRequest request) {
        return NavigationDecision.navigate;
      }));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.white,
      appBar: AppBar(
        backgroundColor: appCtrl.appTheme.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Icon(CupertinoIcons.multiply,color: appCtrl.appTheme.txt).inkWell(onTap: ()=>Get.back()),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
