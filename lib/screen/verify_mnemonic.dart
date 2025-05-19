import 'package:coinswitch/controller/assetsMnemonic.dart';
import 'package:coinswitch/screen/mnemonic.dart';
import 'package:coinswitch/screen/navbar.dart';
import 'package:coinswitch/service/mnemonic.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyMnemonic extends StatefulWidget {
  const VerifyMnemonic({super.key});

  @override
  State<VerifyMnemonic> createState() => _VerifyMnemonicState();
}

class _VerifyMnemonicState extends State<VerifyMnemonic> {
  final Assetsmnemonic userWallet = Get.put((Assetsmnemonic()));
  final userMnemonic userAssetMnemonic = userMnemonic();
  TextEditingController verifiedText = TextEditingController();
  // String verificationText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.to(() => const WalletMnemonic());
                },
                icon: const Icon(Icons.arrow_back_ios,
                    size: 20, color: AppColors.primaryColor)),
            const Text(
              "Verify Secret Phrase",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text(
                    "Please enter your secret phrase accordingly:",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 100,
                    // margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: verifiedText,
                      maxLines: null,
                      // expands: false,
                      style: TextStyle(color: AppColors.backgroundColor),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Enter secret phrase',
                        filled: true,
                        fillColor: AppColors.primaryColor,
                        hintStyle: TextStyle(color: AppColors.backgroundColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                      width: 250,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                          onPressed: () async {
                            final walletMnemonic =
                                await userAssetMnemonic.getAssetsData();
                            if (verifiedText.text.trim() ==
                                walletMnemonic.trim()) {
                              userWallet.verifyMnemonic(
                                  verifiedText.text.trim(),
                                  walletMnemonic.trim());
                              var userPersonalPhrase =
                                  await userAssetMnemonic.getAssetsData();
                              userWallet.isVerified.value
                                  ? Get.to(() => NavBar(
                                        mnemonic: userPersonalPhrase.trim(),
                                      ))
                                  : ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                      'Verify secret phrase',
                                      style: TextStyle(
                                          color: AppColors.primaryColor),
                                    )));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                'Wrong Secret Phrase',
                                style: TextStyle(color: AppColors.primaryColor),
                              )));
                            }
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: AppColors.brandColor, fontSize: 16),
                          ))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
