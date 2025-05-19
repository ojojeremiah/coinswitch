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
  final NumberFormat valueFormatter = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    connectBitcoinWebSocket();
    connectEthereumWebSocket();
    connectSolanaWebSocket();
    connectBnbWebSocket();
    connectLtcWebSocket();
    connectTonWebSocket();
    connectBchWebSocket();
    connectDogeWebSocket();
    connectXrpWebSocket();
  }

  @override
  void dispose() {
    // Ensure that the channels are closed properly
    channel?.sink.close();
    ethereumchannel?.sink.close();
    solanachannel?.sink.close();
    bnbchannel?.sink.close();
    ltcchannel?.sink.close();
    tonchannel?.sink.close();
    bchchannel?.sink.close();
    dogechannel?.sink.close();
    xrpchannel?.sink.close();
    super.dispose();
  }

  String formatNumber(double num) {
    if (num >= 1000000000) {
      return '${(num / 1000000000).toStringAsFixed(1)}B';
    } else if (num >= 1000000) {
      return '${(num / 1000000).toStringAsFixed(1)}M';
    } else if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(1)}K';
    } else {
      return num.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Name/Vol",
                style: TextStyle(color: AppColors.colorGrey, fontSize: 16),
              ),
              Text("Last Price",
                  style: TextStyle(color: AppColors.colorGrey, fontSize: 16)),
              Text("24h chg%",
                  style: TextStyle(color: AppColors.colorGrey, fontSize: 16)),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final wsdata = data[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wsdata.name,
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 15),
                          ),
                          Obx(
                            () => Text(
                              '\$${formatNumber(wsdata.volumeTraded.value)}',
                              style: TextStyle(
                                  color: AppColors.colorGrey, fontSize: 14.5),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              valueFormatter.format(wsdata.priceChange.value),
                              style: TextStyle(
                                  color: AppColors.primaryColor, fontSize: 15),
                            ),
                          ),
                          Obx(
                            () => Text(
                              '\$${valueFormatter.format(wsdata.priceChange.value)}',
                              style: TextStyle(
                                  color: AppColors.colorGrey, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Container(
                          height: 36,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: wsdata.percentageChange.value == 0.0
                                  ? Colors.grey
                                  : wsdata.percentageChange.value > 0
                                      ? Colors.green
                                      : Colors.red),
                          child: Center(
                            child: Obx(
                              () => Text(
                                "${wsdata.percentageChange.value.toStringAsFixed(2)}%",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 15),
                              ),
                            ),
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
  }
}
