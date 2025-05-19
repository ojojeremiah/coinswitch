// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/availablecrypto.dart';

class Availableaddress extends StatefulWidget {
  const Availableaddress({super.key});

  @override
  State<Availableaddress> createState() => _AvailableaddressState();
}

void copyToClipboard() {
  // Clipboard.setData(ClipboardData(text: bitcoinPublicKey));
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
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.cardColor,
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
                                  userAsssets.name,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 17),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 27,
                                  decoration: BoxDecoration(
                                      color: AppColors.cardColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      userAsssets.format,
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                )
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
                            onPressed: () {},
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
