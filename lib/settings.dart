import 'package:flutter/material.dart';
import 'package:flutter_scaffold/account/address_page.dart';
import 'package:flutter_scaffold/account/coupons_page.dart';
import 'package:flutter_scaffold/models/user_model.dart';
import 'package:flutter_scaffold/services/user_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

    final userService = new UserService();
    
    ProfileUser user;
    bool loading = true;
    @override
    void initState() {
        this.getProfile();
    }

    void getProfile() async {
        this.user = await this.userService.profile();
        setState(() {
            loading = false;
        });
    }

    void subscribeOrUnsuscribe() async {
            
        Map result = await this.userService.subscribeOrUnSubscribe();

        Fluttertoast.showToast(
            msg: '${result['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            fontSize: 16.0
        );

        if (result['ok']) {
            Navigator.pushReplacementNamed(context, '/settings');
        }
        

    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Mi cuenta'),
            ),
            body: loading == false
                ? SafeArea(
                child: Column(
                    children: <Widget>[
                        Container(
                            alignment: Alignment(1, 1),
                            width: MediaQuery.of(context).size.width,
                            height: 190,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/images/6.jpg')
                                ),
                            ),
                            child: Container(
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: new BorderRadius.circular(60),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                    onTap: () {
                                        Navigator.pushNamed(context, '/cart');
                                    },
                                    child: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                        size: 32
                                    ),
                                ),
                            ),
                        ),
                        Column(
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(bottom: 0),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300],
                                                width: 1.0,
                                            )
                                        ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15, left: 15, right: 15
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${this.user.name} ',
                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                            ),
                                            user.subscription != null 
                                                ?Text(
                                                      'Miembro inroller',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                   
                                                )
                                                :  InkWell(
                                                    onTap: (){
                                                        this.subscribeOrUnsuscribe();
                                                    },
                                                    child: Text(
                                                        'Suscribirse',
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                    ),
                                                )
                                          ],
                                         
                                        ),
                                    ),
                                )
                            ],
                        ),
                        Expanded(
                            child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                    Card(
                                        child: ListTile(
                                            leading: Icon(
                                            Icons.edit,
                                            color: Theme.of(context).accentColor,
                                            size: 28,
                                            ),
                                            title: Text('Mis datos',
                                                style:
                                                    TextStyle(color: Colors.black, fontSize: 17)),
                                            trailing: Icon(Icons.keyboard_arrow_right,
                                                color: Theme.of(context).accentColor),
                                        ),
                                    ),
                                    InkWell(
                                        onTap: (){
                                            Navigator.pushNamed(context,'/orders');
                                        },
                                        child: Card(
                                            child: ListTile(
                                                leading: Icon(
                                                    Icons.check,
                                                    color: Theme.of(context).accentColor,
                                                    size: 28,
                                                ),
                                                title: Text('Ordenes',style:TextStyle(color: Colors.black, fontSize: 17)),
                                                trailing: Icon(Icons.keyboard_arrow_right,color: Theme.of(context).accentColor),
                                            ),
                                        ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CouponPage()));
                                        },
                                        child: Card(
                                            child: ListTile(
                                                leading: Icon(
                                                    Icons.card_giftcard,
                                                    color: Theme.of(context).accentColor,
                                                    size: 28,
                                                ),
                                                title: Text('Cupones',
                                                    style:TextStyle(color: Colors.black, fontSize: 17)
                                                ),
                                                trailing: Icon(Icons.keyboard_arrow_right,
                                                    color: Theme.of(context).accentColor
                                                ),
                                            ),
                                        ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                            Navigator.pushNamed(context, '/wallet');
                                        },
                                        child: Card(
                                            child: ListTile(
                                                leading: Icon(
                                                    Icons.credit_card,
                                                    color: Theme.of(context).accentColor,
                                                    size: 28,
                                                ),
                                                title: Text('Monedero',style:TextStyle(color: Colors.black, fontSize: 17)),
                                                trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).accentColor), 
                                            ),
                                        ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                        },
                                        child: Card(
                                            child: ListTile(
                                                leading: Icon(
                                                    Icons.place,
                                                    color: Theme.of(context).accentColor,
                                                    size: 28,
                                                ),
                                                title: Text('Direcciónes',style:TextStyle(color: Colors.black, fontSize: 17)),
                                                trailing: Icon(Icons.keyboard_arrow_right,color: Theme.of(context).accentColor),
                                            ),
                                        ),
                                    ),
                                    Card(
                                        child: ListTile(
                                            leading: Icon(
                                                Icons.vpn_key,
                                                color: Theme.of(context).accentColor,
                                                size: 28,
                                            ),
                                            title: Text('Actualizar contraseña',style:TextStyle(color: Colors.black, fontSize: 17)),
                                            trailing: Icon(Icons.keyboard_arrow_right,color: Theme.of(context).accentColor),
                                        ),
                                    ),
                                    Card(
                                        child: ListTile(
                                            leading: Icon(
                                                Icons.lock,
                                                color: Theme.of(context).accentColor,
                                                size: 28,
                                            ),
                                            title: Text('Cerrar sesión',style:TextStyle(color: Colors.black, fontSize: 17)),
                                            trailing: Icon(Icons.keyboard_arrow_right,color: Theme.of(context).accentColor),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ) : Center(child: CircularProgressIndicator())
        );
    }
}
