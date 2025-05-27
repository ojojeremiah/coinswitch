import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/assets_balance.dart';
import 'package:coinswitch/controller/websocketServices.dart';
import 'package:coinswitch/model/availablecrypto.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'individual_address.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  final AssetBalance assetBalance = Get.put(AssetBalance());
  final AllAvailableAddress allAvailableAddress =
      Get.put(AllAvailableAddress());

  final NumberFormat valueFormatter = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    // allAddressFunction();
    allAvailableAddress;
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      setState(() {
        isLoading = true;
      });
    });
    connectBitcoinWebSocket();
    connectEthereumWebSocket();
    connectSolanaWebSocket();
    connectBnbWebSocket();
    connectLtcWebSocket();
    connectBchWebSocket();
    connectDogeWebSocket();
    connectXrpWebSocket();
  }

  @override
  void dispose() {
    // Ensure that the channels are closed properly
    channel?.sink.close();
    ethereumchannel?.sink.close();
    solanachannel?.sink.close();
    bnbchannel?.sink.close();
    ltcchannel?.sink.close();
    tonchannel?.sink.close();
    bchchannel?.sink.close();
    dogechannel?.sink.close();
    xrpchannel?.sink.close();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  final userAssets = available[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 12, bottom: 14),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => IndividualAdress(cryptoData: userAssets));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              isLoading
                                  ? CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: userAssets.pictures,
                                      // child: ,
                                    )
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    isLoading
                                        ? Text(
                                            userAssets.symbol,
                                            style: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 16),
                                          )
                                        : Shimmer.fromColors(
                                            baseColor: AppColors.cardColor,
                                            highlightColor:
                                                Colors.grey.shade800,
                                            child: Container(
                                              height: 20,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            )),
                                    isLoading
                                        ? Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Obx(
                                                  () => Text(
                                                    '\$${valueFormatter.format(userAssets.priceChange.value)}',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ),
                                              Obx(
                                                () => Text(
                                                  "${userAssets.percentageChange.value.toStringAsFixed(2)}%",
                                                  style: TextStyle(
                                                      color: userAssets
                                                                  .percentageChange
                                                                  .value <=
                                                              0
                                                          ? Colors.red
                                                          : Colors.green,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Shimmer.fromColors(
                                                baseColor: AppColors.cardColor,
                                                highlightColor:
                                                    Colors.grey.shade800,
                                                child: Container(
                                                  height: 20,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .backgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                )),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          isLoading
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => Text(
                                        "${userAssets.balance}",
                                        style: const TextStyle(
                                            color: AppColors.colorGrey,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      "\$ 0.0",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 15),
                                    )
                                  ],
                                )
                              : Shimmer.fromColors(
                                  baseColor: AppColors.cardColor,
                                  highlightColor: Colors.grey.shade800,
                                  child: Container(
                                    height: 40,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                  )),
                        ],
                      ),
                    ),
                  );
                })),
      ],
    );
  }
}
