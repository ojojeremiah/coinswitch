import 'package:coinswitch/screen/home.dart';
import 'package:coinswitch/screen/navbar.dart';
import 'package:coinswitch/service/mnemonic.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SellWebview extends StatefulWidget {
  final String url;
  SellWebview({super.key, required this.url});

  @override
  State<SellWebview> createState() => _SellWebviewState();
}

class _SellWebviewState extends State<SellWebview> {
  late final WebViewController _controller;
  final userMnemonic userAssetMnemonic = userMnemonic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leading: IconButton(
              onPressed: () async {
                var userPersonalPhrase =
                    await userAssetMnemonic.getAssetsData();
                Get.to(NavBar(mnemonic: userPersonalPhrase));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
              )),
          title: Padding(
            padding: const EdgeInsets.only(left: 110),
            child: Text(
              "Sell",
              style: TextStyle(color: AppColors.brandColor),
            ),
          )),
      body: WebViewWidget(controller: _controller),
    );
  }
}
