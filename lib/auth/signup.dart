import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/user.dart';
import 'package:flutter_scaffold/blocks/auth_block.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

    final _formKey = GlobalKey<FormState>();
    final User user = User();
    String confirmPassword;
    @override
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
                            validator: (value) {
                                if (value.isEmpty) {
                                    return 'Ingresa tu nombre';
                                }
                                return null;
                            },
                            onSaved: (value) {
                                setState(() {
                                    user.name = value;
                                });
                            },
                            decoration: InputDecoration(
                                hintText: 'Por favor Ingresa tu nombre',
                                labelText: 'Nombre',
                            ),
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TextFormField(
                            validator: (value) {
                                if (value.isEmpty) {
                                    return 'Por favor Ingresa tu apellido';
                                }
                                return null;
                            },
                            onSaved: (value) {
                                setState(() {
                                    user.lastName = value;
                                });
                            },
                            decoration: InputDecoration(
                                hintText: 'Ingresa tu apellido',
                                labelText: 'Apellido',
                            ),
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TextFormField(
                            validator: (value) {
                                if (value.isEmpty) {
                                    return 'Por favor Ingresa tu numero de telefono';
                                }
                                return null;
                            },
                            onSaved: (value) {
                                setState(() {
                                    user.lastName = value;
                                });
                            },
                            decoration: InputDecoration(
                                hintText: 'Ingresa tu numero de telefono',
                                labelText: 'Numero de telefono',
                            ),
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TextFormField(
                            validator: (value) {
                                if (value.isEmpty) {
                                return 'Por favor ingresa tu dirección de correo electronico';
                                }
                                return null;
                            },
                            onSaved: (value) {
                                setState(() {
                                user.email = value;
                                });
                            },
                            decoration: InputDecoration(
                                hintText: 'Ingresa tu dirección de correo electronico',
                                labelText: 'Dirección de correo electronico',
                            ),
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TextFormField(
                                validator: (value) {
                                    print(value);
                                    if (value.isEmpty) {
                                        return 'Por favor ingresa tu contraseña';
                                    }
                                    return null;
                                },
                                onSaved: (value) {
                                    setState(() {
                                        user.password = value;
                                    });
                                },
                                onChanged: (text) {
                                    user.password = text;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Ingresa tu contraseña',
                                    labelText: 'Contraseña',
                                ),
                                obscureText: true),
                        ),
                        TextFormField(
                            validator: (value) {
                                if (value.isEmpty) {
                                    return 'Por favor confirma tu contraseña';
                                } else if (user.password != confirmPassword) {
                                    return 'Las contraseñas no coindicen';
                                }
                                return null;
                            },
                            onChanged: (text) {
                                confirmPassword = text;
                            },
                            decoration: InputDecoration(
                                hintText: 'Repite tu contraseña',
                                labelText: 'confirma tu contraseña',
                            ),
                            obscureText: true,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Consumer<AuthBlock>(builder:
                                (BuildContext context, AuthBlock auth, Widget child) {
                                return RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: auth.loading && auth.loadingType == 'register' ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ) : Text('Registrate'),
                                onPressed: () {
                                    if (_formKey.currentState.validate() && !auth.loading) {
                                    _formKey.currentState.save();
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    auth.register(user);
                                    }
                                },
                                );
                            }),
                            ),
                        )
                    ],
                ),
                ),
            ),
            ),
        );
    }
}
