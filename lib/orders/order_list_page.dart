import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/order_model.dart';
import 'package:flutter_scaffold/orders/order_detail.dart';
import 'package:flutter_scaffold/services/order_service.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>{

    final orderService = new OrderService();
    List<Order> orders;
    bool loading = true;
    @override
    void initState() {
        this.getOrders();
    }

    void getOrders() async {
        this.orders = await this.orderService.fetchOrders();
        setState(() {
            loading = false;
        });
    }


    @override
    Widget build(BuildContext context) {
        return  Scaffold(
            appBar: AppBar(
                title: Text('Mis ordenes'),
            ),
            body: loading == false 
                ? _ordersList() 
                : Center(child: CircularProgressIndicator()),
        );
    }

    Widget _ordersList() {
        return SafeArea(
            top: false,
            left: false,
            right: false,
            child: Container(
                child: ListView.builder(
                    itemCount: this.orders ==  null ? 0 : this.orders.length,
                    itemBuilder: (BuildContext context , int index) {
                        Order order = this.orders[index];
                        return Container(
                            child: Card(
                                child: ListTile(
                                    onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailPage(orderId: order.id)));
                                    },
                                    leading: Icon(
                                        Icons.check,
                                        color: Theme.of(context).accentColor,
                                        size: 28,
                                    ),
                                    title: Text('${order.id} - \$ ${order.total}',
                                        style:TextStyle(color: Colors.black, fontSize: 17)
                                    ),
                                    subtitle:  Text('Estatus: ${order.status}'),
                                    
                                    trailing: Icon(Icons.details, color: Theme.of(context).accentColor, ) 
                                ),
                            ),
                        );
                    },
                ),
            ),
        );
    }
}