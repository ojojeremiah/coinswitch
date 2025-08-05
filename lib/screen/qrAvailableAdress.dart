import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/screen/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../model/availablecrypto.dart';

class Qravailableadress extends StatefulWidget {
  const Qravailableadress({super.key});

  @override
  State<Qravailableadress> createState() => _QravailableadressState();
}

void copyToClipboard(BuildContext context, int index, List available) {
  final address = available[index].address.value;
  Clipboard.setData(ClipboardData(text: address));
  Get.snackbar(
    '',
    '',
    snackPosition: SnackPosition.TOP,
    maxWidth: 200,
    padding: EdgeInsets.only(left: 10, top: 20),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    icon: Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 6),
      child: Image.asset(
        'assets/images/checker.png',
        height: 24,
        width: 24,
      ),
    ),
    titleText: Container(
      height: 20,
      child: Text(
        'Address copied...',
        style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor), // Set your desired font size here
      ),
    ),
  );
}

final AllAvailableAddress allAvailableAddress = Get.put(AllAvailableAddress());

class _QravailableadressState extends State<Qravailableadress> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: available.length,
          itemBuilder: (context, index) {
            final userAsssets = available[index];
            return Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.transparent,
                        backgroundImage: userAsssets.pictures,
                        // child: userAsssets.pictures,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userAsssets.symbol,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 150,
                              child: Obx(
                                () => Text(
                                  overflow: TextOverflow.ellipsis,
                                  userAsssets.address.value,
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 45.sp),
                            child: IconButton(
                                onPressed: () {
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    height: 30,
                                                    child: Text(
                                                      "Receive Crypto",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                ReceiveScreen(
                                                  walletAddress:
                                                      userAsssets.address.value,
                                                  cryptoName: userAsssets.name,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.qr_code_2,
                                  size: 20,
                                  color: Colors.grey[400],
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                copyToClipboard(context, index, available);
                              },
                              icon: Icon(
                                Icons.copy,
                                size: 20,
                                color: Colors.grey[400],
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
