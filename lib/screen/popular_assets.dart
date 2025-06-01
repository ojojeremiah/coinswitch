import 'package:coinswitch/controller/websocketServices.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PopularAssets extends StatefulWidget {
  const PopularAssets({super.key});

  @override
  State<PopularAssets> createState() => _PopularAssetsState();
}

class _PopularAssetsState extends State<PopularAssets> {
  final WebSocketController wsController = Get.put(WebSocketController());
  final NumberFormat valueFormatter = NumberFormat("#,##0.00", "en_US");

  String formatNumber(double num) {
    if (num >= 1e9) return '${(num / 1e9).toStringAsFixed(1)}B';
    if (num >= 1e6) return '${(num / 1e6).toStringAsFixed(1)}M';
    if (num >= 1e3) return '${(num / 1e3).toStringAsFixed(1)}K';
    return num.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final symbols = wsController.priceChanges.keys.toList();

      // Show "No data" if no symbols or data is still loading
      if (symbols.isEmpty ||
          wsController.priceChanges.values.every((e) => e.value == 0.0)) {
        return const Center(
          child: Text("No data", style: TextStyle(color: AppColors.colorGrey)),
        );
      }

      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name / Vol",
                      style:
                          TextStyle(color: AppColors.colorGrey, fontSize: 16)),
                  Text("Last Price",
                      style:
                          TextStyle(color: AppColors.colorGrey, fontSize: 16)),
                  Text("24h chg%",
                      style:
                          TextStyle(color: AppColors.colorGrey, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: symbols.length,
                itemBuilder: (context, index) {
                  final symbol = symbols[index];
                  final price = wsController.priceChanges[symbol]!.value;
                  final percent = wsController.percentageChanges[symbol]!.value;
                  final volume = wsController.volumeTraded[symbol]!.value;
                  final baseSymbol = symbol.split('-').first;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name & Volume
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              baseSymbol,
                              style: const TextStyle(
                                  color: AppColors.primaryColor, fontSize: 15),
                            ),
                            Text(
                              '\$${formatNumber(volume)}',
                              style: const TextStyle(
                                  color: AppColors.colorGrey, fontSize: 14.5),
                            ),
                          ],
                        ),

                        // Last Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              valueFormatter.format(price),
                              style: const TextStyle(
                                  color: AppColors.primaryColor, fontSize: 15),
                            ),
                            Text(
                              '\$${valueFormatter.format(price)}',
                              style: const TextStyle(
                                  color: AppColors.colorGrey, fontSize: 14),
                            ),
                          ],
                        ),

                        // % Change
                        Container(
                          height: 36,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: percent == 0
                                ? Colors.grey
                                : percent > 0
                                    ? Colors.green
                                    : Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              "${percent.toStringAsFixed(2)}%",
                              style: const TextStyle(
                                  color: AppColors.primaryColor, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
