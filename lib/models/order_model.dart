import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
    OrderResponse({
        this.orders,
    });

    List<Order> orders;

    factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.id,
        this.total,
        this.status,
        this.createdAt,
    });

    int id;
    String total;
    String status;
    DateTime createdAt;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        total: json["total"].toString(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}
