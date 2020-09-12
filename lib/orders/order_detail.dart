import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/address_model.dart';
import 'package:flutter_scaffold/models/basket_model.dart';
import 'package:flutter_scaffold/models/order_model.dart';
import 'package:flutter_scaffold/services/order_service.dart';
import 'package:flutter_scaffold/widgets/product_basket_widget.dart';

import '../cart.dart';

class OrderDetailPage extends StatefulWidget {

    final int orderId;
    OrderDetailPage({ @required this.orderId});

    @override
    _OrderDetailPageState createState() => _OrderDetailPageState();

}

class _OrderDetailPageState extends State<OrderDetailPage> {
    
    final orderService = new OrderService();
    Basket basket;
    Order orderDetail;
    Address address;
    Map order;
    bool loading = true;

    @override
    void initState() {
        this.getOrder();
    }

    void getOrder() async {

        Map order = await this.orderService.getOrder(orderId: widget.orderId);

        this.basket = Basket.fromJson(order['basket']);
        this.orderDetail = Order.fromJson(order['order']);
        this.address  = Address.fromJson(order['address']);

        setState(() {
            loading = false;
        });
        

    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Detalle de la orden'),
            ),
            body: loading == false 
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        SizedBox(height: 20.0,),
                        Text('Estatus de la orden: ${orderDetail.status}',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20.0,),
                        Text('Fecha: ${orderDetail.createdAt.day}-${orderDetail.createdAt.month}-${orderDetail.createdAt.year} ',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20.0,),
                        Text('Dirección de envio',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 10.0, right: 20.0,bottom: 10.0),
                            child:Text('Calle ${address.calle} entre calle ${address.calle1} y ${address.calle2} N° ${address.nExterior} y N° Interior ${address.nInterior}, Colonia ${address.colonia} ,\n ${address.municipio} ${address.estado} , ${address.codigoPostal} ') ,
                        ),
                        
                        SizedBox(height: 20.0,),
                        Text('Detalle de la orden',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),),
                        
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 20.0, right: 20.0,bottom: 10.0),
                            child: Row(
                                children: <Widget>[
                                    Expanded(
                                        child: Text("TOTAL", style: TextStyle(fontSize: 16, color: Colors.grey),)
                                    ),
                                    Text("${basket.pay.total}",  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 20.0, right: 20.0,bottom: 10.0),
                            child: Row(
                                children: <Widget>[
                                    Expanded(
                                        child: Text("Subtotal", style: TextStyle(fontSize: 16, color: Colors.grey),)
                                    ),
                                    Text("${basket.pay.subtotal}",  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ],
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 20.0, right: 20.0,bottom: 10.0),
                            child: Row(
                                children: [
                                    Expanded(
                                        child: Text("Descuento (${basket.pay.cupon.discount})",style: TextStyle(fontSize: 16, color: Colors.grey)),
                                    ),
                                    Text("${basket.pay.cupon.moneyDiscount}", style: TextStyle(fontSize: 20, color: Colors.grey)),
                                ],
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 20.0, right: 20.0,bottom: 10.0),
                            child: Row(
                                children: [
                                    Expanded(
                                        child: Text("Cupon",style: TextStyle(fontSize: 16, color: Colors.grey)),
                                    ),
                                    Text("${basket.pay.cupon.code}", style: TextStyle(fontSize: 14, color: Colors.grey)),
                                ],
                            ), 
                        ),
                        SizedBox(height: 20.0,),
                        Text('Productos de la orden',style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20.0,),
                        ProductBasketWidget(basket: basket,isCart: false,),
                    ],
                )
                : Center(child: CircularProgressIndicator()),
        );
    }

    Padding _totalProductsCount() {
        return Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Container(
                child: Text(
                    basket.productsCount.toString() + " Producto(s) en la orden".toUpperCase(), 
                    textDirection: TextDirection.ltr, 
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                )
            ),
        );
    }
}