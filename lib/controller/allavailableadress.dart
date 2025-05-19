import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/controller/user_wallet.dart';
import 'package:coinswitch/service/mnemonic.dart';
import 'package:coinswitch/service/savaAllPublicKey.dart';
import 'package:get/get.dart';

class AllAvailableAddress extends GetxController {
  final AllPublicKey allPublicKey = AllPublicKey();
  final UserWallet userWallet = Get.put(UserWallet());
  final userMnemonic userAssetMnemonic = userMnemonic();
  final AssetController assetController = Get.put(AssetController());

  var bitcoinPublicKey = 'Fetching...'.obs;
  var ethereumPublicKey = 'Fetching...'.obs;
  var litecoinPublicKey = 'Fetching...'.obs;
  var dogecoinPublicKey = 'Fetching...'.obs;
  var solanaPublicKey = 'Fetching...'.obs;
  var bitcoincashPublicKey = 'Fetching...'.obs;
  var userwalletPrivateKey = 'Fetching...'.obs;

  @override
  void onInit() {
    allAddressFunction();
    super.onInit();
  }

  void allAddressFunction() async {
    final walletMnemonic = await userAssetMnemonic.getAssetsData();
    final walletPrivateKey =
        await userWallet.getWalletPrivateKey(walletMnemonic);
    userwalletPrivateKey.value = walletPrivateKey;

    //bitcoinKey
    final bitcoinPublicAddress =
        await userWallet.getBitcoinbaseAddressPublicKey(walletPrivateKey);
    await allPublicKey.setBitcoinAddress(bitcoinPublicAddress);
    bitcoinPublicKey.value = await allPublicKey.getBitcoinData();
    await assetController.fetchBitcoinBalance(bitcoinPublicKey.value);

    //ethereumkey
    final ethereumPublicAddress =
        await userWallet.getEthereumPublicKey(walletPrivateKey);
    await allPublicKey.setEthereumAddress("$ethereumPublicAddress");
    ethereumPublicKey.value = await allPublicKey.getEthereumData();
    await assetController.fetchEthereumBalance(ethereumPublicKey.value);

    //litecoinKey
    final litecoinPublicAddress =
        await userWallet.getLitecoinbaseAddressPublicKey(walletPrivateKey);
    await allPublicKey.setLitecoinAddress(litecoinPublicAddress);
    litecoinPublicKey.value = await allPublicKey.getLitecoinData();
    await assetController.fetchLitecoinBalance(litecoinPublicKey.value);

    //dogecoinKey
    final dogecoinPublicAddress =
        await userWallet.getDogecoinbaseAddressPublicKey(walletPrivateKey);
    await allPublicKey.setDogeAddress(dogecoinPublicAddress);
    dogecoinPublicKey.value = await allPublicKey.getDogeData();
    await assetController.fetchDogeBalance(dogecoinPublicKey.value);

    //bnbkey
    await assetController.fetchBnbBalance(ethereumPublicKey.value);

    //solanaKey
    final solanaPublicAddress =
        await userWallet.getSolanaPublicKey(walletPrivateKey);
    await allPublicKey.setSolanaAddress("$solanaPublicAddress");
    solanaPublicKey.value = await allPublicKey.getSolanaData();
    await assetController.fetchSolanaBalance(solanaPublicKey.value);

    //bitcoincashKey
    final bitcoincashPublicKeyAddress =
        await userWallet.getBitcoinCashbaseAddressPublicKey(walletPrivateKey);
    await allPublicKey.setBitcoincashAddress("$bitcoincashPublicKeyAddress");
    bitcoincashPublicKey.value = await allPublicKey.getBitcoincashData();

    // log("============================== bnb balance");
  }
}
