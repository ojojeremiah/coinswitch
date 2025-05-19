// To parse this JSON data, do
//
//     final userAssetBalance = userAssetBalanceFromJson(jsonString);

import 'dart:convert';

UserAssetBalance userAssetBalanceFromJson(String str) =>
    UserAssetBalance.fromJson(json.decode(str));

String userAssetBalanceToJson(UserAssetBalance data) =>
    json.encode(data.toJson());

class UserAssetBalance {
  String address;
  int totalReceived;
  int totalSent;
  int balance;
  int unconfirmedBalance;
  int finalBalance;
  int nTx;
  int unconfirmedNTx;
  int finalNTx;

  UserAssetBalance({
    required this.address,
    required this.totalReceived,
    required this.totalSent,
    required this.balance,
    required this.unconfirmedBalance,
    required this.finalBalance,
    required this.nTx,
    required this.unconfirmedNTx,
    required this.finalNTx,
  });

  factory UserAssetBalance.fromJson(Map<String, dynamic> json) =>
      UserAssetBalance(
        address: json["address"],
        totalReceived: json["total_received"],
        totalSent: json["total_sent"],
        balance: json["balance"],
        unconfirmedBalance: json["unconfirmed_balance"],
        finalBalance: json["final_balance"],
        nTx: json["n_tx"],
        unconfirmedNTx: json["unconfirmed_n_tx"],
        finalNTx: json["final_n_tx"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "total_received": totalReceived,
        "total_sent": totalSent,
        "balance": balance,
        "unconfirmed_balance": unconfirmedBalance,
        "final_balance": finalBalance,
        "n_tx": nTx,
        "unconfirmed_n_tx": unconfirmedNTx,
        "final_n_tx": finalNTx,
      };
}
