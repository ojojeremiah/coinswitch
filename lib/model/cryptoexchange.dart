// To parse this JSON data, do
//
//     final cryptoExchange = cryptoExchangeFromJson(jsonString);

import 'dart:convert';

CryptoExchange cryptoExchangeFromJson(String str) =>
    CryptoExchange.fromJson(json.decode(str));

String cryptoExchangeToJson(CryptoExchange data) => json.encode(data.toJson());

class CryptoExchange {
  Convert converter;
  Convert converting;

  CryptoExchange({
    required this.converter,
    required this.converting,
  });

  factory CryptoExchange.fromJson(Map<String, dynamic> json) => CryptoExchange(
        converter: Convert.fromJson(json["Converter"]),
        converting: Convert.fromJson(json["Converting"]),
      );

  Map<String, dynamic> toJson() => {
        "Converter": converter.toJson(),
        "Converting": converting.toJson(),
      };
}

class Convert {
  int usd;

  Convert({
    required this.usd,
  });

  factory Convert.fromJson(Map<String, dynamic> json) => Convert(
        usd: json["usd"],
      );

  Map<String, dynamic> toJson() => {
        "usd": usd,
      };
}
