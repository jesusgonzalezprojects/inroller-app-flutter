import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Mi cuenta'),
            ),
            body: SafeArea(
                child: Column(
                    children: <Widget>[
                        Container(
                            alignment: Alignment(1, 1),
                            width: MediaQuery.of(context).size.width,
                            height: 190,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://st2.depositphotos.com/1518767/6092/i/450/depositphotos_60926763-stock-photo-handyman-cleaning-blinds-with-a.jpg"
                                    ),
                                ),
                            ),
                            child: Container(
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: new BorderRadius.circular(60),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 32,
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
                                        child: Text(
                                            'Jesús Gonzalez',
                                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                Card(
                                child: ListTile(
                                    leading: Icon(
                                    Icons.notifications,
                                    color: Theme.of(context).accentColor,
                                    size: 28,
                                    ),
                                    title: Text('Ordenes',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 17)),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Theme.of(context).accentColor),
                                ),
                                ),
                                Card(
                                child: ListTile(
                                    leading: Icon(
                                    Icons.card_giftcard,
                                    color: Theme.of(context).accentColor,
                                    size: 28,
                                    ),
                                    title: Text('Cupones',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 17)),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Theme.of(context).accentColor),
                                ),
                                ),
                                Card(
                                child: ListTile(
                                    leading: Icon(
                                    Icons.credit_card,
                                    color: Theme.of(context).accentColor,
                                    size: 28,
                                    ),
                                    title: Text('Monedero',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 17)),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Theme.of(context).accentColor),
                                ),
                                ),
                                Card(
                                child: ListTile(
                                    leading: Icon(
                                    Icons.info,
                                    color: Theme.of(context).accentColor,
                                    size: 28,
                                    ),
                                    title: Text('Acerca de',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 17)),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Theme.of(context).accentColor),
                                ),
                                ),
                                Card(
                                child: ListTile(
                                    leading: Icon(
                                    Icons.vpn_key,
                                    color: Theme.of(context).accentColor,
                                    size: 28,
                                    ),
                                    title: Text('Actualizar contraseña',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 17)),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Theme.of(context).accentColor),
                                ),
                                ),
                                Card(
                                child: ListTile(
                                    leading: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).accentColor,
                                    size: 28,
                                    ),
                                    title: Text('Cerrar sesión',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 17)),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: Theme.of(context).accentColor),
                                ),
                                ),
                            ],
                            ),
                        ),
                ],
            ),
            )
        );
    }
}
