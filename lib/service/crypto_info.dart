import 'package:coinswitch/service/dio.dart';
import 'package:coinswitch/service/dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CryptoInfo {
  final DioClient dioClient = DioClient();

  Future BitcoinInfo() async {
    try {
      final response = await dioClient
          .post(dotenv.env['CRYPTO_PRICE_URL_HEAD']!, queryParameters: {
        "tokens": [
          {"identifier": "ETH.ETH"},
          {"identifier": "BTC.BTC"},
          {"identifier": "SOL.SOL"},
        ],
        "metadata": true,
        "x-api-key": dotenv.env['CRYPTO_SWAP_KEY']
      });
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
