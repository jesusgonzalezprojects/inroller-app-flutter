import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/models/category_model.dart';
import 'package:flutter_scaffold/models/product_model.dart';
import 'package:flutter_scaffold/products_category.dart';
import 'package:flutter_scaffold/services/category_service.dart';
import 'package:flutter_scaffold/services/product_service.dart';

import '../product_detail.dart';
import 'drawer.dart';
import 'slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    final productsLimit =  6;
    final productsService = new ProductService();
    List<ProductsList> products;
    bool loadingProducts = false;

    @override
    void initState() {
        this.fetchProducts();
    }

    void fetchProducts(  ) async {
        products = await this.productsService.fetchProductsLimit(limit: this.productsLimit);
        setState(() {
            loadingProducts = true;
        });
    }
    final categoryService = new CategoryService();

    AppBar _appBar () {
        return AppBar(
            backgroundColor: Colors.white,
            title: Image.asset('assets/images/logo_full.png',
                width: 250.0, height: 55.0
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                  },
                  tooltip: "Carrito de compras",
              ),
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: _appBar(),
            drawer: Drawer(
                child: AppDrawer(),
            ),
            body: CustomScrollView(
                    slivers: <Widget>[
                    SliverAppBar(
                       actions: <Widget>[
                         
                      ],
                        
                        backgroundColor: Colors.white,
                        flexibleSpace: HomeSlider(),
                        expandedHeight: 300,
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0, left: 8.0, right: 8.0),
                                            child: Text('Persianas disponibles'.toUpperCase(),
                                                style: TextStyle(
                                                    color: Theme.of(context).accentColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700)),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, top: 8.0, left: 8.0),
                                            child: RaisedButton(
                                                color: Theme.of(context).primaryColor,
                                                child: Text('Ver mas',
                                                    style: TextStyle(color: Colors.white)),
                                                onPressed: () {
                                                Navigator.pushNamed(context, '/categorise');
                                                }),
                                        )
                                        ],
                                    ),
                                    FutureBuilder(
                                        future: categoryService.fetchCategories(),
                                        builder:
                                            (BuildContext context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                            List<CategoriesList> categories = snapshot.data;
                                            return GridView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: categories.length,
                                            padding: EdgeInsets.only(
                                                top: 8, left: 6, right: 6, bottom: 12),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2),
                                            itemBuilder: (BuildContext context, int index) {
                                                CategoriesList category = categories[index];
                                                return Container(
                                                child: Card(
                                                    clipBehavior: Clip.antiAlias,
                                                    child: InkWell(
                                                    onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductCategoryPage(maxPrice: 0,minPrice: 0,category: category,toFilter: false,)));
                                                    },
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                        SizedBox(
                                                            height: (MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2) -
                                                                70,
                                                            width: double.infinity,
                                                            child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl: category.image,
                                                            placeholder: (context, url) => Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                            errorWidget:
                                                                (context, url, error) =>
                                                                    new Icon(Icons.error),
                                                            ),
                                                        ),
                                                        ListTile(
                                                            title: Text(
                                                            '${category.category}',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 16),
                                                        ))
                                                        ],
                                                    ),
                                                    ),
                                                ),
                                                );
                                            },
                                            );
                                        }
                                        return Center(child: CircularProgressIndicator());
                                        },
                                    ),
                                    Container(
                                        child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 6.0, left: 8.0, right: 8.0, bottom: 10),
                                        child: Image(
                                            fit: BoxFit.cover,
                                            image: AssetImage('assets/images/banner-2.png'),
                                        ),
                                        ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                                        child: Text('Lo ultimo en inroller'.toUpperCase(),
                                            style: TextStyle(
                                                color: Theme.of(context).accentColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                    ),
                                    loadingProducts ? Container(
                                        margin: EdgeInsets.symmetric(vertical: 8.0),
                                        height: 240.0,
                                        child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: products.map((ProductsList product) {
                                            return Builder(
                                            builder: (BuildContext context) {
                                                return Container(
                                                width: 140.0,
                                                child: Card(
                                                    clipBehavior: Clip.antiAlias,
                                                    child: InkWell(
                                                    onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Products(productId: product.id)));
                                                    },
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                        SizedBox(
                                                            height: 160,
                                                            child: Hero(
                                                            tag: product.id,
                                                            child: CachedNetworkImage(
                                                                fit: BoxFit.cover,
                                                                imageUrl: product.productImage,
                                                                placeholder: (context, url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget:
                                                                    (context, url, error) =>
                                                                        new Icon(Icons.error),
                                                            ),
                                                            ),
                                                        ),
                                                        ListTile(
                                                            title: Text(
                                                            '${product.product}',
                                                            style: TextStyle(fontSize: 14),
                                                            ),
                                                            subtitle: Text('\$ ${product.productPrice}',
                                                                style: TextStyle(
                                                                    color: Theme.of(context)
                                                                        .accentColor,
                                                                    fontWeight:
                                                                        FontWeight.w700)),
                                                        )
                                                        ],
                                                    ),
                                                    ),
                                                ),
                                                );
                                            },
                                            );
                                        }).toList(),
                                        ),
                                    ) : Center(child: CircularProgressIndicator(),),
                                   
                                ],
                            ),
                            childCount: 1,
                        ),
                    )
                ]
            ),
        );
    }
}
