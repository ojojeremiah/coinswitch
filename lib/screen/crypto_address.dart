import 'package:flutter/material.dart';

import '../controller/assets.dart';
import '../utils/theme/app_colors.dart';


class CryptoAddress extends StatelessWidget {
  const CryptoAddress({
    super.key,
    required this.assetController,
  });

  final AssetController assetController;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    return Container(
        height: height /1.74,
      child: ListView.builder(
          itemCount: assetController.assets.length,
          itemBuilder: (context, index){
            final crypto = assetController.assets[index];
        return GestureDetector(
          onTap: (){},
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 15, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.cardColor,
                        backgroundImage: NetworkImage(crypto.image!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          crypto.symbol.toUpperCase(),
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${crypto.currentPrice}',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
        );
      }),
    );
  }
}
