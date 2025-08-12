import 'package:coinswitch/model/coins.dart';
import 'package:coinswitch/service/all_crypto.dart';
import 'package:get/get.dart';

class CryptoPriceInfo extends GetxController {
  AssetService assetService = AssetService();

  var bitcoinCurrentPrice = 0.0.obs;
  var bitcoinPriceChangePercentage24H = 0.0.obs;

  var ethereumCurrentPrice = 0.0.obs;
  var ethereumPriceChangePercentage24H = 0.0.obs;

  var polygonCurrentPrice = 0.0.obs;
  var polygonPriceChangePercentage24H = 0.0.obs;

  var bnbCurrentPrice = 0.0.obs;
  var bnbPriceChangePercentage24H = 0.0.obs;

  var solanaCurrentPrice = 0.0.obs;
  var solanaPriceChangePercentage24H = 0.0.obs;

  var tronCurrentPrice = 0.0.obs;
  var tronPriceChangePercentage24H = 0.0.obs;

  var etherusdtCurrentPrice = 0.0.obs;
  var etherusdtPriceChangePercentage24H = 0.0.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    fetchBitcoinPriceInfo();
    fetchBnbPriceInfo();
    fetchEtherUsdtPriceInfo();
    fetchEthereumPriceInfo();
    fetchPolygonPriceInfo();
    fetchSolanaPriceInfo();
    fetchTronPriceInfo();
  }

  void fetchBitcoinPriceInfo() async {
    List<CryptoData> cryptoList = await assetService.fetchAssets();
    final bitcoin = cryptoList.firstWhere((coin) => coin.id == 'bitcoin');
    bitcoinCurrentPrice.value = bitcoin.currentPrice;
    bitcoinPriceChangePercentage24H.value = bitcoin.priceChangePercentage24H;
  }

  void fetchEthereumPriceInfo() async {
    List<CryptoData> cryptoList = await assetService.fetchAssets();
    final ethereum = cryptoList.firstWhere((coin) => coin.id == 'ethereum');
    ethereumCurrentPrice.value = ethereum.currentPrice;
    ethereumPriceChangePercentage24H.value = ethereum.priceChangePercentage24H;
  }

  void fetchSolanaPriceInfo() async {
    List<CryptoData> cryptoList = await assetService.fetchAssets();
    final solana = cryptoList.firstWhere((coin) => coin.id == 'solana');
    solanaCurrentPrice.value = solana.currentPrice;
    solanaPriceChangePercentage24H.value = solana.priceChangePercentage24H;
  }

  void fetchBnbPriceInfo() async {
    List<CryptoData> cryptoList = await assetService.fetchAssets();
    final bnb = cryptoList.firstWhere((coin) => coin.id == 'binancecoin');
    bnbCurrentPrice.value = bnb.currentPrice;
    bnbPriceChangePercentage24H.value = bnb.priceChangePercentage24H;
  }

  void fetchTronPriceInfo() async {
    List<CryptoData> cryptoList = await assetService.fetchAssets();
    final trx = cryptoList.firstWhere((coin) => coin.id == 'tron');
    tronCurrentPrice.value = trx.currentPrice;
    tronPriceChangePercentage24H.value = trx.priceChangePercentage24H;
  }

  void fetchPolygonPriceInfo() async {
    List<CryptoData> cryptoList = await assetService.fetchAssets();
    final pol = cryptoList.firstWhere((coin) => coin.id == 'polygon');
    polygonCurrentPrice.value = pol.currentPrice;
    polygonPriceChangePercentage24H.value = pol.priceChangePercentage24H;
  }

  void fetchEtherUsdtPriceInfo() async {
    List<CryptoData> cryptoList = await assetService.fetchAssets();
    final tether = cryptoList.firstWhere((coin) => coin.id == 'tether');
    etherusdtCurrentPrice.value = tether.currentPrice;
    etherusdtPriceChangePercentage24H.value = tether.priceChangePercentage24H;
  }
}
