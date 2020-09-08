import 'dart:convert';

AccesoryResponse accesoryResponseFromJson(String str) => AccesoryResponse.fromJson(json.decode(str));

String accesoryResponseToJson(AccesoryResponse data) => json.encode(data.toJson());

class AccesoryResponse {
    AccesoryResponse({
        this.accesoriesList,
    });

    List<AccesoriesList> accesoriesList;

    factory AccesoryResponse.fromJson(Map<String, dynamic> json) => AccesoryResponse(
        accesoriesList: List<AccesoriesList>.from(json["accesories_list"].map((x) => AccesoriesList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "accesories_list": List<dynamic>.from(accesoriesList.map((x) => x.toJson())),
    };
}

class AccesoriesList {
    AccesoriesList({
        this.id,
        this.name,
        this.price,
        this.urlImage,
    });

    int id;
    String name;
    String price;
    String urlImage;

    factory AccesoriesList.fromJson(Map<String, dynamic> json) => AccesoriesList(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        urlImage: json["url_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "url_image": urlImage,
    };
}
