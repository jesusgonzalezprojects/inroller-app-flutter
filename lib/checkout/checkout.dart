import 'package:flutter/material.dart';
import 'package:flutter_scaffold/services/order_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

    bool loading = false;

    final orderService  = new OrderService();
    void bankDeposit() async {
       Map response = await this.orderService.generateOrder();

       print(response);
        
        if (response['ok'])
            Navigator.pushReplacementNamed(context, '/cart');
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
                    Text(
                        "Selecciona una forma de pago",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                        ),
                    ),
                const SizedBox(height: 30.0),
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
                    const SizedBox(height: 20.0),
                
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