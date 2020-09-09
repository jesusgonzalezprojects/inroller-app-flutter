import 'package:flutter/material.dart';
import 'package:flutter_scaffold/services/auth_service.dart';
import 'package:flutter_scaffold/services/user_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserActivatePage extends StatefulWidget {
    @override
    _UserActivatePageState createState() => _UserActivatePageState();
}

class _UserActivatePageState extends State<UserActivatePage>{
    
    final _formKey = GlobalKey<FormState>();
    bool loading = false;
    final userService = new UserService();
    final authService = new AuthService();
    String _code;

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    String validateCode(String code) {

        if (code.isEmpty)
            return "Este campo no puede estar vacio";

        if (code.length < 4) 
          return "Codigo incorrecto";

        return null;
    }

     //var desings
    final title = TextStyle(
        color: Color(0XFF242A37),
        fontSize: 24.0,
        fontWeight: FontWeight.bold
    );

    final textBold = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 15.0
    );

     Future<void> submit() async {
        if (_formKey.currentState.validate()) {

            setState(() {
              loading = true;
            });

            _formKey.currentState.save();

            Map response = await this.userService.activateAccount(token: this._code);

            setState(() {
              loading = false;
            });

            Fluttertoast.showToast(
                msg: '${response['message']}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                fontSize: 16.0
            );

            print(response);

            if (response['ok']) {
                final SharedPreferences prefs = await _prefs;
                prefs.setInt('user_id', response['user']['id']);
                Navigator.pushReplacementNamed(context, '/');
            }

           /* Map response = await authProvider.activateAccount(_code);

            setState(() {
                showLoading = false;
            });

            Toast.show(
                "${response['message']}",
                context,
                duration: 5,
                gravity:  Toast.TOP,
                backgroundColor:Color(0XFFf07539)
            );

            if ( response['activate'] ) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginUI()));
            }*/


        }
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: _appBar(),
            body: (loading != true)
                ? Stack(
                    children: <Widget>[
                        _backGroundTop(context),
                        _loginFormContent(context),
                    ],
                )
                : Center(child:CircularProgressIndicator()),
        );
    }
    AppBar _appBar () {
        return AppBar(
            backgroundColor: Colors.white,
            title: Image.asset('assets/images/logo_full.png',
                width: 170.0, height: 55.0
            ),
            centerTitle: true,
        );
    }
     Widget _backGroundTop(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Container(
            height: size.height * 0.30,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/4.jpg'),
                    fit: BoxFit.cover
                ),
            )
        );
    }
    Widget _loginFormContent(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    _topLogin(size),
                    Container(
                        width: size.width,
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        decoration: _desingLoginForm(),
                        child: _form(context),
                    )
                ],
            ),
        );
    }

    Form _form(BuildContext context) {
        return Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                    Text("Activa tu cuenta",style: title),
                    SizedBox(height: 20.0),
                    codeField(),
                    SizedBox(height: 20.0),
                    _createButton(context),
                    SizedBox(height: 20.0),
                ],
            ),
        );
    }

    Widget codeField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.8,
            child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                enabled: true,
                initialValue: null,
                decoration: InputDecoration(
                    labelText: "Codigo de confirmación",
                    border: OutlineInputBorder()
                ),
                onSaved: (String value) {
                    _code = value;
                },
                validator: validateCode
            ),
        );
    }

    Widget _createButton(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * .8,
            height: 48,
            child: new RaisedButton(
                child: Text(
                    'Siguiente ',style: new TextStyle(color: Colors.white)
                ),
                onPressed: () => this.submit(),
                color: Color(0XFFf07539),
            ),
        );
    }
    
    SafeArea _topLogin(Size size) {
        return SafeArea(
            child: Container(
                height: size.height * 0.35,
            ),
        );
    }
    BoxDecoration _desingLoginForm() {
        return BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0
                )
            ]
        );
    }
}