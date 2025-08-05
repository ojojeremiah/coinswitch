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
  final AssetController assetController = Get.isRegistered<AssetController>()
      ? Get.find()
      : Get.put(AssetController());

  @override
  void initState() {
    super.initState();
    assetController.fetchNfts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        color: AppColors.brandColor,
        backgroundColor: AppColors.backgroundColor,
        onRefresh: () async {
          assetController.fetchNfts();
        },
        child: assetController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.brandColor),
              )
            : assetController.nfts.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 250),
                      Center(
                        child: Text(
                          'No NFTs available',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 6 / 7,
                    ),
                    itemCount: assetController.nfts.length,
                    itemBuilder: (context, index) {
                      final item = assetController.nfts[index];
                      return GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(item.openseaUrl ?? '');
                          if (!await launchUrl(url)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Could not launch ${item.openseaUrl}')),
                            );
                          }
                        },
                        child: Card(
                          color: AppColors.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                                    image: item.imageUrl != null
                                        ? DecorationImage(
                                            image: NetworkImage(item.imageUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    color: item.imageUrl == null
                                        ? Colors.grey
                                        : null,
                                  ),
                                  child: item.imageUrl == null
                                      ? const Icon(Icons.broken_image, size: 40)
                                      : null,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 20),
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
      ),
    );
  }
}
