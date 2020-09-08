import 'dart:convert';

import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/basket_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class BasketService {

    Future<Basket> fetchBasket() async {

        Response response = await http.get(BASE_URL+'/basket?user_id=1');

        if (response.statusCode == 200) {
            return basketResponseFromJson(response.body).basket;
        }

        return new Basket();
    }   

    Future<Map<String,dynamic>> deleteProduct(int productId) async {
        
        Response response = await http.delete(BASE_URL+'/product_in_basket/$productId?user_id=1');
        
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

        Response response = await http.put(BASE_URL+'/basket?user_id=1',body: {
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

        Response response = await http.delete(BASE_URL+'/basket/remove-coupon?user_id=1');

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

        Response response = await http.post(BASE_URL+'/product_in_basket',headers:{
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

}