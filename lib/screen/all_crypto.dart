import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/screen/About_crypto.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CryptoData extends StatefulWidget {
  const CryptoData({
    super.key,
  });

  @override
  State<CryptoData> createState() => _CryptoDataState();
}

class _CryptoDataState extends State<CryptoData> {
  final AssetController assetController = Get.put(AssetController());

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final value = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Obx(() => RefreshIndicator(
          color: AppColors.brandColor,
          backgroundColor: AppColors.backgroundColor,
          onRefresh: () async {
            assetController.fetchAssets();
          },
          child: ListView.builder(
              itemCount: assetController.assets.length,
              itemBuilder: (context, index) {
                final crypto = assetController.assets[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => AboutCrypto(cryptoData: crypto));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 16, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              isLoading
                                  ? CircleAvatar(
                                      radius: 25,
                                      backgroundColor: AppColors.cardColor,
                                      backgroundImage:
                                          NetworkImage(crypto.image))
                                  : Shimmer.fromColors(
                                      baseColor: AppColors.cardColor,
                                      highlightColor: Colors.grey.shade800,
                                      child: const CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            AppColors.backgroundColor,
                                      )),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: isLoading
                                    ? Text(
                                        crypto.symbol.toUpperCase(),
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 18),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: AppColors.cardColor,
                                        highlightColor: Colors.grey.shade800,
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: AppColors.backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        )),
                              ),
                            ],
                          ),
                          isLoading
                              ? Container(
                                  height: height * 0.05,
                                  width: width * 0.2,
                                  child: Sparkline(
                                    data: crypto.sparklineIn7D!.price,
                                    lineWidth: 1.0,
                                    lineColor:
                                        crypto.marketCapChangePercentage24H! >=
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                    fillMode: FillMode.below,
                                    fillGradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        // stops: const [0, 0, 7],
                                        colors: [
                                          crypto.marketCapChangePercentage24H! >=
                                                  0
                                              ? Colors.green
                                              : Colors.red,
                                          Colors.transparent
                                        ]),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: AppColors.cardColor,
                                  highlightColor: Colors.grey.shade800,
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                  )),
                          isLoading
                              ? Column(
                                  children: [
                                    Text(
                                      '\$${value.format(crypto.currentPrice)}',
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${crypto.marketCapChangePercentage24H}%',
                                      style: TextStyle(
                                        color:
                                            crypto.marketCapChangePercentage24H! >=
                                                    0
                                                ? Colors.green
                                                : Colors.red,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                )
                              : Shimmer.fromColors(
                                  baseColor: AppColors.cardColor,
                                  highlightColor: Colors.grey.shade800,
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                  )),
                        ],
                      )),
                );
              }),
        ));
  }
}
