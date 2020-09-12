// To parse this JSON data, do
//
//     final walletResponse = walletResponseFromJson(jsonString);

import 'dart:convert';

WalletResponse walletResponseFromJson(String str) => WalletResponse.fromJson(json.decode(str));

String walletResponseToJson(WalletResponse data) => json.encode(data.toJson());

class WalletResponse {
    WalletResponse({
        this.wallet,
    });

    Wallet wallet;

    factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
        wallet: Wallet.fromJson(json["wallet"]),
    );

    Map<String, dynamic> toJson() => {
        "wallet": wallet.toJson(),
    };
}

class Wallet {
    Wallet({
        this.id,
        this.amountHumans,
        this.amount,
    });

    int id;
    String amountHumans;
    String amount;

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        amountHumans: json["amount_humans"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount_humans": amountHumans,
        "amount": amount,
    };
}
