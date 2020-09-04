import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/basket_model.dart';
import 'package:flutter_scaffold/services/basket_service.dart';
import 'package:flutter_scaffold/widgets/product_basket_widget.dart';


final basketService = new BasketService();

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {


    final basketService = new BasketService();
    final _formKey = GlobalKey<FormState>();

    bool initialScreen = false;
    Basket basket;

    @override
    void initState() {
        this.getBasket();
        super.initState();
    }

    void getBasket() async {
        basket = await this.basketService.fetchBasket();
        setState(() {
            this.initialScreen = true;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Carrito de compras'),
            ),
            body: this.initialScreen ? Column(
                children: <Widget>[
                    
                    _totalProductsCount(),

                    ProductBasketWidget(basket: basket),

                    BasketInformationPay(pay: basket.pay,hasDiscount: basket.hasDiscount),
                    
                    _buttonFinishSale()
                    
                ],
            ) : Center(child: CircularProgressIndicator(),)
        );
    }

    Padding _totalProductsCount() {
        return Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Container(
                child: Text(
                    basket.productsCount.toString() + " Producto(s) en el carrito".toUpperCase(), 
                    textDirection: TextDirection.ltr, 
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                )
            ),
        );
    }

    Padding _buttonFinishSale()  {
        return Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
            child: ButtonTheme(
                buttonColor: Theme.of(context).primaryColor,
                minWidth: double.infinity,
                height: 40.0,
                child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                        "TERMINAR COMPRA",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                ),
            ),
        );
    }

   
}

class BasketInformationPay extends StatefulWidget {

    final Pay pay;
    final bool hasDiscount;

    BasketInformationPay({@required this.pay, @required this.hasDiscount});

    @override
    _BasketInformationPayState createState() => _BasketInformationPayState();

}

class _BasketInformationPayState extends State<BasketInformationPay> {
    

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20,top: 10.0),
                child: Column(
                    children: [
                        _payTotal(),
                        _paySubtotal(),
                        widget.hasDiscount ? DiscountBasket(cupon: widget.pay.cupon) : AddDiscountBasket()
                    ],
                ),
            ) ,
        );
    }

    Padding _payTotal() {
        return Padding(
            padding: const EdgeInsets.only(bottom :10.0),
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Text("TOTAL", style: TextStyle(fontSize: 16, color: Colors.grey),)
                    ),
                    Text("${widget.pay.total}",  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
            ),
        );
    }

    Padding _paySubtotal() {
        return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
                children: <Widget>[
                Expanded(child: Text("Subtotal", style: TextStyle(fontSize: 14))),
                    Text("${widget.pay.subtotal}", style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
            ),
        );
    }
}

class DiscountBasket extends StatefulWidget {

    final Cupon cupon;

    const DiscountBasket({@required this.cupon});

    @override
    _DiscountBasketState createState() => _DiscountBasketState();
}

class _DiscountBasketState extends State<DiscountBasket>{

    bool loading = false;

    void deleteCoupon() async {

        setState(() {
            loading = true;
        });

        Map response = await basketService.removeCoupon();

        await Scaffold.of(context).showSnackBar(SnackBar(content: Text(response['message']), duration: Duration(seconds: 2)));

        setState(() {
            loading = false;
        });

        if (response['ok'])
            Navigator.pushReplacementNamed(context, '/cart');
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Column(
                    children: [
                        _discountMoney(),
                        _couponCodeDiscount(),
                        _deleteCoupon()
                    ],
                ),
            ),
        );
    }

    Padding _discountMoney() {
        return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
                children: [
                    Expanded(
                        child: Text("Descuento (${widget.cupon.discount})"),
                    ),
                    Text("${widget.cupon.moneyDiscount}", style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
            ),
        );
    }

    Padding _couponCodeDiscount()  {
        return  Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
                children: [
                    Expanded(
                        child: Text("Cupon"),
                    ),
                    Text("${widget.cupon.code}", style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
            ), 
        );
    }

    Padding _deleteCoupon() {
        return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: ButtonTheme(
                buttonColor: Theme.of(context).primaryColor,
                minWidth: double.infinity,
                height: 40.0,
                child: RaisedButton(
                    onPressed: () {
                        this.deleteCoupon();
                    },
                    child: loading == false 
                        ? Text("ELIMINAR CUPON",style: TextStyle(color: Colors.white, fontSize: 16),)
                        : Center(child: CircularProgressIndicator())
                ),
            )
        );
    }
}

class AddDiscountBasket extends StatefulWidget {
    @override
    _AddDiscountBasketState createState() => _AddDiscountBasketState();
}

class _AddDiscountBasketState extends State<AddDiscountBasket> {

  
    final _formKey = GlobalKey<FormState>();
    String couponCode;
    bool loading = false;

    void addDiscount() async {
        
        if (_formKey.currentState.validate()) {
            
            _formKey.currentState.save();

            setState(() {
                loading = true;
            });

            Map response = await basketService.addCoupon(cupon_code:this.couponCode);

            await Scaffold.of(context).showSnackBar(SnackBar(content: Text(response['message']), duration: Duration(seconds: 2)));

            setState(() {
                loading = false;
            });

            if (response['ok'])
                Navigator.pushReplacementNamed(context, '/cart');

        }

    }

    @override
    Widget build(BuildContext context) {
        return Center(
            child: _formDiscount(),
        );
    }

     Form _formDiscount() {
        return Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            _fieldCoupon(),
                            _buttonAdd()
                        ],
                    ),
                ),
            ),
        );
    }

    Padding _fieldCoupon(){
        return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                    if (value.isEmpty) {
                        return 'Por favor ingresa el codigo del cupón';
                    }
                    return null;
                },
                onSaved: (value) {
                    setState(() {
                        this.couponCode = value;
                    });
                },
                decoration: InputDecoration(
                    hintText: 'Ingresa el codigo del cupón',
                    labelText: 'Cupón de descuento',
                ),
            ),
        );
    }

    Padding _buttonAdd()  {
        return Padding(
            padding: const EdgeInsets.all(0.0),
            child: ButtonTheme(
                buttonColor: Theme.of(context).primaryColor,
                minWidth: double.infinity,
                height: 40.0,
                child: RaisedButton(
                onPressed: () {
                    this.addDiscount();
                },
                child: this.loading == false 
                    ? Text("Agregar cupon".toUpperCase(),style: TextStyle(color: Colors.white, fontSize: 16),) 
                    : Center(child: CircularProgressIndicator()),
                ),
            ),
        );
    }
}