import 'dart:convert';

import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/product_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ProductService {

    Future<List<ProductsList>>fetchProductsLimit( {int limit , String query} ) async {
        
        String endpoint = '/products?$query';
        if (limit > 0 ) {
            endpoint = endpoint + 'limit=$limit';
        }

        Response response = await http.get(BASE_URL+endpoint);

        print(response.body);

        if (response.statusCode == 200) {
            return productResponseFromJson(response.body).productsList;
        }

        return [];

    }

    Future<ProductsList> fetchProduct(int productId) async{

        Response response = await http.get(BASE_URL+'/products/$productId');

        Map product = json.decode(response.body);

        if (response.statusCode == 200) {
            return ProductsList.fromJson(product);
        }

        return new ProductsList();
    }

    Future<List<ProductsList>> fetchProductByCategory({int category_id}) async{

        Response response = await http.get(BASE_URL+'/products?category_id=$category_id');

        if (response.statusCode == 200) {
            return productResponseFromJson(response.body).productsList;
        }

        return [];
    }

}