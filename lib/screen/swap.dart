import 'package:coinswitch/controller/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme/app_colors.dart';

class SwapAsset extends StatefulWidget {
  const SwapAsset({super.key});

  @override
  State<SwapAsset> createState() => _SwapAssetState();
}

class _SwapAssetState extends State<SwapAsset> {
  final AssetController assetController = Get.put(AssetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundColor,
          title: Center(
              child: Text(
            'Swap',
            style: TextStyle(color: AppColors.primaryColor),
          ))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => DropdownButton<String>(
                  value: assetController.fromCrypto.value,
                  items: ['BTC', 'ETH', 'SOL'].map((crypto) {
                    return DropdownMenuItem(value: crypto, child: Text(crypto));
                  }).toList(),
                  onChanged: (value) {
                    assetController.fromCrypto.value = value!;
                    assetController.fetchExchangeRate();
                  },
                )),
            TextField(
              onChanged: (value) {
                assetController.amount.value = value;
                assetController.updateEstimatedAmount();
              },
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            Obx(() => DropdownButton<String>(
                  value: assetController.toCrypto.value,
                  items: ['BTC', 'ETH', 'SOL'].map((crypto) {
                    return DropdownMenuItem(value: crypto, child: Text(crypto));
                  }).toList(),
                  onChanged: (value) {
                    assetController.toCrypto.value = value!;
                    assetController.fetchExchangeRate();
                  },
                )),
            Obx(() => Text(
                  'Estimated: ${assetController.estimatedAmount.value} ${assetController.toCrypto.value}',
                  style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: assetController.swap,
              child: Text('Swap'),
            ),
          ],
        ),
      ),
    );
  }
}
