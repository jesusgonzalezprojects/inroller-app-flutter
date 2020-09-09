import 'dart:convert';
import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
    
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<Map> login(UserCredential userCredential) async {
        
        final response = await http.post('$BASE_URL/login', body: {
            'email': userCredential.usernameOrEmail,
            'password': userCredential.password
        });

        print("Status code: "+response.statusCode.toString());

        if (response.statusCode == 200) {
            Map auth = json.decode(response.body);
            setToken(auth);
            return jsonDecode(response.body);
        }else {
            if (response.statusCode == 401) {
                Fluttertoast.showToast(
                    msg: "Credenciales invalidas",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    fontSize: 16.0);
            }else if (response.statusCode == 400) {
               Fluttertoast.showToast(
                    msg: "Tu cuenta no esta activa, revisa tu bande de entrada del correo proporcionado",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 2,
                    fontSize: 16.0);
            }
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
                return jsonDecode(response.body);
            }
    }

    setToken(Map auth) async {
        final SharedPreferences prefs = await _prefs;
        prefs.setInt('user_id', auth['user_id']);
    }

    getToken() async {
        final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');
        return user_id;
    }
    logout() async {
        //await storage.delete(key: 'user');
    }
}
