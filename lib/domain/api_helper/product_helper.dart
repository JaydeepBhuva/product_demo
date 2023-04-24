import 'package:http/http.dart' as http;
import 'package:product_demo/data/model/product_model.dart';

class ProductHelper {
  static List<ProductData> productList = [];

  static Future<void> getProductApi() async {
    final responce =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (responce.statusCode == 200) {
      productList = productDataFromJson(responce.body);
    } else {
      throw Exception('Failed');
    }
  }
}
