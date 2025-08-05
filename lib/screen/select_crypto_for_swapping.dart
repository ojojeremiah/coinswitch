import 'package:coinswitch/model/availablecrypto.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SelectCryptoForSwapping extends StatelessWidget {
  void Function(String symbol) onSelected;

  SelectCryptoForSwapping({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: available.length,
        itemBuilder: (context, index) {
          final userAsset = available[index];
          return Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: GestureDetector(
              onTap: () {
                onSelected(userAsset.symbol);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.transparent,
                        backgroundImage: userAsset.pictures,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userAsset.symbol,
                              style: TextStyle(
                                  color: AppColors.primaryColor, fontSize: 17),
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
        },
      ),
    );
  }
}
