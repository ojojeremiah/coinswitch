import 'package:flutter/material.dart';
import '../controller/assets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/theme/app_colors.dart';

class ShimmerAllCrypto extends StatefulWidget {
  const ShimmerAllCrypto({super.key});

  // final AssetController assetController;

  @override
  State<ShimmerAllCrypto> createState() => _ShimmerAllCryptoState();
}

class _ShimmerAllCryptoState extends State<ShimmerAllCrypto> {
  final AssetController assetController = Get.put(AssetController());

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: assetController.assets.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Shimmer.fromColors(
                    baseColor: AppColors.cardColor,
                    highlightColor: AppColors.backgroundColor,
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.cardColor,
                    )),
                Shimmer.fromColors(
                    baseColor: AppColors.cardColor,
                    highlightColor: AppColors.backgroundColor,
                    child: Container(
                        height: 30, width: 50, color: AppColors.cardColor)),
                Shimmer.fromColors(
                    baseColor: AppColors.cardColor,
                    highlightColor: AppColors.backgroundColor,
                    child: Container(
                        height: 30, width: 90, color: AppColors.cardColor)),
                Shimmer.fromColors(
                    baseColor: AppColors.cardColor,
                    highlightColor: AppColors.backgroundColor,
                    child: Container(
                        height: 30, width: 90, color: AppColors.cardColor)),
              ],
            );
          }),
    );
  }
}
