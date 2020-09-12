import 'package:flutter_scaffold/models/order_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_scaffold/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<Map<String,dynamic>> generateOrder({bool wallet}) async {
        
        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.post(BASE_URL + '/orders?user_id=$user_id&wallet=$wallet');

        Map result = json.decode(response.body);

        print(result);
        
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

    Future<List<Order>> fetchOrders() async{

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.get(BASE_URL + '/orders?user_id=$user_id');

        if (response.statusCode == 200) {
            return orderResponseFromJson(response.body).orders;
        }

        return [];
    }

    Future<Map<String , dynamic>> getOrder({int orderId}) async{

        Response response = await http.get(BASE_URL + '/orders/$orderId');

        Map order = json.decode(response.body);

        return order['order'];

    }

}