import 'package:coinswitch/model/availablecrypto.dart';
import 'package:coinswitch/screen/send_crypto.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Listofavailablecrypto extends StatelessWidget {
  const Listofavailablecrypto({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: available.length,
          itemBuilder: (context, index) {
            final userAsssets = available[index];
            return GestureDetector(
              onTap: () {
                Get.to(SendCrypto(cryptoData: userAsssets));
              },
              child: Padding(
                padding:
                    EdgeInsets.only(top: 5, left: 10, bottom: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6, right: 10),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.transparent,
                            backgroundImage: userAsssets.pictures,
                            // child: userAsssets.pictures,
                          ),
                        ),
                        Text(
                          userAsssets.name,
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 17),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$ 0.0",
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
