import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendCrypto extends StatefulWidget {
  const SendCrypto({super.key});

  @override
  State<SendCrypto> createState() => _SendCryptoState();
}

class _SendCryptoState extends State<SendCrypto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
              )),
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Text(
              "Send",
              style: TextStyle(color: Colors.white),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Column(
          children: [
            Text(
              "Send tokens faster.",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
