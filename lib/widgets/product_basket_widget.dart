import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/basket_model.dart';
import 'package:flutter_scaffold/product_add_basket.dart';
import 'package:flutter_scaffold/services/basket_service.dart';
import 'package:intl/intl.dart';

var format = new NumberFormat("###.0#", "en_US");

class ProductBasketWidget extends StatefulWidget {

    final Basket basket;
    
    ProductBasketWidget({@required this.basket});

    @override
    _ProductBasketWidgetState createState() => _ProductBasketWidgetState();
}

class _ProductBasketWidgetState extends State<ProductBasketWidget>{

    final basketService = new BasketService();
    
    @override
    Widget build(BuildContext context) {
        return Flexible(
            child: ListView.builder(
                itemCount: widget.basket.products == null ? 0  : widget.basket.products.length,
                itemBuilder: (context, index) {
                    Product product = widget.basket.products[index];
                    return _productContent(product: product);
                }
            ),
        );    
    }

    Widget _productContent({Product product}) {
        return Dismissible(
            key: Key(UniqueKey().toString()),
            onDismissed: (direction) {
                this.direcctionDimis(direction: direction , product: product);
            },
            background: Container(
                decoration: BoxDecoration(color: Colors.red),
                padding: EdgeInsets.all(5.0),
                child: Row(
                    children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                        ),
                    ],
                ),
            ),
            secondaryBackground: Container(
                decoration: BoxDecoration(color: Colors.red),
                padding: EdgeInsets.all(5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                        ),

                    ],
                ),
            ),
            child: _productItem(product: product),
        );
    }

    void direcctionDimis({direction, Product product}) async {
        Map result = await this.basketService.deleteProduct(product.productId);

        Scaffold.of(context).showSnackBar(SnackBar(content: Text(result['message']), duration: Duration(seconds: 2)));
   
       if (result['ok'])
            Navigator.pushReplacementNamed(context, '/cart');

    }

    InkWell _productItem({Product product}) {
        return InkWell(
            onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductAddToBasket(productId: product.productId,)));
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Divider(height: 0),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: ListTile(
                            trailing: Text('\$ ${product.subtotal}'),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue
                                    ),
                                    child: _productImage(productImage: product.productImage),
                                ),
                            ),

                            title: _productItemName(productName: product.productName,amount:product.amount.toString()),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text('Persiana: '+product.categoryName),
                                    Row(
                                        children: <Widget>[
                                            _productPriceAndAmount(price: product.productPrice,category: product.categoryName)
                                        ],
                                    )
                                ],
                            ),
                        ),
                    ),
                ],
            ),
        );
    }

    CachedNetworkImage _productImage({String productImage}) {
        return  CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: productImage,
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator()
            ),
            errorWidget: (context, url, error) => new Icon(Icons.error),
        );
    }

    Text _productItemName({String productName, String amount}) {
        return Text(
            '$productName ($amount)',
            style: TextStyle(
                fontSize: 14
            ),
        );
    }
    
    Padding _productPriceAndAmount({String price, String category}) {
        return Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 1),
            child: Text('Precio:  \$ ${NumberFormat.currency(name:'',decimalDigits: 2).format(double.parse(price))}', 
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 13.0
                )
            ),
        );
    }

}