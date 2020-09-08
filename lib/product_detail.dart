import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/product_model.dart';
import 'package:flutter_scaffold/product_add_basket.dart';
import 'package:flutter_scaffold/services/product_service.dart';

class Products extends StatefulWidget {

    final int productId;

    Products({@required this.productId});

    @override
    _ProductsState createState() => _ProductsState();

}

class _ProductsState extends State<Products> {

    final productService = new ProductService();
    ProductsList product;
    bool loading = true;

    @override
    void initState() {
        this.getProduct();
    }

    void getProduct() async {
        product = await this.productService.fetchProduct(widget.productId);
        setState(() {
            loading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Detalle de la tela'),
            ),
            body: SafeArea(
                top: false,
                left: false,
                right: false,
                child: loading == false ? SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                            SizedBox(
                                width: double.infinity,
                                height: 260,
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
                                    children: <Widget>[
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
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    Row(
                                                        children: <Widget>[
                                                            Padding(
                                                                padding: const EdgeInsets.only(right: 0.0),
                                                                child: Text(
                                                                    'Precio: \$ ${product.productPrice} x Mtr²',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context).primaryColor,
                                                                        fontSize: 18,
                                                                        fontWeight: FontWeight.w600,
                                                                    ),
                                                                ),
                                                            ),
                                                            
                                                        ],
                                                    ),
                                                    
                                                ],
                                            ),
                                        ),
                                       
                                        Column(
                                            children: <Widget>[
                                                Container(
                                                    alignment: Alignment(-1.0, -1.0),
                                                    child: Padding(
                                                        padding: const EdgeInsets.only(bottom: 10.0),
                                                        child: Text(
                                                            'Descripción',
                                                        style: TextStyle(color: Colors.black, fontSize: 20,  fontWeight: FontWeight.w600),
                                                        ),
                                                    )
                                                ),
                                                Container(
                                                    alignment: Alignment(-1.0, -1.0),
                                                    child: Padding(
                                                        padding: const EdgeInsets.only(bottom: 10.0),
                                                        child: Text(
                                                            product.productDescription,
                                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                                        ),
                                                    )
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                    alignment: Alignment(-1.0, -1.0),
                                                    child: Padding(
                                                        padding: const EdgeInsets.only(bottom: 10.0),
                                                        child: Text(
                                                            'Cortina : ${product.category}',
                                                        style: TextStyle(color: Colors.black, fontSize: 20,  fontWeight: FontWeight.w600),
                                                        ),
                                                    )
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                    alignment: Alignment(-1.0, -1.0),
                                                    child: Hero(
                                                        tag: product.categoryId,
                                                        child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl: product.categoryImage,
                                                            height: 250.0,
                                                            width: double.infinity,
                                                            placeholder: (context, url) =>
                                                                Center(child: CircularProgressIndicator()),
                                                            errorWidget: (context, url, error) => new Icon(Icons.error),
                                                        ),
                                                    )
                                                ),
                                                SizedBox(height: 4.0,),
                                                
                                            ],
                                        ),
                                    ],
                                ),
                            )
                        ],
                    ),
                ) : Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ButtonTheme(
                      buttonColor: Theme.of(context).primaryColor,
                      minWidth: double.infinity,
                      height: 40.0,
                      child: RaisedButton(
                      onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductAddToBasket(productId: product.id,)));
                      },
                      child:Text("Agregar al carrito".toUpperCase(),style: TextStyle(color: Colors.white, fontSize: 16),)
                    ),
                ),
            ),
        );
    }
}
