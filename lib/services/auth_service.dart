import 'dart:convert';

import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
    //final storage = FlutterSecureStorage();
    // Create storage
    Future<Map> login(UserCredential userCredential) async {
        final response = await http.post('$BASE_URL/login', body: {
            'email': userCredential.usernameOrEmail,
            'password': userCredential.password
        });

        if (response.statusCode == 200) {
            setUser(response.body);
            return jsonDecode(response.body);
        }else {
            if (response.statusCode == 401) {
                Fluttertoast.showToast(
                    msg: "Credenciales invalidas",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    fontSize: 16.0);
            }
        // If that call was not successful, throw an error.
    //      throw Exception(response.body);
        return jsonDecode(response.body);
        }
    }

    Future<Map> register(User user) async {
        final response = await http.post('$BASE_URL/api/register',
            body: {
                'name': user.name,
                "lasname":user.lastName,
                "phone":user.phone,
                'password': user.password,
                'password_confirmation':user.passwordConfirmation,
                'email': user.email,
            });
            if (response.statusCode == 201) {
            // If the call to the server was successful, parse the JSON.
            // return User.fromJson(json.decode(response.body));
                return jsonDecode(response.body);
            } else {
                if (response.statusCode == 400) {
                    Fluttertoast.showToast(
                        msg: 'El correo ya existe',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        fontSize: 16.0
                    );
                }
            // If that call was not successful, throw an error.
            //  throw Exception(response.body);
            return jsonDecode(response.body);
        }
    }

    setUser(String value) async {
        //await storage.write(key: 'user', value: value);
    }

    getUser() async {
        /*String user = await storage.read(key: 'user');
        if (user != null) {
            return jsonDecode(user);
        }*/
    }
    logout() async {
        //await storage.delete(key: 'user');
    }
}
