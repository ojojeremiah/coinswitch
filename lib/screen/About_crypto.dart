import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/coins.dart';
import '../utils/theme/app_colors.dart';

class AboutCrypto extends StatefulWidget {
  final CryptoData cryptoData;
  const AboutCrypto({super.key, required this.cryptoData});

  @override
  State<AboutCrypto> createState() => _AboutCryptoState();
}

class _AboutCryptoState extends State<AboutCrypto> {
  // late TrackballBehavior trackballBehavior;

  final value = NumberFormat("#,##0.00", "en_US");

  String formatNumber(int num) {
    if (num >= 1000000000000) {
      return '${(num / 1000000000000).toStringAsFixed(1)} T';
    } else if (num >= 1000000000) {
      return '${(num / 1000000000).toStringAsFixed(1)} B';
    } else if (num >= 1000000) {
      return '${(num / 1000000).toStringAsFixed(1)} M';
    } else if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(1)} K';
    } else {
      return num.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chart = widget.cryptoData.marketCapChangePercentage24H! >= 0
        ? Colors.green
        : Colors.red;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor,
            )),
        centerTitle: true,
        title: const Text(
          "About ",
          style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.cardColor,
                  backgroundImage: NetworkImage(widget.cryptoData.image),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.cryptoData.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "\$ ${value.format(widget.cryptoData.currentPrice)}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Icon(
                    size: 20,
                    widget.cryptoData.marketCapChangePercentage24H! > 0
                        ? Icons.add
                        : null,
                    color: widget.cryptoData.marketCapChangePercentage24H! > 0
                        ? Colors.green
                        : Colors.red,
                  ),
                  Text(
                    '${widget.cryptoData.marketCapChangePercentage24H}%',
                    style: TextStyle(
                      color:
                          widget.cryptoData.marketCapChangePercentage24H! >= 0
                              ? Colors.green
                              : Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 150,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      enabled: true,
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> spotIndex) {
                        return spotIndex.map((index) {
                          return TouchedSpotIndicatorData(
                              FlLine(
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                  dashArray: [6, 3]),
                              FlDotData(show: true));
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.black.withOpacity(0.8),
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              "\$${spot.y.toStringAsFixed(2)}",
                              const TextStyle(color: Colors.white),
                            );
                          }).toList();
                        },
                      ),
                      touchCallback: (event, response) {
                        // Optional: Handle touch event
                      },
                      handleBuiltInTouches: true,
                    ),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: widget.cryptoData.sparklineIn7D!.price
                            .sublist(
                                widget.cryptoData.sparklineIn7D!.price.length -
                                    24)
                            .asMap()
                            .entries
                            .map((e) => FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        color: chart,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              chart.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                          // gradient: const Offset(0, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              height: 230,
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rank",
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          Text(
                            "No. ${widget.cryptoData.marketCapRank}",
                            style: TextStyle(color: AppColors.primaryColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Market Cap",
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          Text(
                            "\$ ${formatNumber(widget.cryptoData.marketCap)}",
                            style: TextStyle(color: AppColors.primaryColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fully Diluted Market Cap",
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          Text(
                            "\$ ${formatNumber(widget.cryptoData.fullyDilutedValuation)}",
                            style: TextStyle(color: AppColors.primaryColor),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Circulation Supply",
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          Text(
                            "${value.format(widget.cryptoData.circulatingSupply)}",
                            style: TextStyle(color: AppColors.primaryColor),
                          )
                        ],
                      ),
                    ),
                    widget.cryptoData.maxSupply == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Max Supply",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                              Text(
                                "${value.format(widget.cryptoData.maxSupply)}",
                                style: TextStyle(color: AppColors.primaryColor),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
