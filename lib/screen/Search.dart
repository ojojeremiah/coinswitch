import 'package:coinswitch/model/coins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/assets.dart';
import '../utils/theme/app_colors.dart';
import 'crypto_address.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final AssetController assetController = Get.put(AssetController());

  late List<CryptoData> _foundAssets = assetController.assets;

  // @override
  // void initState() {
  //   // _foundAssets = assetController.assets;
  //   super.initState();
  // }

  void _runfilter(String enteredKeyword) {
    List<CryptoData>? results = [];

    if (enteredKeyword.isEmpty) {
      setState(() {
        _foundAssets = results!;
      });
    } else {
      results = _foundAssets
          .where((assets) => assets.symbol.contains(enteredKeyword))
          .cast<CryptoData>()
          .toList();
    }
    // _foundAssets = results;
    setState(() {
      _foundAssets = results!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          margin: EdgeInsets.only(top: 4),
          child: TextField(
            // autofocus: true,
            onChanged: (value) => _runfilter(value),
            style: TextStyle(
              height: 1,
              wordSpacing: 2,
              color: AppColors.primaryColor,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: 'Search',
              filled: true,
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColors.primaryColor,
                size: 25,
              ),
              fillColor: Colors.grey[800],
              hintStyle: TextStyle(color: AppColors.primaryColor),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        _foundAssets.isNotEmpty
            ? Container(
                height: height / 1.76,
                child: ListView.builder(
                    itemCount: _foundAssets.length,
                    itemBuilder: (context, index) {
                      final crypto = _foundAssets[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 15, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: AppColors.cardColor,
                                          backgroundImage:
                                              NetworkImage(crypto.image!),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
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
                          ),
                        ],
                      );
                    }),
              )
            : CryptoAddress(assetController: assetController)
      ],
    );
  }
}
