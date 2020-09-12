import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/services/user_service.dart';

import 'models/user_model.dart';
import 'models/wallet_model.dart';
//import 'package:share/share.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

    List<Color> _backgroundColor;
    Color _iconColor;
    Color _textColor;
    List<Color> _actionContainerColor;
    Color _borderContainer;
    bool colorSwitched = false;
    var logoImage;

    final userService = new UserService();
    Wallet wallet;
    ProfileUser user;
    bool loading = true;

    

    void changeTheme() async {
        if (colorSwitched) {
        setState(() {
            logoImage = 'assets/images/logo_full.png';
            _backgroundColor = [
                Color.fromRGBO(240, 117, 94, 1),
                Color.fromRGBO(240, 117, 94, 1),
                Color.fromRGBO(240, 117, 94, 1),
                Color.fromRGBO(240, 117, 94, 1),
            ];
            _iconColor = Colors.white;
            _textColor = Color.fromRGBO(253, 211, 4, 1);
            _borderContainer = Color.fromRGBO(34, 58, 90, 0.2);
            _actionContainerColor = [
                Color.fromRGBO(240, 117, 94, 1),
                Color.fromRGBO(240, 117, 94, 1),
                Color.fromRGBO(240, 117, 94, 1),
                Color.fromRGBO(240, 117, 94, 1),
            ];
        });
        } else {
        setState(() {
            logoImage = 'assets/images/logo_full.png';
            _borderContainer =  Color.fromRGBO(249, 249, 249, 1);
            _backgroundColor = [
            Color.fromRGBO(249, 249, 249, 1),
            Color.fromRGBO(241, 241, 241, 1),
            Color.fromRGBO(233, 233, 233, 1),
            Color.fromRGBO(222, 222, 222, 1),
            ];
            _iconColor = Colors.black;
            _textColor = Colors.black;
            _actionContainerColor = [
            Color.fromRGBO(255, 212, 61, 1),
            Color.fromRGBO(255, 212, 55, 1),
            Color.fromRGBO(255, 211, 48, 1),
            Color.fromRGBO(255, 211, 43, 1),
            ];
        });
        }
    }

    @override
    void initState() {
        changeTheme();
        this.getWallet();
        super.initState();
    }

    void getWallet() async {
        this.wallet = await this.userService.wallet();
        this.user = await this.userService.profile();
        setState(() {
            loading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: loading == false 
                ? SafeArea(
                child: GestureDetector(
                    onLongPress: () {
                        if (colorSwitched) {
                        colorSwitched = false;
                        } else {
                        colorSwitched = true;
                        }
                        changeTheme();
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.2, 0.3, 0.5, 0.8],
                                colors: _backgroundColor
                            )
                        ),
                        child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            SizedBox(height: 20.0,),
                            Image.asset(
                                logoImage,
                                fit: BoxFit.contain,
                                height: 200.0,
                                width: 200.0,
                            ),
                            Column(
                                children: <Widget>[
                                    Text('Hola ',style: TextStyle(fontSize: 18, color: Colors.black),),
                                    Text('${user.name}',style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),)
                                ],
                            ),
                            Container(
                            height: 300.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: _borderContainer,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        stops: [0.2, 0.4, 0.6, 0.8],
                                        colors: _actionContainerColor)),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                    Container(
                                        height: 70,
                                        child: Center(
                                        child: ListView(
                                            children: <Widget>[
                                            InkWell(
                                                onTap: () {
                                                this.shared(context);
                                                },
                                                child:Text(
                                                '${wallet.amountHumans}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: _textColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                            ) ,
                                            ),
                                            
                                            Text(
                                                'Disponibles en monedero',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: _iconColor, fontSize: 16),
                                            ),
                                            ],
                                        ),
                                        ),
                                    ),
                                    Divider(
                                        height: 0.5,
                                        color: Colors.grey,
                                    ),
                                    Table(
                                        border: TableBorder.symmetric(
                                        inside: BorderSide(
                                            color: Colors.grey,
                                            style: BorderStyle.solid,
                                            width: 0.5),
                                        ),
                                        children: [
                                        TableRow(children: [
                                            _actionList(
                                                'assets/images/ic_send.png', 'Cambios'),
                                            _actionList(
                                                'assets/images/ic_money.png', 'Compras'),
                                        ]),
                                        TableRow(children: [
                                            _actionList('assets/images/ic_transact.png',
                                                'Transacciones'),
                                            _actionList('assets/images/ic_reward.png',
                                                'Recompensas'),
                                        ])
                                        ],
                                    ),
                                    ],
                                ),
                                ),
                            ),
                            )
                        ],
                    ),
                ),
                ),
            ) : Center(child: CircularProgressIndicator(),),
        );
    }

    // custom action widget
    Widget _actionList(String iconPath, String desc) {
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Image.asset(
                iconPath,
                fit: BoxFit.contain,
                height: 45.0,
                width: 45.0,
                color: _iconColor,
            ),
            SizedBox(
                height: 8,
            ),
            Text(
                desc,
                style: TextStyle(color: _iconColor),
            )
            ],
        ),
        );
    }
    void shared(BuildContext context) {
       
    }
}
