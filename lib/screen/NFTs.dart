import 'package:coinswitch/controller/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/theme/app_colors.dart';

class NTFs extends StatefulWidget {
  const NTFs({super.key});

  @override
  State<NTFs> createState() => _NTFsState();
}

class _NTFsState extends State<NTFs> {
  final AssetController assetController = Get.put(AssetController());

  @override
  void initState() {
    super.initState();
    assetController.fetchNfts(); // Fetch NFTs when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (assetController.isLoading.value) {
          // Show a loading indicator while data is being fetched
          return const Center(
            child: CircularProgressIndicator(color: AppColors.brandColor),
          );
        } else if (assetController.nfts.isEmpty) {
          // Handle the case where no NFTs are available
          return Center(
            child: Text(
              'No NFTs available',
              style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
            ),
          );
        }
        return RefreshIndicator(
          color: AppColors.brandColor,
          backgroundColor: AppColors.backgroundColor,
          onRefresh: () async {
            assetController.fetchNfts();
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 6 / 7,
            ),
            itemCount: assetController.nfts.length,
            itemBuilder: (context, index) {
              final item = assetController.nfts[index];
              return GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(item.openseaUrl);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Card(
                  color: AppColors.cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 140,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(item.imageUrl ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        child: Text(
                          item.name ?? 'Unnamed NFT',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
