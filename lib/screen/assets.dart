import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/assets_balance.dart';
import 'package:coinswitch/model/availablecrypto.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  final AssetBalance assetBalance = Get.put(AssetBalance());
  final AllAvailableAddress allAvailableAddress =
      Get.put(AllAvailableAddress());

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
                  final userAsssets = available[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 12, bottom: 14),
                    child: GestureDetector(
                      onTap: () {
                        // AllAddressBalance();
                        // Get.to(() => IndividualAdress(cryptoData: crypto));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              isLoading
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: userAsssets.pictures,
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
                                            userAsssets.name,
                                            style: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 15),
                                          )
                                        : Shimmer.fromColors(
                                            baseColor: AppColors.cardColor,
                                            highlightColor:
                                                Colors.grey.shade800,
                                            child: Container(
                                              height: 30,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            )),
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
                                        "${userAsssets.balance}",
                                        style: const TextStyle(
                                            color: AppColors.colorGrey,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      "\$ 0.0",
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 13),
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
        // TextButton(
        //     onPressed: () {
        //       Get.to(() => const ManageAssets());
        //     },
        //     child: const Text(
        //       "Manage Assets",
        //       style: TextStyle(color: AppColors.brandColor, fontSize: 15),
        //     ))
      ],
    );
  }
}
