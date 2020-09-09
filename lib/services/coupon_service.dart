import 'dart:convert';

import 'package:flutter_scaffold/models/coupon_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_scaffold/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponService {

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<List<Coupon>> fetchCoupons() async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.get(BASE_URL+'/coupons?user_id=$user_id');

        print(response.body);

        if (response.statusCode == 200) {
            return couponResponseFromJson(response.body).coupons;
        }

        return [];
    }

    Future<Map<String,dynamic>> addCoupon() async {
        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');
        Response response = await http.post(BASE_URL+'/coupons?user_id=$user_id');

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