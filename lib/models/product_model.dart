// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
    ProductResponse({
        this.all,
        this.productsCount,
        this.productsList,
    });

    bool all;
    int productsCount;
    List<ProductsList> productsList;

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        all: json["all"],
        productsCount: json["products_count"],
        productsList: List<ProductsList>.from(json["products_list"].map((x) => ProductsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "all": all,
        "products_count": productsCount,
        "products_list": List<dynamic>.from(productsList.map((x) => x.toJson())),
    };
}

class ProductsList {
    ProductsList({
        this.id,
        this.product,
        this.productImage,
        this.productPrice,
        this.productWidth,
        this.category,
        this.categoryImage,
        this.categoryId,
        this.productDescription,
    });

    int id;
    String product;
    String productImage;
    String productPrice;
    String productWidth;
    String category;
    String categoryImage;
    int categoryId;
    String productDescription;

    factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
        id: json["id"],
        product: json["product"],
        productImage: json["product_image"],
        productPrice: json["product_price"],
        productWidth: json["product_width"],
        category: json["category"],
        categoryImage: json["category_image"],
        categoryId: json["category_id"],
        productDescription: json["product_description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "product_image": productImage,
        "product_price": productPrice,
        "product_width": productWidth,
        "category": category,
        "category_image": categoryImage,
        "category_id": categoryId,
        "product_description": productDescription,
    };
}
