// To parse this JSON data, do
//
//     final couponResponse = couponResponseFromJson(jsonString);

import 'dart:convert';

CouponResponse couponResponseFromJson(String str) => CouponResponse.fromJson(json.decode(str));

String couponResponseToJson(CouponResponse data) => json.encode(data.toJson());

class CouponResponse {
    CouponResponse({
        this.cuponsCount,
        this.coupons,
    });

    int cuponsCount;
    List<Coupon> coupons;

    factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
        cuponsCount: json["cupons_count"],
        coupons: List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cupons_count": cuponsCount,
        "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
    };
}

class Coupon {
    Coupon({
        this.code,
        this.discount,
        this.subscription,
        this.status,
    });

    String code;
    String discount;
    bool subscription;
    bool status;

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        code: json["code"],
        discount: json["discount"],
        subscription: json["subscription"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "discount": discount,
        "subscription": subscription,
        "status": status,
    };
}
