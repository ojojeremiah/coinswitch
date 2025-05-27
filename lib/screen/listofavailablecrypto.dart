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
                Get.to(SendCrypto());
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5, left: 10, bottom: 10),
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
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 25,
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
                            ],
                          ),
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
