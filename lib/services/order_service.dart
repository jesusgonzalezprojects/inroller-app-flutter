import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_scaffold/config.dart';

class OrderService {
    
    Future<Map<String,dynamic>> generateOrder() async {
        Response response = await http.post(BASE_URL + '/orders?user_id=1');

        Map result = json.decode(response.body);
        
        Map<String,dynamic> responseResult =  {
            "message":"","ok":false,"mail":"","order_detail":{}
        };

        responseResult['message'] = result['msg'];

        if (response.statusCode == 201) {
            responseResult['ok'] = true;
            responseResult['mail'] = result['mail'];
            responseResult['order_detail'] = result['order_detail'];
        } else {
            responseResult['ok'] = false;
        }

        return responseResult;
    }

}