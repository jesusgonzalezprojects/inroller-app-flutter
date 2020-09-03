import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/models/basket_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class BasketService {

    Future<Basket> fetchBasket() async {

        Response response = await http.get(BASE_URL+'/basket?user_id=1');

        if (response.statusCode == 200) {
            return basketResponseFromJson(response.body).basket;
        }

        return new Basket();

    }   

}