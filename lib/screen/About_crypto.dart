import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
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
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.cryptoData.name,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ))
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
              child: Text(
                '${widget.cryptoData.marketCapChangePercentage24H}%',
                style: TextStyle(
                  color: widget.cryptoData.marketCapChangePercentage24H! >= 0
                      ? Colors.green
                      : Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: height * 0.18,
              width: width * 1,
              child: Sparkline(
                data: widget.cryptoData.sparklineIn7D!.price,
                lineWidth: 1.0,
                lineColor: widget.cryptoData.marketCapChangePercentage24H! >= 0
                    ? Colors.green
                    : Colors.red,
                fillMode: FillMode.below,
                fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // stops: const [0, 0, 7],
                    colors: [
                      widget.cryptoData.marketCapChangePercentage24H! >= 0
                          ? Colors.green
                          : Colors.red,
                      Colors.transparent
                    ]),
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
