import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scaffold/auth/user_activate_page.dart';
import 'package:flutter_scaffold/models/user.dart';
import 'package:flutter_scaffold/services/user_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

    bool loading = false;
    final _formKey = GlobalKey<FormState>();

    final User user = User();
    final userService = new UserService();
    String confirmPassword;

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

            Map result = await this.userService.register(user:this.user);

            setState(() {
                user.name = user.name;
                user.lastName = user.lastName;
                user.email = user.email;
                user.phone = user.phone;
                loading  = false;
            });

            Fluttertoast.showToast(
                msg: '${result['message']}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                fontSize: 16.0
            );

            if(result['ok'])  {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserActivatePage()));
            }

        }
    }


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
    Widget _backGroundTop(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Container(
            height: size.height * 0.30,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/8.jpg'),
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
                    Text("Registrate",style: title),
                    SizedBox(height: 20.0),
                    nameField(),
                    SizedBox(height: 20.0),
                    lastNameField(),
                    SizedBox(height: 20.0),
                    cellphoneField(),
                    SizedBox(height: 20.0),
                    emailOrCellphoneField(),
                    SizedBox(height: 20.0),
                    passwordField(),
                    SizedBox(height: 20.0),
                    passwordConfirmationField(),
                    SizedBox(height: 20.0),
                    _createButton(context),
                ],
            ),
        );
    }
    Widget nameField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.9,
            child: TextFormField(
                initialValue: user.name,
                obscureText: false,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                
                enabled: true,
                decoration: InputDecoration(
                    //errorText: errors['email'],
                    labelText: "Nombre",
                    border: OutlineInputBorder()
                ),
                onSaved: (String value) {
                    setState(() {
                        user.name = value;
                    });
                },
                validator: (value) {
                    if (value.isEmpty) {
                        return 'Ingresa tu nombre';
                    }
                    return null;
                },
            ),
        );
    }

    Widget lastNameField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.9,
            child: TextFormField(
                obscureText: false,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                initialValue: user.lastName,
                enabled: true,
                decoration: InputDecoration(
                    //errorText: errors['email'],
                    labelText: "Apellido",
                    border: OutlineInputBorder()
                ),
                onSaved: (String value) {
                    setState(() {
                        user.lastName = value;
                    });
                },
                validator: (value) {
                    if (value.isEmpty) {
                        return 'Ingresa tu nombre';
                    }
                    return null;
                },
            ),
        );
    }

     Widget cellphoneField() {
      final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.9,
            child: TextFormField(
                obscureText: false,
                autofocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                initialValue: user.phone,
                enabled: true,
                decoration: InputDecoration(
                    
                    labelText: "Celular",
                    border: OutlineInputBorder()
                ),
                onSaved: (String value) {
                    setState(() {
                        user.phone = value;
                    });
                },
                validator: (value) {
                    if (value.isEmpty) {
                        return 'Por favor Ingresa tu numero de telefono';
                    }
                    return null;
                },
            ),
        );
    }

    Widget emailOrCellphoneField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.9,
            child: TextFormField(
                obscureText: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                initialValue: user.email,
                enabled: true,
                decoration: InputDecoration(
                    labelText: "Correo",
                    border: OutlineInputBorder()
                ),
                onSaved: (String value) {
                   setState(() {
                       user.email = value;
                   });
                },
                validator: (value) {
                    if (value.isEmpty) {
                    return 'Por favor ingresa tu dirección de correo electronico';
                    }
                    return null;
                },
            ),
        );
    }

    Widget passwordField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.9,
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
                onSaved: (String value) {
                    setState(() {
                        user.password = value;
                    });
                },
                validator: (value) {
                    print(value);
                    if (value.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                },
              
            ),
        );
    }

    Widget passwordConfirmationField() {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * 0.9,
            child: TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                enabled: true,
                initialValue: null,
                decoration: InputDecoration(
                    labelText: "Repite tu contraseña",
                    border: OutlineInputBorder()
                ),
                onSaved: (String value) {
                    setState(() {
                        user.passwordConfirmation = value;
                        confirmPassword = value;
                    });
                },
                validator: (value) {
                    if (value.isEmpty) {
                        return 'Por favor confirma tu contraseña';
                    } else if (user.password != confirmPassword) {
                        return 'Las contraseñas no coindicen';
                    }
                    return null;
                },
            ),
        );
    }

    Widget _createButton(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Container(
            width: size.width * .9,
            height: 48,
            child: new RaisedButton(
                child: Text(
                    'Registrate ',style: new TextStyle(color: Colors.white)
                ),
                onPressed: () => this.submit(),
                color: Color(0XFFf07539),
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
    
    SafeArea _topLogin(Size size) {
        return SafeArea(
            child: Container(
                height: size.height * 0.30,
            ),
        );
    }


    /*final _formKey = GlobalKey<FormState>();
    final User user = User();
    final userService = new UserService();
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
                            Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: TextFormField(
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    enabled: true,
                                    initialValue: null,
                                    decoration: InputDecoration(
                                        labelText: "Nombre",
                                        border: OutlineInputBorder()
                                    ),
                                    onSaved: (String value) {
                                        setState(() {
                                            user.name = value;
                                        });
                                    },
                                    validator: (value) {
                                        if (value.isEmpty) {
                                            return 'Ingresa tu nombre';
                                        }
                                        return null;
                                    }
                                ),
                            )
                        /*Padding(
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
                        ),*/,
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
                                keyboardType: TextInputType.phone,
                            validator: (value) {
                                if (value.isEmpty) {
                                    return 'Por favor Ingresa tu numero de telefono';
                                }
                                return null;
                            },
                            onSaved: (value) {
                                setState(() {
                                    user.phone = value;
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
                                keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 35.0,),
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ButtonTheme(
                                buttonColor: Theme.of(context).primaryColor,
                                minWidth: double.infinity,
                                height: 40.0,
                                child: RaisedButton(
                                    onPressed: () async {
                                        if (_formKey.currentState.validate() ) {
                                            _formKey.currentState.save();
                                            
                                            Map result = await userService.register(user:this.user);

                                            Fluttertoast.showToast(
                                                msg: '${result['message']}',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIos: 1,
                                                fontSize: 16.0
                                            );

                                            if(result['ok'])  {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserActivatePage()));
                                            }

                                        }
                                    },
                                    child: Text(
                                        "Registrate",
                                        style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
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
