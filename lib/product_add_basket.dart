import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/cart.dart';
import 'package:flutter_scaffold/services/product_service.dart';

import 'models/product_model.dart';

class ProductAddToBasket extends StatefulWidget {

    final int productId;

    const ProductAddToBasket({@required this.productId});

    @override
    _ProductAddToBasketState createState() => _ProductAddToBasketState();
}

class _ProductAddToBasketState extends State<ProductAddToBasket> {
    

    final productService = new ProductService();
    final _formKey = GlobalKey<FormState>();
    String width,height,amount;
    String messageError;
    ProductsList product;
    bool loading = true;
    bool showError= false;

    @override
    void initState() {
        this.getProduct();
    }

    void getProduct() async {
        product = await this.productService.fetchProduct(widget.productId);
        print(product);
        setState(() {
            loading = false;
        });
    }

    void addToBasket(BuildContext context) async {
         if (_formKey.currentState.validate()) {
            
            _formKey.currentState.save();

            setState(() {
                loading = true;
            });

            Map data = {
                'product_id':product.id,
                'height':double.parse(height),
                'width':double.parse(this.width),
                'amount':int.parse(this.amount != null ? this.amount : 1),
                'user_id':1
            };

            Map response = await basketService.addProduct(data:data);

            //Scaffold.of(context).showSnackBar(SnackBar(content: Text(response['message']), duration: Duration(seconds: 2)));

            setState(() {
                loading = false;
            });

            if (response['ok'])
                Navigator.pushReplacementNamed(context, '/cart');
            else{
                setState(() {
                    messageError = response['instructions'];
                    showError = true;
                });
            }

        }

    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Agregar al carrito'),
            ),
            body: loading == false 
                ? _product()
                : Center(child: CircularProgressIndicator()),
        );
    }


    Widget _product(){
        return SingleChildScrollView(
            child: Column(
                children: [
                    SizedBox(
                        width: double.infinity,
                        height: 210,
                        child: Hero(
                            tag: product.id,
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: product.productImage,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                            ),
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                            children: [
                                Container(
                                    alignment: Alignment(-1.0, -1.0),
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                                        child: Text(
                                            product.product,
                                            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: Text(
                                        'Selecciona las medicas de la tela',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                        ),
                                    ),
                                ),
                                SizedBox(height: 10.0,),
                                showError ? Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: Text(
                                        '$messageError , Ancho: ${product.productWidth} CM , Precio: \$ ${product.productPrice}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                        ),
                                    ),
                                ) : Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: Text(
                                        'Ancho: ${product.productWidth} CM | Precio: \$ ${product.productPrice} MXN',
                                        style: TextStyle(
                                            
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                        ),
                                    ),
                                ),
                                _formDiscount()
                            ],
                        ),
                    ),
                    
                ],
            ),
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
                            _fieldWidth(),
                            _fieldHeight(),
                            _fieldamount(),
                            _buttonAdd()
                        ],
                    ),
                ),
            ),
        );
    }

    Widget _fieldWidth() {
        return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                    if (value.isEmpty) {
                        return 'Por favor ingresa el ancho de la tela';
                    }
                    return null;
                },
                onSaved: (value) {
                    setState(() {
                        this.width = value;
                    });
                },
                decoration: InputDecoration(
                    hintText: 'Ingresa el ancho de la tela (CM)',
                    labelText: 'Ancho de la tela',
                ),
            ),
        );
    }
    Widget _fieldHeight() {
        return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                    if (value.isEmpty) {
                        return 'Por favor ingresa el largo de la tela (CM)';
                    }
                    return null;
                },
                onSaved: (value) {
                    setState(() {
                        this.height = value;
                    });
                },
                decoration: InputDecoration(
                    hintText: 'Ingresa el largo de la tela (CM)',
                    labelText: 'Largo de la tela',
                ),
            ),
        );
    }

     Widget _fieldamount() {
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
                        this.amount = value;
                    });
                },
                decoration: InputDecoration(
                    hintText: 'Ingresa la cantidad de telas',
                    labelText: 'Cantidad',
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
                    this.addToBasket(context);
                },
                child: this.loading == false 
                    ? Text("Agregar".toUpperCase(),style: TextStyle(color: Colors.white, fontSize: 16),) 
                    : Center(child: CircularProgressIndicator()),
                ),
            ),
        );
    }

    
}