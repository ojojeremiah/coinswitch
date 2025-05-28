// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/screen/assets.dart';
import 'package:coinswitch/screen/availableAddress.dart';
import 'package:coinswitch/screen/buy_webview.dart';
import 'package:coinswitch/screen/listofavailablecrypto.dart';
import 'package:coinswitch/screen/sell_webview.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final AssetController assetController = Get.put(AssetController());
  final AllAvailableAddress allAvailableAddress =
      Get.put(AllAvailableAddress());

  @override
  void initState() {
    // allAddressFunction();
    allAvailableAddress;
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      // setState(() {
      //   isLoading = true;
      // });
    });
  }

  bool _confirmVisible = true;

  bool isLoading = false;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  // bitcoinBalance = assetService
                  //     .fetchBalanceForBitcoin(bitcoinPublicKey);
                  // log(bitcoinBalance);
                  showModalBottomSheet(
                      backgroundColor: Colors.grey.shade900,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.77,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    height: 30,
                                    child: Text(
                                      "Your Avalaible Address",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Availableaddress()
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.copy,
                  size: 20,
                  color: Colors.grey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.qr_code_rounded,
                  size: 30,
                  color: Colors.grey,
                ))
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: height / 50, left: width / 50, right: width / 50),
            child: Stack(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '\$ 0.00',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.sizeOf(context).width * 0.68,
                        top: MediaQuery.sizeOf(context).width / 15),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _confirmVisible = !_confirmVisible;
                        });
                      },
                      child: Icon(
                        size: 20,
                        _confirmVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.colorGrey,
                      ),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.grey.shade900,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (BuildContext context) {
                          return FractionallySizedBox(
                            heightFactor: 0.77,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 30,
                                      child: Text(
                                        "Select a Token",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Listofavailablecrypto()
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.cardColor,
                          child: Icon(
                            Icons.arrow_outward_rounded,
                            size: 23,
                            color: AppColors.brandColor,
                          ),
                        ),
                        Text('Send',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.primaryColor))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => RampFlutter());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.cardColor,
                          child: Icon(Icons.arrow_downward_rounded,
                              size: 23, color: AppColors.brandColor),
                        ),
                        Text(
                          'Receive',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.to(BuyWebview(
                        url:
                            "https://buy-sandbox.moonpay.com/?apiKey=pk_test_A449RZ04il34rN1ckMVpEuSbS29EiaCa&theme=dark"));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.cardColor,
                          child: Icon(
                            Icons.add,
                            color: AppColors.brandColor,
                            size: 23,
                          ),
                        ),
                        Text('Buy',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.primaryColor))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.to(SellWebview(
                        url:
                            "https://sell-sandbox.moonpay.com/?apiKey=pk_test_A449RZ04il34rN1ckMVpEuSbS29EiaCa&theme=dark"));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.cardColor,
                          child: Icon(
                            Icons.remove,
                            color: AppColors.brandColor,
                            size: 23,
                          ),
                        ),
                        Text('Sell',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.primaryColor))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          TabBar(
              dividerColor: Colors.transparent,
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: AppColors.colorGrey,
              labelColor: Colors.white,
              indicatorColor: AppColors.brandColor,
              labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              tabs: const [
                Tab(text: 'Assets'),
                Tab(text: 'NFTs'),
              ]),
          Expanded(
            // flex: 30,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Assets(),
                Text(
                  "Hello",
                  style: TextStyle(color: AppColors.primaryColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
