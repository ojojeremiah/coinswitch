import 'dart:developer';

import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:coinswitch/service/send_eth.dart';
import 'package:get/get.dart';

class SendCrypto extends StatefulWidget {
  final dynamic cryptoData;

  const SendCrypto({super.key, required this.cryptoData});

  @override
  State<SendCrypto> createState() => _SendCryptoState();
}

class _SendCryptoState extends State<SendCrypto> {
  final TextEditingController reciverAdress = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ethService = EthereumService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
        ),
        title:
            const Text("Send", style: TextStyle(color: AppColors.primaryColor)),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Send ${widget.cryptoData.name} in a faster and more secure way.",
                style: TextStyle(color: AppColors.primaryColor),
              ),
              const SizedBox(height: 25),
              Text(
                "Send To:",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  TextFormField(
                    controller: reciverAdress,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Address Required" : null,
                    style: const TextStyle(
                        height: 1.5,
                        wordSpacing: 2,
                        color: AppColors.primaryColor),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 16),
                      hintText: 'Enter or scan wallet address',
                      filled: true,
                      fillColor: AppColors.cardColor,
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: GestureDetector(
                      onTap: () {
                        // Add QR scan logic
                      },
                      child: Icon(Icons.qr_code_rounded,
                          color: AppColors.brandColor, size: 28),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Text(
                "Amount:",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: amount,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) =>
                    v == null || v.isEmpty ? "Amount Required" : null,
                style: const TextStyle(
                    height: 1.5, wordSpacing: 2, color: AppColors.primaryColor),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                  hintText: '${widget.cryptoData.symbol} 0.00',
                  filled: true,
                  fillColor: AppColors.cardColor,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.brandColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final input = amount.text;
                          final receiver = reciverAdress.text.trim();

                          dynamic amountValue;

                          if (double.tryParse(input) != null) {
                            // For decimal input (e.g., 0.5, 1.25), return as double
                            amountValue = double.parse(input);
                          } else if (BigInt.tryParse(input) != null) {
                            // For integer input, treat it as BigInt
                            amountValue = BigInt.parse(input);
                          } else {
                            throw Exception("Invalid amount format");
                          }

                          await widget.cryptoData
                              .sendFunc(receiver, amountValue);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Invalid amount: ${e.toString()}')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill required fields')),
                        );
                      }
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
