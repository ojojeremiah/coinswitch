import 'dart:developer';
import 'package:coinswitch/model/coins.dart';
import 'package:coinswitch/model/nftcollection.dart';
import 'package:coinswitch/service/dio.dart';
import 'package:coinswitch/service/dio_exception.dart';
import 'package:coinswitch/service/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<CryptoData> assets = [];
List<NftModel> nfts = [];

class AssetService {
  final DioClient dioClient = DioClient();

  Future<List<CryptoData>> fetchAssets() async {
    try {
      final response = await dioClient.get(
        Endpoints.allProducts,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CryptoData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future fetchBalanceForBitcoin(String assetAddress) async {
    try {
      final response = await dioClient.get(
        Endpoints.assetBalanceHead +
            Endpoints.assetBalanceNetworkforBitcoin +
            Endpoints.assetBalanceMiddle +
            assetAddress +
            Endpoints.assetBalanceTail,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final int assets = data['final_balance'];
        // log("$assets");
        return assets;
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future fetchBalanceForEthereum(String assetAddressBalance) async {
    try {
      final response = await dioClient.get(
        Endpoints.assetBalanceHead +
            Endpoints.assetBalanceNetworkforEthereum +
            Endpoints.assetBalanceMiddle +
            assetAddressBalance +
            Endpoints.assetBalanceTail,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final int assets = data['final_balance'];
        // log("$assets");
        return assets;
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future fetchBalanceForLitecoin(String assetAddressBalance) async {
    try {
      final response = await dioClient.get(
        Endpoints.assetBalanceHead +
            Endpoints.assetBalanceNetworkforLitecoin +
            Endpoints.assetBalanceMiddle +
            assetAddressBalance +
            Endpoints.assetBalanceTail,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final int assets = data['final_balance'];
        // log("$assets");
        return assets;
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future fetchBalanceForDoge(String assetAddressBalance) async {
    try {
      final response = await dioClient.get(
        Endpoints.assetBalanceHead +
            Endpoints.assetBalanceNetworkForDoge +
            Endpoints.assetBalanceMiddle +
            assetAddressBalance +
            Endpoints.assetBalanceTail,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final int assets = data['final_balance'];
        // log("$assets");
        return assets;
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future fetchBalanceForBnB(String assetAddress) async {
    try {
      final response =
          await dioClient.get(Endpoints.bscapisac, queryParameters: {
        "module": "account",
        "action": "balance",
        "address": assetAddress,
        "apikey": Endpoints.bnbAPIKey
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final String assets = data['result'];
        log("====================== bnb adress");
        log(assets);
        return assets;
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future fetchBalanceForSolana(String assetAddress) async {
    try {
      final response = await dioClient.get(
          Endpoints.solanaBalance + assetAddress + Endpoints.solanaBalanceTail,
          options: Options(headers: {
            "accept": "application/json",
            "X-API-Key": Endpoints.solanaAPIKey
          }));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final String assets = data["nativeBalance"]["solana"];
        log("====================== solana adress");
        log(assets);
        return assets;
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future<List<NftModel>> fetchNfts() async {
    try {
      final response = await dioClient.get(
        Endpoints.allNfts,
        options: Options(headers: {
          "accept": "application/json",
          "x-api-key": Endpoints.openseakey
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        // Assuming the list of NFTs is under the key 'nfts'
        final List<dynamic> nftList = data['collections'];
        return nftList.map((json) => NftModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load assets');
      }
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

  Future fetchExchangeRate(dynamic fromCrypto, dynamic toCrypto) async {
    try {
      final response = await dioClient.get(Endpoints.exchangeRatehead +
          fromCrypto +
          ',' +
          toCrypto +
          Endpoints.exchangeRatetail);
      if (response.statusCode == 200) {
        response.data;
      }
    } catch (e) {
      throw Exception('Failed to fetch exchange rate');
    }
  }
}
