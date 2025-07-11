import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/availablecrypto.dart';
import '../utils/theme/app_colors.dart';

class SwapAsset extends StatefulWidget {
  const SwapAsset({super.key});

  @override
  State<SwapAsset> createState() => _SwapAssetState();
}

class _SwapAssetState extends State<SwapAsset> {
  final RxString selectedSymbol = 'BTC'.obs;

  Availablecrypto? get selectedCrypto =>
      available.firstWhereOrNull((c) => c.symbol == selectedSymbol.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Swap',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("From", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Obx(() => DropdownButton<String>(
                        isExpanded: true,
                        value: selectedSymbol.value,
                        items: available.map((crypto) {
                          return DropdownMenuItem<String>(
                            value: crypto.symbol,
                            child: Text(crypto.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            selectedSymbol.value = value;
                          }
                        },
                      )),
                  const SizedBox(height: 10),
                  Obx(() {
                    final selected = selectedCrypto;
                    return Text(
                      "Available Balance: ${(selected?.balance.value ?? 0.0)}",
                      style: const TextStyle(color: Colors.grey),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
