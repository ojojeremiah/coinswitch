import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndividualAdress extends StatefulWidget {
  final dynamic cryptoData;
  const IndividualAdress({super.key, required this.cryptoData});

  @override
  State<IndividualAdress> createState() => _IndividualAdressState();
}

class _IndividualAdressState extends State<IndividualAdress> {
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
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.cryptoData.name,
              style: const TextStyle(color: AppColors.primaryColor),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primaryColor,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    backgroundImage: widget.cryptoData.pictures,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '${widget.cryptoData.balance} ${widget.cryptoData.symbol}'
                          .toUpperCase(),
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '\$0.00',
                    style: TextStyle(
                      color: AppColors.colorGrey,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.cardColor,
                                  child: Icon(
                                    Icons.arrow_outward_rounded,
                                    size: 23,
                                    color: AppColors.brandColor,
                                  ),
                                ),
                                Text('Send',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor))
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.cardColor,
                                  child: Icon(Icons.arrow_downward_rounded,
                                      size: 23, color: AppColors.brandColor),
                                ),
                                Text(
                                  'Receive',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primaryColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.cardColor,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.brandColor,
                                    size: 23,
                                  ),
                                ),
                                Text('Buy',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor))
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                showDragHandle: false,
                                context: context,
                                builder: ((context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    width: width,
                                    height: height * 0.25,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: 400,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: AppColors.cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const ListTile(
                                                  trailing: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  leading: Icon(
                                                    Icons.remove,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  title: Text(
                                                    'Sell',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: 400,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: AppColors.cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const ListTile(
                                                  trailing: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 15,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  leading: Icon(
                                                    Icons.swap_vert_rounded,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  title: Text(
                                                    'Swap',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.cardColor,
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: AppColors.brandColor,
                                    size: 26,
                                  ),
                                ),
                                Text('More',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.colorGrey,
            ),
            Center(
              child: Text(
                "No Transactions made yet",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
