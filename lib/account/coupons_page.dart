import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/coupon_model.dart';
import 'package:flutter_scaffold/services/coupon_service.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage>{

    final couponService = new CouponService();
    bool loading = true;

    List<Coupon> coupons;
    @override
    void initState() {
        this.getCoupons();
    }

    void getCoupons() async {
        this.coupons = await this.couponService.fetchCoupons();
        setState(() {
            loading = false;
        });
    }

    void addCoupon() async {
        
        Map  result = await this.couponService.addCoupon();

        Fluttertoast.showToast(
            msg: "${result['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            fontSize: 16.0
        );

        setState(() {
            loading = true;
        });

        this.coupons = await this.couponService.fetchCoupons();
        
        setState(() {
            loading = false;
        });



    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Mis cupones'),
            ),
            body: loading == false
                ? _coupons() 
                : Center(child:CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    this.addCoupon();
                },
                child: Icon(Icons.card_giftcard),
            
            ),
        );   
    }

    Future<void> share(String coupon) async {
        await FlutterShare.share(
            title: 'Cupon de descuento',
            text: 'Inroller - Utiliza este cupon de descuento $coupon en tu siguiente compra de persianas.'
        );
    }

    Widget _coupons() {
        return SafeArea(
            top: false,
            left: false,
            right: false,
            child: Container(
                child: ListView.builder(
                    itemCount: coupons ==  null ? 0 : coupons.length,
                    itemBuilder: (BuildContext context , int index){
                        Coupon coupon = this.coupons[index];
                        return Container(
                            child: Card(
                                
                                child: ListTile(
                                    onTap: (){
                                        this.share(coupon.code);
                                    },
                                    leading: Icon(
                                        Icons.card_giftcard,
                                        color: Theme.of(context).accentColor,
                                        size: 28,
                                    ),
                                    title: Text('${coupon.code}',
                                        style:TextStyle(color: Colors.black, fontSize: 17)
                                    ),
                                    subtitle: coupon.status ? Text('Descuento del ${coupon.discount} %') : Text('Cupon Inactivo'),
                                    trailing: coupon.subscription == false 
                                        ? Icon(Icons.share, color: Theme.of(context).accentColor, ) 
                                        : Icon(Icons.not_interested, color: Theme.of(context).accentColor ),
                                ),
                            ),
                        );
                    }
                ),
            ),
        );
    }
}