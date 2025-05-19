import 'package:coinswitch/controller/assetsMnemonic.dart';
import 'package:coinswitch/screen/verify_mnemonic.dart';
import 'package:coinswitch/service/mnemonic.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletMnemonic extends StatefulWidget {
  const WalletMnemonic({super.key});

  @override
  State<WalletMnemonic> createState() => _WalletMnemonicState();
}

final Assetsmnemonic userWallet = Get.put((Assetsmnemonic()));
final userMnemonic userAssetMnemonic = userMnemonic();
final walletMnemonic = userAssetMnemonic.generateMnemonic();
final userRealMnemonic = walletMnemonic.split(' ');

void copyToClipboard() {
  Clipboard.setData(ClipboardData(text: walletMnemonic));
}

class _WalletMnemonicState extends State<WalletMnemonic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundColor,
          title: const Center(
              child: Text(
            "Secret Phrase",
            style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
          )),
          elevation: 0,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Please store these secret phrase safely: ",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GridView.count(
                childAspectRatio: (1 / 0.3),
                padding: const EdgeInsets.all(0),
                crossAxisSpacing: 6,
                mainAxisSpacing: 1,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                    userRealMnemonic.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 2,
                            right: 2,
                          ),
                          child: Container(
                            // height: 15,
                            // margin: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                ' ${index + 1}. ${userRealMnemonic[index]}',
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: 200,
                  decoration: BoxDecoration(
                      color: AppColors.brandColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton.icon(
                      onPressed: () {
                        copyToClipboard();
                        Get.snackbar('Success', 'Copied to Clipboard',
                            snackPosition: SnackPosition.BOTTOM);
                      },
                      label: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.copy,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          Text(
                            "Copy to Clipboard",
                            style: TextStyle(color: AppColors.primaryColor),
                          )
                        ],
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 170,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () async {
                          await userAssetMnemonic
                              .seAssettMnemonic(walletMnemonic);
                          var userPersonalPhrase =
                              await userAssetMnemonic.getAssetsData();
                          print("===================================");
                          print(userPersonalPhrase);
                          Get.to(() => const VerifyMnemonic());
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(color: AppColors.brandColor),
                        ))),
              ],
            )
          ]),
        ));
  }
}
