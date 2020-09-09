import 'dart:convert';

import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/user.dart';
import 'package:flutter_scaffold/models/user_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService  {  

     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<Map> register({User user}) async {

        Map data = {
            'name': user.name,
            "last_name":user.lastName,
            "phone":user.phone,
            'password': user.password,
            'password_confirmation':user.passwordConfirmation,
            'email': user.email
        };

        Response response = await http.post('$BASE_URL/register',headers: {
            "Content-Type":"application/json",
            "Accept":"application/json",
        },body:json.encode(data));

        Map result = json.decode(response.body);


        Map<String,dynamic> responseResult =  {
            "message":"","ok":false,'instructions':""
        };

        responseResult['message'] = result['message'];

        if (response.statusCode == 201) {
            responseResult['ok'] = true;
        } else {
            responseResult['ok'] = false;
        }

        return responseResult;
        
    }

    Future<Map> activateAccount({String token}) async {
        
        print(token);
        Response response = await http.post('$BASE_URL/activate-account/$token',headers: {
            "Content-Type":"application/json",
            "Accept":"application/json",
        });

        Map result = json.decode(response.body);

        print(result);

        Map<String,dynamic> responseResult =  {
           "message":"","ok":false,'user':{}
        }; 

        responseResult['message'] = result['message'];

        if (response.statusCode == 200) {
            responseResult['ok'] = true;
            responseResult['user'] = result['user'];
        } else {
            responseResult['ok'] = false;
        }

        return responseResult;

    }

    Future<ProfileUser> profile () async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.get('$BASE_URL/profile/$user_id',headers: {
            "Content-Type":"application/json",
            "Accept":"application/json",
        });

        print(response.body);

        if (response.statusCode == 200) {
            return userProfileFromJson(response.body).profileUser;
        }else {
            return new ProfileUser();
        }
    }

    Future<Map> subscribeOrUnSubscribe() async {

        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        Response response = await http.post('$BASE_URL/suscripcion?user_id=$user_id',headers: {
            "Content-Type":"application/json",
            "Accept":"application/json",
        });

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

}