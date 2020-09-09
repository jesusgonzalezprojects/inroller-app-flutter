import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_scaffold/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<Map<String,dynamic>> generateOrder() async {
        
        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.post(BASE_URL + '/orders?user_id=$user_id');

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