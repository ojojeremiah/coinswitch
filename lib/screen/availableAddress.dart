import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/availablecrypto.dart';

class Availableaddress extends StatefulWidget {
  const Availableaddress({super.key});

  @override
  State<Availableaddress> createState() => _AvailableaddressState();
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

class _AvailableaddressState extends State<Availableaddress> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: available.length,
          itemBuilder: (context, index) {
            final userAsssets = available[index];
            return Padding(
              padding: EdgeInsets.only(top: 5, left: 10),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: IconButton(
                            onPressed: () {
                              copyToClipboard(context, index, available);
                            },
                            icon: Icon(
                              Icons.copy,
                              size: 20,
                              color: Colors.grey[400],
                            )),
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
