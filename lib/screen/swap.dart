import 'package:coinswitch/screen/select_crypto_for_swapping.dart';
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
  final TextEditingController _controller =
      TextEditingController(text: available.firstOrNull?.symbol);

  final RxString selectedSymbolToSell = ''.obs;
  final RxString selectedSymbolToBuy = 'ETH'.obs;

  // Show bottom sheet to pick "From" address
  void _showPicker() {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade900,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.77,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: SizedBox(
                    height: 30,
                    child: Text(
                      "Select Address",
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SelectCryptoForSwapping(
                  onSelected: (symbol) {
                    selectedSymbolToSell.value = symbol;
                    _controller.text = symbol;
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Availablecrypto? get selectedCryptoToSell =>
      available.firstWhereOrNull((c) => c.symbol == selectedSymbolToSell.value);

  Availablecrypto? get selectedCryptoToBuy =>
      available.firstWhereOrNull((c) => c.symbol == selectedSymbolToBuy.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Swap',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // FROM (Asset to Sell)
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
                  TextField(
                    controller: _controller,
                    readOnly: true,
                    onTap: _showPicker,
                    decoration: const InputDecoration(
                      // labelText: ,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        // borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final selected = selectedCryptoToSell;
                    return Text(
                      "Available Balance: ${(selected?.balance.value ?? 0.0)}",
                      style: const TextStyle(color: Colors.grey),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TO (Asset to Buy)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("To", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Obx(() => DropdownButton<String>(
                        isExpanded: true,
                        value: selectedSymbolToBuy.value,
                        items: available.map((crypto) {
                          return DropdownMenuItem<String>(
                            value: crypto.symbol,
                            child: Text(crypto.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            selectedSymbolToBuy.value = value;
                          }
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
