import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_scaffold/blocks/auth_block.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin.dart';
import 'signup.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final List<Widget> tabs = [
        SignIn(),
        SignUp()
    ];

    @override
    void initState() {
       this.getInit();
    }

    void getInit() async {
       final SharedPreferences prefs = await _prefs;
        int user_id = prefs.getInt('user_id');

        if (user_id != null) {
          Navigator.pushReplacementNamed(context, '/');
        }
    }
    @override
    Widget build(BuildContext context) {
        final AuthBlock authBlock = Provider.of<AuthBlock>(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Image.asset('assets/images/logo_full.png',
                width: 250.0, height: 55.0
            ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.lock_open),
                title: Text('Acceder'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                title: Text('Crear cuenta'),
            ),
            ],
            currentIndex: authBlock.currentIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (num){
            authBlock.currentIndex = num;
            },
        ),
        body: tabs[authBlock.currentIndex],
        );
    }
}