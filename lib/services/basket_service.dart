import 'dart:convert';

import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/basket_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BasketService {

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<Basket> fetchBasket() async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');
        
        Response response = await http.get(BASE_URL+'/basket?user_id=$user_id');

        if (response.statusCode == 200) {
            return basketResponseFromJson(response.body).basket;
        }

        return new Basket();
    }   

    Future<Map<String,dynamic>> deleteProduct(int productId) async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');
        
        Response response = await http.delete(BASE_URL+'/product_in_basket/$productId?user_id=$user_id');
        
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

    Future<Map<String , dynamic>> addCoupon({String cupon_code}) async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.put(BASE_URL+'/basket?user_id=$user_id',body: {
            'cupon_code':cupon_code
        });

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

    Future<Map<String , dynamic>> removeCoupon() async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.delete(BASE_URL+'/basket/remove-coupon?user_id=$user_id');

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

    Future<Map>addProduct({Map data}) async {

        Map headers = {
            "Content-Type":"application/json",
            "Accept":"application/json",
        };

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.post(BASE_URL+'/product_in_basket?user_id=$user_id',headers:{
          "Content-Type":"application/json",
          "Accept":"application/json",
        },body:json.encode(data));

      

        Map result = json.decode(response.body);

        Map<String,dynamic> responseResult =  {
            "message":"","ok":false,'instructions':""
        };

        responseResult['message'] = result['msg'];

        if (response.statusCode == 201) {
            responseResult['ok'] = true;
        } else {
            responseResult['ok'] = false;
            responseResult['instructions'] = result['instructions'];
        }

        return responseResult;
    }

    Future<Map> setAddressToBasket({int addressId}) async {
        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');
        
        String endpoint = '/basket-address-select?user_id=$user_id&address_id=$addressId';

        Response response = await http.post(BASE_URL+endpoint,headers:{
          "Content-Type":"application/json",
          "Accept":"application/json",
        });

         Map result = json.decode(response.body);

        Map<String,dynamic> responseResult =  {
            "message":"","ok":false,'instructions':""
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