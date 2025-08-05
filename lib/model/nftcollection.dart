// To parse this JSON data, do
//
//     final nftModel = nftModelFromJson(jsonString);

import 'dart:convert';

NftModel nftModelFromJson(String str) => NftModel.fromJson(json.decode(str));

String nftModelToJson(NftModel data) => json.encode(data.toJson());

class NftModel {
  String collection;
  String? name;
  String description;
  String? imageUrl;
  String bannerImageUrl;
  String owner;
  String safelistStatus;
  String category;
  bool isDisabled;
  bool isNsfw;
  bool traitOffersEnabled;
  bool collectionOffersEnabled;
  String openseaUrl;
  String projectUrl;
  String wikiUrl;
  String discordUrl;
  String telegramUrl;
  String? twitterUsername;
  String instagramUsername;
  List<Contract> contracts;

  NftModel({
    required this.collection,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.bannerImageUrl,
    required this.owner,
    required this.safelistStatus,
    required this.category,
    required this.isDisabled,
    required this.isNsfw,
    required this.traitOffersEnabled,
    required this.collectionOffersEnabled,
    required this.openseaUrl,
    required this.projectUrl,
    required this.wikiUrl,
    required this.discordUrl,
    required this.telegramUrl,
    required this.twitterUsername,
    required this.instagramUsername,
    required this.contracts,
  });

  factory NftModel.fromJson(Map<String, dynamic> json) => NftModel(
        collection: json["collection"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        bannerImageUrl: json["banner_image_url"],
        owner: json["owner"],
        safelistStatus: json["safelist_status"],
        category: json["category"],
        isDisabled: json["is_disabled"],
        isNsfw: json["is_nsfw"],
        traitOffersEnabled: json["trait_offers_enabled"],
        collectionOffersEnabled: json["collection_offers_enabled"],
        openseaUrl: json["opensea_url"],
        projectUrl: json["project_url"],
        wikiUrl: json["wiki_url"],
        discordUrl: json["discord_url"],
        telegramUrl: json["telegram_url"],
        twitterUsername: json["twitter_username"],
        instagramUsername: json["instagram_username"],
        contracts: List<Contract>.from(
            json["contracts"].map((x) => Contract.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collection": collection,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "banner_image_url": bannerImageUrl,
        "owner": owner,
        "safelist_status": safelistStatus,
        "category": category,
        "is_disabled": isDisabled,
        "is_nsfw": isNsfw,
        "trait_offers_enabled": traitOffersEnabled,
        "collection_offers_enabled": collectionOffersEnabled,
        "opensea_url": openseaUrl,
        "project_url": projectUrl,
        "wiki_url": wikiUrl,
        "discord_url": discordUrl,
        "telegram_url": telegramUrl,
        "twitter_username": twitterUsername,
        "instagram_username": instagramUsername,
        "contracts": List<dynamic>.from(contracts.map((x) => x.toJson())),
      };
}

class Contract {
  String address;
  String chain;

  Contract({
    required this.address,
    required this.chain,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        address: json["address"],
        chain: json["chain"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "chain": chain,
      };
}
