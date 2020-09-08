import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_scaffold/models/category_model.dart';
import 'package:flutter_scaffold/services/category_service.dart';

class Categorise extends StatefulWidget {
  @override
  _CategoriseState createState() => _CategoriseState();
}

class _CategoriseState extends State<Categorise> {

    
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
