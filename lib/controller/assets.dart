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
  var ethereumBalance = "".obs;
  var polygonBalance = "".obs;
  var usdtercBalance = "".obs;
  var litecoinBalance = 0.obs;
  var bnbBalance = "".obs;
  var solanaBalance = "".obs;
  var tronBalance = 0.obs;
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

  Future fetchTronBalance(String assetAddress) async {
    try {
      var cryptoList = await assetService.fetchBalanceForTron(assetAddress);
      tronBalance.value = cryptoList;
      log("===============================================");
      log("${tronBalance.value}");
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

  Future fetchPolygonBalance(String assetAddressBalance) async {
    try {
      var cryptoList =
          await assetService.fetchBalanceForPolygon(assetAddressBalance);
      polygonBalance.value = cryptoList;
      log("=========================== Polbalance${polygonBalance.value}");
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

  Future fetchErcUsdtBalance(String assetAddressBalance) async {
    try {
      var cryptoList =
          await assetService.fetchBalanceForUsdtTetherErc(assetAddressBalance);
      usdtercBalance.value = cryptoList;
      log("=========================== usdtbalance${usdtercBalance.value}");
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
