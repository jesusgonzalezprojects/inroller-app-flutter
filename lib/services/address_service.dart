import 'dart:convert';

import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/address_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class AddressService  {


    Future<List<Address>> fetchAddress() async  {
        
        Response response = await http.get(BASE_URL+'/address?user_id=1');

        if (response.statusCode == 200) {
            return addressResponseFromJson(response.body).address;
        }

        return [];
    }

    Future<Address>getAddress({int addressId}) async {
        
        Response response = await http.get(BASE_URL+'/address/$addressId');

        Map address = json.decode(response.body);
     
        if (response.statusCode == 200) {
            return Address.fromJson(address);
        }

        return new Address();
    }
    
    Future<Map>deleteAddress({int addressId}) async {
        
        Response response = await http.delete(BASE_URL+'/address/$addressId');

        Map result = json.decode(response.body);
        
        Map<String,dynamic> responseResult =  {
            "message":"","ok":false
        };

        responseResult['message'] = result['msg'];

        if (response.statusCode == 201) {
            responseResult['ok'] = true;
        } else {
            responseResult['ok'] = false;
        }

        return responseResult;
    }

}