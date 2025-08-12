import 'dart:convert';

List<CryptoInfo> cryptoInfoFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<CryptoInfo>.from(jsonData.map((x) => CryptoInfo.fromJson(x)));
}

String cryptoInfoToJson(List<CryptoInfo> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class CryptoInfo {
  String identifier;
  String provider;
  Cg cg;
  int priceUsd;
  int timestamp;

  CryptoInfo({
    required this.identifier,
    required this.provider,
    required this.cg,
    required this.priceUsd,
    required this.timestamp,
  });

  factory CryptoInfo.fromJson(Map<String, dynamic> json) => new CryptoInfo(
        identifier: json["identifier"],
        provider: json["provider"],
        cg: Cg.fromJson(json["cg"]),
        priceUsd: json["price_usd"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "provider": provider,
        "cg": cg.toJson(),
        "price_usd": priceUsd,
        "timestamp": timestamp,
      };
}

class Cg {
  String id;
  String name;
  int marketCap;
  int totalVolume;
  double priceChange24HUsd;
  double priceChangePercentage24HUsd;
  List<double> sparklineIn7D;
  String timestamp;

  Cg({
    required this.id,
    required this.name,
    required this.marketCap,
    required this.totalVolume,
    required this.priceChange24HUsd,
    required this.priceChangePercentage24HUsd,
    required this.sparklineIn7D,
    required this.timestamp,
  });

  factory Cg.fromJson(Map<String, dynamic> json) => new Cg(
        id: json["id"],
        name: json["name"],
        marketCap: json["market_cap"],
        totalVolume: json["total_volume"],
        priceChange24HUsd: json["price_change_24h_usd"].toDouble(),
        priceChangePercentage24HUsd:
            json["price_change_percentage_24h_usd"].toDouble(),
        sparklineIn7D:
            List<double>.from(json["sparkline_in_7d"].map((x) => x.toDouble())),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "market_cap": marketCap,
        "total_volume": totalVolume,
        "price_change_24h_usd": priceChange24HUsd,
        "price_change_percentage_24h_usd": priceChangePercentage24HUsd,
        "sparkline_in_7d": List<dynamic>.from(sparklineIn7D.map((x) => x)),
        "timestamp": timestamp,
      };
}
