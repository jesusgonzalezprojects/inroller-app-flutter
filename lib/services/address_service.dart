import 'dart:convert';

import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/address_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressService  {

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<List<Address>> fetchAddress() async  {
        
        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');
        Response response = await http.get(BASE_URL+'/address?user_id=$user_id');

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

    Future<Map> addAddress({Map data}) async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        print(data);

        Response response = await http.post(BASE_URL+'/address?user_id=$user_id',headers: {
            "Content-Type":"application/json",
            "Accept":"application/json",
        },body:json.encode(data));

         Map result = json.decode(response.body);

         print(result);

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