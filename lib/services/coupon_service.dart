import 'dart:convert';

import 'package:flutter_scaffold/models/coupon_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_scaffold/config.dart';

class CouponService {

    Future<List<Coupon>> fetchCoupons() async {

        Response response = await http.get(BASE_URL+'/coupons?user_id=1');

        print(response.body);

        if (response.statusCode == 200) {
            return couponResponseFromJson(response.body).coupons;
        }

        return [];
    }

    Future<Map<String,dynamic>> addCoupon() async {
        Response response = await http.post(BASE_URL+'/coupons?user_id=1');

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