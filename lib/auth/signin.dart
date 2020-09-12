import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/user.dart';
import 'package:flutter_scaffold/services/auth_service.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
    final _formKey = GlobalKey<FormState>();
    final UserCredential userCredential = UserCredential();

    bool loading = false;

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

            _formKey.currentState.save();

            setState(() {
                loading = true;
            });

            final auth = new AuthService();

            setState(() {
                loading = false;
            });

            Map response = await auth.login(userCredential);
            if (response['login']) {
                Navigator.pushReplacementNamed(context, '/');
            }
        }
    }


    @override
    Widget build(BuildContext context) {
        return Scaffold(
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
                    Text("Acceso a tu cuenta",style: title),
                    SizedBox(height: 20.0),
                    emailOrCellphoneField(),
                    SizedBox(height: 20.0),
                    passwordField(),
                    SizedBox(height: 20.0),
                    _createButton(context),
                    SizedBox(height: 20.0),
                ],
            ),
        );
    }

    Widget emailOrCellphoneField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.8,
            child: TextFormField(
                obscureText: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                initialValue: userCredential.usernameOrEmail,
                enabled: true,
                decoration: InputDecoration(
                    errorText: '',
                    labelText: "Correo / Celular",
                    border: OutlineInputBorder()
                ),
                onSaved: (String value) {
                    setState(() {
                        userCredential.usernameOrEmail = value;
                    });
                },
                 validator: (value) {
                    if (value.isEmpty) {
                        return 'Por favor ingresa tu correo electronico';
                    }
                    return null;
                },
            ),
        );
    }

    Widget passwordField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.8,
            child: TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                enabled: true,
                initialValue: null,
                decoration: InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder()
                ),
                validator: (value) {
                    if (value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                },
                onSaved: (value) {
                    setState(() {
                        userCredential.password = value;
                    });
                },
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
                    'Acceder ',style: new TextStyle(color: Colors.white)
                ),
                onPressed: () => this.submit(),
                color: Color(0XFFf07539),
            ),
        );
    }

    Widget _backGroundTop(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Container(
            height: size.height * 0.42,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/9.jpg'),
                    fit: BoxFit.cover
                ),
            )
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

  /*@override
  Widget build(BuildContext context) {
    return Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor ingresa tu correo electronico';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          userCredential.usernameOrEmail = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Ingresa tu correo o numero de telefono',
                        labelText: 'Correo/Telefono',
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        userCredential.password = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu contraseña',
                      labelText: 'Contraseña',
                    ),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthBlock>(
                        builder:
                            (BuildContext context, AuthBlock auth, Widget child) {
                          return RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: auth.loading && auth.loadingType == 'login' ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ) : Text('Acceder'),
                            onPressed: () async {
                              // Validate form
                              if (_formKey.currentState.validate() && !auth.loading) {
                                // Update values
                                _formKey.currentState.save();
                                // Hit Api
                                Map response = await auth.login(userCredential);
                                if (response['login']) {
                                  Navigator.pushReplacementNamed(context, '/');
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }*/
}
