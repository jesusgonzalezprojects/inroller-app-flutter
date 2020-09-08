// To parse this JSON data, do
//
//     final basketResponse = basketResponseFromJson(jsonString);

import 'dart:convert';

BasketResponse basketResponseFromJson(String str) => BasketResponse.fromJson(json.decode(str));

String basketResponseToJson(BasketResponse data) => json.encode(data.toJson());

class BasketResponse {
    BasketResponse({
        this.basket,
    });

    Basket basket;

    factory BasketResponse.fromJson(Map<String, dynamic> json) => BasketResponse(
        basket: Basket.fromJson(json["basket"]),
    );

    Map<String, dynamic> toJson() => {
        "basket": basket.toJson(),
    };
}

class Basket {
    Basket({
        this.hasDiscount,
        this.pay,
        this.productsCount,
        this.products,
    });

    bool hasDiscount;
    Pay pay;
    int productsCount;
    List<Product> products;

    factory Basket.fromJson(Map<String, dynamic> json) => Basket(
        hasDiscount: json["has_discount"],
        pay: Pay.fromJson(json["pay"]),
        productsCount: json["products_count"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "has_discount": hasDiscount,
        "pay": pay.toJson(),
        "products_count": productsCount,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Pay {
    Pay({
        this.subtotal,
        this.cupon,
        this.total,
    });

    String subtotal;
    Cupon cupon;
    String total;

    factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        subtotal: json["subtotal"],
        cupon: Cupon.fromJson(json["cupon"]),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "cupon": cupon.toJson(),
        "total": total,
    };
}

class Cupon {
    Cupon({
        this.code,
        this.discount,
        this.moneyDiscount,
    });

    String code;
    String discount;
    String moneyDiscount;

    factory Cupon.fromJson(Map<String, dynamic> json) => Cupon(
        code: json["code"],
        discount: json["discount"],
        moneyDiscount: json["money_discount"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "discount": discount,
        "money_discount": moneyDiscount,
    };
}

class Product {
    Product({
        this.productId,
        this.productName,
        this.productPrice,
        this.productImage,
        this.amount,
        this.width,
        this.subtotal,
        this.categoryName,
        this.categoryImage,
        this.categoryId,
    });

    int productId;
    String productName;
    String productPrice;
    String productImage;
    int amount;
    String width;
    String subtotal;
    String categoryName;
    String categoryImage;
    int categoryId;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productImage: json["product_image"],
        amount: json["amount"],
        width: json["width"],
        subtotal: json["subtotal"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_price": productPrice,
        "product_image": productImage,
        "amount": amount,
        "width": width,
        "subtotal": subtotal,
        "category_name": categoryName,
        "category_image": categoryImage,
        "category_id": categoryId,
    };
}
