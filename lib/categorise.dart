import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_scaffold/models/category_model.dart';
import 'package:flutter_scaffold/services/category_service.dart';

class Categorise extends StatefulWidget {
  @override
  _CategoriseState createState() => _CategoriseState();
}

class _CategoriseState extends State<Categorise> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

    
    final categoriesService = new CategoryService();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Categorias'),
            ),
            body: SafeArea(
                top: false,
                left: false,
                right: false,
                child: Container(
                    child: FutureBuilder(
                        future: categoriesService.fetchCategories(),
                        builder: (BuildContext context , AsyncSnapshot snapshot){
                            if (snapshot.hasData) {
                                List<CategoriesList> categories = snapshot.data;
                                return ListView.builder(
                                    itemCount: categories ==  null ? 0 : categories.length,
                                    itemBuilder: (BuildContext context , int index){
                                        CategoriesList category = categories[index];
                                        return  Container(
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
                                                                height: 180,
                                                                width: double.infinity,
                                                                child: CachedNetworkImage(
                                                                    fit: BoxFit.cover,
                                                                    imageUrl: category.image,
                                                                    placeholder: (context, url) =>
                                                                        Center(child: CircularProgressIndicator()),
                                                                    errorWidget: (context, url, error) =>
                                                                        new Icon(Icons.error),
                                                                    ),
                                                                ),
                                                                ListTile(
                                                                    title: Text(
                                                                        '${category.category}',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold, fontSize: 16
                                                                        ),
                                                                    )
                                                                )
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
                )
            ),
        );
    }
}
