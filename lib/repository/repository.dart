import 'package:coinswitch/service/all_crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../service/dio_exception.dart';

class AssetRepository {
  final AssetService assetService = AssetService();

  Future<void> fetchAssets() async {
    try {
      await assetService.fetchAssets();
      // if (response.statusCode == 200) {
      //   return;
      // }
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
