import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
    CategoryResponse({
        this.categoriesCount,
        this.categoriesList,
    });

    int categoriesCount;
    List<CategoriesList> categoriesList;

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        categoriesCount: json["categories_count"],
        categoriesList: List<CategoriesList>.from(json["categories_list"].map((x) => CategoriesList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories_count": categoriesCount,
        "categories_list": List<dynamic>.from(categoriesList.map((x) => x.toJson())),
    };
}

class CategoriesList {
    CategoriesList({
        this.id,
        this.image,
        this.category,
    });

    int id;
    String image;
    String category;

    factory CategoriesList.fromJson(Map<String, dynamic> json) => CategoriesList(
        id: json["id"],
        image: json["image"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "category": category,
    };
}
