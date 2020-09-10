// To parse this JSON data, do
//
//     final shippingAddressResponse = shippingAddressResponseFromJson(jsonString);

import 'dart:convert';

ShippingAddressResponse shippingAddressResponseFromJson(String str) => ShippingAddressResponse.fromJson(json.decode(str));

String shippingAddressResponseToJson(ShippingAddressResponse data) => json.encode(data.toJson());

class ShippingAddressResponse {
    ShippingAddressResponse({
        this.address,
        this.shippingAddress,
    });

    Address address;
    bool shippingAddress;

    factory ShippingAddressResponse.fromJson(Map<String, dynamic> json) => ShippingAddressResponse(
        address: Address.fromJson(json["address"]),
        shippingAddress: json["shipping_address"],
    );

    Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "shipping_address": shippingAddress,
    };
}

class Address {
    Address({
        this.addressId,
        this.codigoPostal,
        this.estado,
        this.municipio,
        this.colonia,
        this.calle,
        this.nInterior,
        this.nExterior,
        this.calle1,
        this.calle2,
        this.referencias,
        this.telefono,
        this.createdAt,
    });

    int addressId;
    String codigoPostal;
    String estado;
    String municipio;
    String colonia;
    String calle;
    String nInterior;
    String nExterior;
    String calle1;
    String calle2;
    String referencias;
    String telefono;
    DateTime createdAt;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressId: json["address_id"],
        codigoPostal: json["codigo_postal"],
        estado: json["estado"],
        municipio: json["municipio"],
        colonia: json["colonia"],
        calle: json["calle"],
        nInterior: json["n_interior"],
        nExterior: json["n_exterior"],
        calle1: json["calle_1"],
        calle2: json["calle_2"],
        referencias: json["referencias"],
        telefono: json["telefono"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "codigo_postal": codigoPostal,
        "estado": estado,
        "municipio": municipio,
        "colonia": colonia,
        "calle": calle,
        "n_interior": nInterior,
        "n_exterior": nExterior,
        "calle_1": calle1,
        "calle_2": calle2,
        "referencias": referencias,
        "telefono": telefono,
        "created_at": createdAt.toIso8601String(),
    };
}
