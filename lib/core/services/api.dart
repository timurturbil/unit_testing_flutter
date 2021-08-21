import 'package:testing/core/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static const endpoint = 'unit-test-medium-default-rtdb.firebaseio.com';
  Future<dynamic> getProducts(http.Client client) async {
    final response = await client.get(Uri.https(endpoint, "products/0.json"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      /* print("${response.body}"); */
      Map<String, dynamic> data =
          new Map<String, dynamic>.from(json.decode(response.body));

      return Product.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
