import 'package:flutter_scaffold/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../config.dart';

class CategoryService {

    Future<List<CategoriesList>>fetchCategories() async{
       
        Response response = await http.get(BASE_URL+'/categories');
       
        if (response.statusCode == 200) {
            return categoryResponseFromJson(response.body).categoriesList;
        }
        return [];

    }

}