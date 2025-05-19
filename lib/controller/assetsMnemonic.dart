import 'package:coinswitch/service/mnemonic.dart';
import 'package:get/get.dart';

class Assetsmnemonic extends GetxController {
  final userMnemonic userAssetMnemonic = userMnemonic();
  var userWalletMnemonic = "".obs;
  RxBool isVerified = false.obs;

  // String fetchMnemonic() {
  //   // String mnemonicValue = userAssetMnemonic.getAssetsData();
  //   return userWalletMnemonic.value = mnemonicValue;
  // }

  void verifyMnemonic(String verfiedText, String mnemonic) {
    if (verfiedText == mnemonic) {
      isVerified = true.obs;
    }
  }
}
