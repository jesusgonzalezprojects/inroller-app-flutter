import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/product_detail.dart';
import 'package:flutter_scaffold/services/product_service.dart';
import 'package:flutter_scaffold/shop/search.dart';

import 'models/category_model.dart';
import 'models/product_model.dart';

class ProductCategoryPage extends StatefulWidget {
    final double minPrice,maxPrice;
    final bool toFilter;
    final CategoriesList category;

    const ProductCategoryPage({Key key, this.minPrice, this.maxPrice, this.toFilter, this.category}) : super(key: key);
    @override
    _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage>{
    


    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    final productService = new ProductService();
    List<ProductsList> productsList;
    bool loading = true;

    @override
    void initState() {
        
        this.getProducts();

    }

    void getProducts() async {
        
        productsList = await this.productService.fetchProductByCategory(category_id: widget.category.id);

        setState(() {
            loading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
           key: scaffoldKey,
            appBar: AppBar(
                actions: <Widget>[
                    IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                         scaffoldKey.currentState
                    .showBottomSheet((context) => ShopSearch());
                    },
                    )
                ],
                title: Text('Telas disponibles'),
            ),
            body: loading == false ? Column(
                children: [
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Persiana: ${widget.category.category}',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.normal),),
                    ),
                    Image.network(widget.category.image,fit: BoxFit.cover,),
                    SizedBox(height: 10.0,),
                    Expanded(
                        child:Container(
                            child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            padding: EdgeInsets.only(top: 2, left: 2, right: 0, bottom: 12),
                            children: List.generate(productsList.length, (index) {
                                ProductsList product = productsList[index];
                                return Container(
                                child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: InkWell(
                                    onTap: () {
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Products(productId: product.id)));
                                    },
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                        SizedBox(
                                            height: (MediaQuery.of(context).size.width / 2 - 20),
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: product.productImage,
                                            placeholder: (context, url) => Center(
                                                child: CircularProgressIndicator()
                                            ),
                                            errorWidget: (context, url, error) => new Icon(Icons.error),
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 3.0),
                                            child: ListTile(
                                            title: Text(
                                                product.product,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10
                                                ),
                                            ),
                                            subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                Row(
                                                    children: <Widget>[
                                                    Padding(
                                                        padding: const EdgeInsets.only(top: 0.0),
                                                        child: Text('\$ ${product.productPrice}', style: TextStyle(
                                                        color: Theme.of(context).accentColor,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.normal,
                                                        )),
                                                    ),
                                                    
                                                    
                                                    ],
                                                ),
                                                Row(
                                                    children: <Widget>[
                                                   
                                                    Padding(
                                                        padding: const EdgeInsets.only(left: 0.0),
                                                        child: Text('Cortina: ${product.category}', style: TextStyle(
                                                            fontWeight: FontWeight.w300,
                                                            color: Theme.of(context).primaryColor,
                                                            fontSize: 10.0
                                                        )),
                                                    )
                                                    ],
                                                )
                                                ],
                                            ),
                                            ),
                                        )
                                        ],
                                    ),
                                    ),
                                ),
                                );
                            }),
                            ),
                        ),                     
                    )
                ],
            ) : Center(child: CircularProgressIndicator()),
        );
    }
}