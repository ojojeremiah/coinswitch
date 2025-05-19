import 'package:coinswitch/model/availablecrypto.dart';
import 'package:coinswitch/service/user_asset_balance.dart';
import 'package:get/get.dart';

class AssetBalance extends GetxController {
  final UserAssetBalance assetsService = UserAssetBalance();
  var assets = <Availablecrypto>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssets();
  }

  Future<void> fetchAssets() async {
    List<Availablecrypto> assetsList = await assetsService.getAssetsData();
    assets.value = assetsList;
  }

  Future<void> updateAssets(Availablecrypto assets) async {
    List<Availablecrypto> assetsList = await assetsService.getAssetsData();
    bool assetsExists =
        assetsList.where((e) => e.name == assets.name).toList().isNotEmpty;
    if (assetsExists) {
      null;
    } else {
      await assetsService.updateAsset(assetsList);
      await assetsService.addAsset(assets);
      await assetsService.getAssetsData();
      await fetchAssets();
    }
    await fetchAssets();
  }

  Future<void> removeAsset(Availablecrypto assets) async {
    // List<Availablecrypto> assetsList = await assetsService.getAssetsData();
    // await assetsService.updateAsset(assetsList);
    await assetsService.removeAsset(assets);
    await assetsService.getAssetsData();
    await fetchAssets();
  }
}
