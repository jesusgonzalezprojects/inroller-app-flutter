import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/basket_model.dart';
import 'package:flutter_scaffold/models/wallet_model.dart';
import 'package:flutter_scaffold/orders/order_detail.dart';
import 'package:flutter_scaffold/services/basket_service.dart';
import 'package:flutter_scaffold/services/order_service.dart';
import 'package:flutter_scaffold/services/user_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

    bool loading = false;
    bool checkedValue = false;
    final userService = new UserService();
    final basketService = new BasketService();
    Wallet wallet; 
    Basket basket;

    final orderService  = new OrderService();

    @override
    void initState() {
        this.getWallet();
        this.getBasket();
        super.initState();
    }

    void getWallet() async {
        setState(() {
            loading = true;
        });
        this.wallet = await this.userService.wallet();
    }

    void getBasket() async {
        basket = await this.basketService.fetchBasket();
        setState(() {
            this.loading = false;
        });
    }

    void bankDeposit() async {
        
        Map response = await this.orderService.generateOrder(wallet: checkedValue);
        
        if (response['ok']) {
            Fluttertoast.showToast(
                msg: 'La orden se ha generado correctamente un correo te ha llegado con la referencia bancaria',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 3,
                fontSize: 16.0
            );
            int orderId = response['order_detail']['id'];
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailPage(orderId: orderId,)));
        }
        


    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
            color: Colors.black,
            ),
        ),
        body: loading == false 
            ? SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Image.asset('assets/images/logo_full.png',width: 200.0,),
                      SizedBox(height: 10.0),
                    Text(
                        "Selecciona una forma de pago",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                        ),
                    ),
                    
                    SizedBox(height: 30.0),
                    Text(
                        "Total de la compra: ${basket.pay.total}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                        ),
                    ),
                    
                    double.parse(wallet.amount) >  0 ? CheckboxListTile(
                        title: Text("Descontar de monedeor: ${wallet.amountHumans}"),
                        value: checkedValue,
                        onChanged: (newValue) { 
                            setState(() {
                                checkedValue = !checkedValue;
                            });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ) : Text(''),
                    RoundedContainer(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            leading: Icon(
                            FontAwesomeIcons.paypal,
                                
                            ),
                            title: Text("Paypal"),
                            trailing: Icon(Icons.arrow_forward_ios),
                        ),
                    ),
                    RoundedContainer(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: Icon(
                        FontAwesomeIcons.creditCard,
                        
                        ),
                        title: Text("Tarjeta credito / debito"),
                        trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ),
                    InkWell(
                        onTap: () {
                            this.bankDeposit();
                        },
                        child: RoundedContainer(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            leading: Icon(
                            FontAwesomeIcons.fileArchive,
                            
                            ),
                            title: Text("Deposito bancario"),
                            trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        ),
                    ),
                    SizedBox(height: 20.0),
                
                ],
            ),
        ) : Center(child: CircularProgressIndicator(),),
        );
    }

}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key key,
    @required this.child,
    this.height,
    this.width,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.borderRadius,
    this.alignment,
    this.elevation,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final AlignmentGeometry alignment;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(0),
      color: color,
      elevation: elevation ?? 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: alignment,
        height: height,
        width: width,
        padding: padding,
        child: child,
      ),
    );
  }
}