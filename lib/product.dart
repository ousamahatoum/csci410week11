import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'csci410fall2023.000webhostapp.com';

class Product {
  int _pid;
  String _name;
  int _quantity;
  double _price;
  String _category;

  Product(this._pid, this._name, this._quantity, this._price, this._category);

  @override
  String toString() {
    return 'PID: $_pid Name: $_name Quantity: $_quantity Price: \$$_price Category: $_category';
  }
}

List<Product> _products = [];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Product p = Product(
            int.parse(row['pid']),
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']),
            row['category']);
        _products.add(p);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}

class ShowProducts extends StatelessWidget {
  const ShowProducts({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return Column(children: [
            const SizedBox(height: 5),
            Row(children: [
              SizedBox(width: width * 0.3),
              SizedBox(width: width * 0.5, child:
              Flexible(child: Text(_products[index].toString(),
              style: const TextStyle(fontSize: 18)))),
            ]),
            const SizedBox(height: 5)
          ]);
        });
  }
}
