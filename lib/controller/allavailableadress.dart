import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/controller/crypto_price_info.dart';
import 'package:coinswitch/controller/user_wallet.dart';
import 'package:coinswitch/service/mnemonic.dart';
import 'package:coinswitch/service/savaAllPublicKey.dart';
import 'package:get/get.dart';

class AllAvailableAddress extends GetxController {
  final AllPublicKey allPublicKey = AllPublicKey();
  final UserWallet userWallet = Get.put(UserWallet());
  final userMnemonic userAssetMnemonic = userMnemonic();
  final AssetController assetController = Get.put(AssetController());
  final CryptoPriceInfo cryptoPriceInfo = Get.put(CryptoPriceInfo());

  var bitcoinPublicKey = ''.obs;
  var ethereumPublicKey = ''.obs;
  var litecoinPublicKey = ''.obs;
  var solanaPublicKey = ''.obs;
  var xrpPublicKey = ''.obs;
  var bitcoincashPublicKey = ''.obs;
  var userwalletPrivateKey = ''.obs;
  var tronPublicKey = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await allAddressFunction();
  }

  Future<void> allAddressFunction() async {
    final walletMnemonic = await userAssetMnemonic.getAssetsData();
    final walletPrivateKey =
        await userWallet.getWalletPrivateKey(walletMnemonic);
    userwalletPrivateKey.value = walletPrivateKey;

    //bitcoinKey
    final bitcoinPublicAddress =
        await userWallet.getBitcoinbaseAddressPublicKey(walletPrivateKey);
    await allPublicKey.setBitcoinAddress(bitcoinPublicAddress);
    cryptoPriceInfo.fetchBitcoinPriceInfo();
    bitcoinPublicKey.value = await allPublicKey.getBitcoinData();
    await assetController.fetchBitcoinBalance(bitcoinPublicKey.value);

    //tronKey
    final tronPublicAddress =
        await userWallet.getTronPublicKey(walletPrivateKey);
    await allPublicKey.settronAddress(tronPublicAddress);
    tronPublicKey.value = await allPublicKey.gettronData();
    await assetController.fetchTronBalance(tronPublicKey.value);

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

    //solanaKey
    final solanaPublicAddress =
        await userWallet.getSolanaPublicKey(walletPrivateKey);
    await allPublicKey.setSolanaAddress("$solanaPublicAddress");
    solanaPublicKey.value = await allPublicKey.getSolanaData();
    await assetController.fetchSolanaBalance(solanaPublicKey.value);

    //polybalance
    await assetController.fetchPolygonBalance(ethereumPublicKey.value);

    // usdttetherbalance
    await assetController.fetchErcUsdtBalance(ethereumPublicKey.value);

    //bnbbalance
    await assetController.fetchBnbBalance(ethereumPublicKey.value);

    //bitcoincashKey
    final bitcoincashPublicKeyAddress =
        await userWallet.getBitcoinCashbaseAddressPublicKey(walletPrivateKey);
    await allPublicKey.setBitcoincashAddress("$bitcoincashPublicKeyAddress");
    bitcoincashPublicKey.value = await allPublicKey.getBitcoincashData();

    // log("============================== bnb balance");

    //xrpkey
    final xrpPublicAddress = await userWallet.getXrpPublicKey(walletPrivateKey);
    await allPublicKey.setBitcoinAddress(xrpPublicAddress);
    xrpPublicKey.value = await allPublicKey.getBitcoinData();
    // await assetController.fetchBitcoinBalance(bitcoinPublicKey.value);
  }
}
