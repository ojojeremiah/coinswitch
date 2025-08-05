import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';

class ReceiveScreen extends StatefulWidget {
  final dynamic walletAddress;
  final dynamic cryptoName;

  const ReceiveScreen({super.key, this.walletAddress, this.cryptoName});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

void copyToClipboard(BuildContext context, String walletAddress) {
  Clipboard.setData(ClipboardData(text: walletAddress));

  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.TOP,
    maxWidth: 200,
    padding: EdgeInsets.only(left: 10, top: 20),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    icon: Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 6),
      child: Image.asset(
        'assets/images/checker.png',
        height: 24,
        width: 24,
      ),
    ),
    titleText: Container(
      height: 20,
      child: Text(
        'Address copied...',
        style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor), // Set your desired font size here
      ),
    ),
  );
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              "${widget.cryptoName}",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: QrImageView(
                backgroundColor: AppColors.brandColor,
                data: widget.walletAddress,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.walletAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.brandColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () => copyToClipboard(context, widget.walletAddress),
                child: const Text(
                  "Copy Address",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
