import 'dart:developer';
import 'package:coinswitch/model/coins.dart';
import 'package:coinswitch/model/nftcollection.dart';
import 'package:coinswitch/repository/repository.dart';
import 'package:coinswitch/service/all_crypto.dart';
import 'package:coinswitch/service/dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AssetController extends GetxController {
  AssetRepository assetRepository = AssetRepository();
  AssetService assetService = AssetService();
  var isLoading = false.obs;
  var assets = <CryptoData>[].obs;
  var nfts = <NftModel>[].obs;
  var bitcoinBalance = 0.obs;
  var ethereumBalance = 0.obs;
  var dogecoinBalance = 0.obs;
  var litecoinBalance = 0.obs;
  var bnbBalance = "".obs;
  var solanaBalance = "".obs;
  var bitcoincashBalance = 0.obs;
  var fromCrypto = 'BTC'.obs;
  var toCrypto = 'ETH'.obs;
  var amount = ''.obs;
  var estimatedAmount = '0.0'.obs;
  var exchangeRate = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAssets();
    fetchNfts();
  }

  void fetchAssets() async {
    try {
      List<CryptoData> cryptoList = await assetService.fetchAssets();
      assets.value = cryptoList;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }

  Future<void> fetchExchangeRate() async {
    try {
      final data = await assetService.fetchExchangeRate(
          fromCrypto.value.toLowerCase(), toCrypto.value.toLowerCase());
      double fromPrice = data[fromCrypto.value.toLowerCase()]['usd'];
      double toPrice = data[toCrypto.value.toLowerCase()]['usd'];
      exchangeRate.value = fromPrice / toPrice;
      log("================================exchangeRate=======================");
      log('${exchangeRate}');
      updateEstimatedAmount();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch exchange rate',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void updateEstimatedAmount() {
    if (amount.value.isNotEmpty) {
      double inputAmount = double.tryParse(amount.value) ?? 0.0;
      estimatedAmount.value =
          (inputAmount * exchangeRate.value).toStringAsFixed(6);
    }
  }

  void swap() {
    Get.snackbar('Success',
        'Swapped ${amount.value} ${fromCrypto.value} to ${estimatedAmount.value} ${toCrypto.value}',
        snackPosition: SnackPosition.TOP);
  }

  void fetchNfts() async {
    try {
      List<NftModel> cryptoList = await assetService.fetchNfts();
      nfts.value = cryptoList;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }

  Future fetchBitcoinBalance(String assetAddress) async {
    try {
      var cryptoList = await assetService.fetchBalanceForBitcoin(assetAddress);
      bitcoinBalance.value = cryptoList;
      log("===============================================");
      log("${bitcoinBalance.value}");
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }

  Future fetchEthereumBalance(String assetAddressBalance) async {
    try {
      var cryptoList =
          await assetService.fetchBalanceForEthereum(assetAddressBalance);
      ethereumBalance.value = cryptoList;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }

  Future fetchLitecoinBalance(String assetAddressBalance) async {
    try {
      var cryptoList =
          await assetService.fetchBalanceForLitecoin(assetAddressBalance);
      litecoinBalance.value = cryptoList;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }

  Future fetchDogeBalance(String assetAddressBalance) async {
    try {
      var cryptoList =
          await assetService.fetchBalanceForDoge(assetAddressBalance);
      dogecoinBalance.value = cryptoList;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }

  Future fetchBnbBalance(String assetAddressBalance) async {
    try {
      var cryptoList =
          await assetService.fetchBalanceForBnB(assetAddressBalance);
      bnbBalance.value = cryptoList;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }

  Future fetchSolanaBalance(String assetAddressBalance) async {
    try {
      var cryptoList =
          await assetService.fetchBalanceForSolana(assetAddressBalance);
      solanaBalance.value = cryptoList;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Fluttertoast.showToast(
        msg: "Network Connection failed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 14,
      );
      throw errorMessage;
    }
  }
}
