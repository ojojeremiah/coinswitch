import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/screen/NFTs.dart';
import 'package:coinswitch/screen/popular_assets.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'all_crypto.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  final AssetController assetController = Get.put(AssetController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      // setState(() {
      //   isLoading = true;
      // });
    });
  }

  int current = 0;
  List<Widget> screens = [
    const Expanded(child: PopularAssets()),
    const Expanded(child: CryptoData()),
    Expanded(child: NTFs())
  ];
  // bool isLoading = false;
  Widget currentPage = const CryptoData();

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    // var weight = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Market",
            style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 85,
                    height: 40,
                    decoration: BoxDecoration(
                        color: current == 0
                            ? AppColors.brandColor
                            : Color(0xFF3F3F3F),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            current = 0;
                          });
                        },
                        child: Text(
                          "Popular",
                          style: TextStyle(
                            color: current == 0
                                ? AppColors.primaryColor
                                : AppColors.primaryColor,
                          ),
                        ))),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        color: current == 1
                            ? AppColors.brandColor
                            : Color(0xFF3F3F3F),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            current = 1;
                          });
                        },
                        child: Text(
                          "Cryptos",
                          style: TextStyle(
                            color: current == 1
                                ? AppColors.primaryColor
                                : AppColors.primaryColor,
                          ),
                        ))),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        color: current == 2
                            ? AppColors.brandColor
                            : Color(0xFF3F3F3F),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            current = 2;
                          });
                        },
                        child: Text(
                          "NFTs",
                          style: TextStyle(
                            color: current == 2
                                ? AppColors.primaryColor
                                : AppColors.primaryColor,
                          ),
                        ))),
              ],
            ),
          ),
          screens.elementAt(current)
        ],
      ),
    );
  }
}
