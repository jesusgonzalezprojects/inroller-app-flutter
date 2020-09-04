import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_scaffold/models/product_model.dart';
import 'package:flutter_scaffold/services/product_service.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'search.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    final productService = new ProductService();
    List<ProductsList> productsList;
    bool loading = true;

    @override
    void initState() {
        
        this.getProducts();

    }

    void getProducts() async {
        productsList = await this.productService.fetchProductsLimit(limit:-1);
        setState(() {
            loading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
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
                                        print('Card tapped.');
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
    
    /*@override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: 2,
            child: Scaffold(
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
                body: Builder(
                    builder: (BuildContext context) {
                        return DefaultTabController(
                            length: 2,
                            child: Column(
                                children: <Widget>[
                                    Container(
                                        constraints: BoxConstraints(maxHeight: 150.0),
                                        child: Material(
                                            color: Theme.of(context).accentColor,
                                            child: TabBar(
                                            indicatorColor: Colors.blue,
                                                tabs: [
                                                    Tab(icon: Icon(Icons.view_list)),
                                                    Tab(icon: Icon(Icons.grid_on)),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        child: TabBarView(
                                            children: [
                                                loading == false ? Container(
                                                    child: ListView(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        children: productsList.map((ProductsList product) {
                                                            return Builder(
                                                                builder: (BuildContext context) {
                                                                    return  InkWell(
                                                                        onTap: () {
                                                                            print('Card tapped.');
                                                                        },
                                                                        child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                            Divider(
                                                                                height: 0,
                                                                            ),
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                                                                child: ListTile(
                                                                                trailing: Icon(Icons.navigate_next),
                                                                                leading: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                                    child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.blue
                                                                                    ),
                                                                                    child: CachedNetworkImage(
                                                                                        fit: BoxFit.cover,
                                                                                        imageUrl: product.productImage,
                                                                                        placeholder: (context, url) => Center(
                                                                                            child: CircularProgressIndicator()
                                                                                        ),
                                                                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                                                                    ),
                                                                                    ),
                                                                                ),
                                                                                title: Text(
                                                                                    product.product,
                                                                                    style: TextStyle(
                                                                                        fontSize: 14
                                                                                    ),
                                                                                ),
                                                                                subtitle: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: <Widget>[
                                                                                    Row(
                                                                                        children: <Widget>[
                                                                                        Padding(
                                                                                            padding: const EdgeInsets.only(top: 2.0, bottom: 1),
                                                                                            child: Text('\$ ${product.productPrice}', style: TextStyle(
                                                                                            color: Theme.of(context).accentColor,
                                                                                            fontWeight: FontWeight.w700,
                                                                                            )),
                                                                                        ),
                                                                                       
                                                                                        ],
                                                                                    ),
                                                                                    Row(
                                                                                        children: <Widget>[
                                                                                        
                                                                                        Padding(
                                                                                            padding: const EdgeInsets.only(left: 6.0),
                                                                                            child: Text('Cortina: '+product.category, style: TextStyle(
                                                                                                fontWeight: FontWeight.w300,
                                                                                                color: Theme.of(context).primaryColor
                                                                                            )),
                                                                                        )
                                                                                        ],
                                                                                    )
                                                                                    ],
                                                                                ),
                                                                                ),
                                                                            ),
                                                                            ],
                                                                        ),
                                                                    );
                                                                },
                                                            );
                                                        }).toList(),
                                                    ),
                                                ) : Center(child: CircularProgressIndicator()),
                                                Container(
                                                    child: GridView.count(
                                                    shrinkWrap: true,
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 0.7,
                                                    padding: EdgeInsets.only(top: 8, left: 6, right: 6, bottom: 12),
                                                    children: List.generate(products.length, (index) {
                                                        return Container(
                                                        child: Card(
                                                            clipBehavior: Clip.antiAlias,
                                                            child: InkWell(
                                                            onTap: () {
                                                                print('Card tapped.');
                                                            },
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                SizedBox(
                                                                    height: (MediaQuery.of(context).size.width / 2 - 5),
                                                                    width: double.infinity,
                                                                    child: CachedNetworkImage(
                                                                    fit: BoxFit.cover,
                                                                    imageUrl: products[index]['image'],
                                                                    placeholder: (context, url) => Center(
                                                                        child: CircularProgressIndicator()
                                                                    ),
                                                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                                                    ),
                                                                ),
                                                                Padding(
                                                                    padding: const EdgeInsets.only(top: 5.0),
                                                                    child: ListTile(
                                                                    title: Text(
                                                                        'Two Gold Rings',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16
                                                                        ),
                                                                    ),
                                                                    subtitle: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                        Row(
                                                                            children: <Widget>[
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(top: 2.0, bottom: 1),
                                                                                child: Text('\$200', style: TextStyle(
                                                                                color: Theme.of(context).accentColor,
                                                                                fontWeight: FontWeight.w700,
                                                                                )),
                                                                            ),
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(left: 6.0),
                                                                                child: Text('(\$400)', style: TextStyle(
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontStyle: FontStyle.italic,
                                                                                    color: Colors.grey,
                                                                                    decoration: TextDecoration.lineThrough
                                                                                )),
                                                                            )
                                                                            ],
                                                                        ),
                                                                        Row(
                                                                            children: <Widget>[
                                                                            SmoothStarRating(
                                                                                allowHalfRating: false,
                                                                                onRatingChanged: (v) {
                                                                                    products[index]['rating'] = v;
                                                                                    setState(() {});
                                                                                },
                                                                                starCount: 5,
                                                                                rating: products[index]['rating'],
                                                                                size: 16.0,
                                                                                color: Colors.amber,
                                                                                borderColor: Colors.amber,
                                                                                spacing:0.0
                                                                            ),
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(left: 6.0),
                                                                                child: Text('(4)', style: TextStyle(
                                                                                    fontWeight: FontWeight.w300,
                                                                                    color: Theme.of(context).primaryColor
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
                                            
                                            ],
                                        ),
                                    ),
                                ],
                            )
                        );
                    },
                ),
            ),
        );
    }*/
}
