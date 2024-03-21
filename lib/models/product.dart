import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  int quantity;
  double unitPrice;
  bool isChecked;
  String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    this.isChecked = false,
    this.imageUrl,
  });
}

class GroceryListProvider extends ChangeNotifier {
  List<Product> _groceryList = [];

  List<Product> get groceryList => _groceryList; // Getter for the list

  // Add a product
  void addProduct(Product product) {
    _groceryList.add(product);
    notifyListeners();

    debugPrint(_groceryList.toString());
  }

  // Remove a product
  void removeProduct(Product product) {
    _groceryList.remove(product);
    notifyListeners();
  }

  void toggleIsChecked(Product product) {
    int index = _groceryList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      _groceryList[index].isChecked = !_groceryList[index].isChecked;
      notifyListeners();
    }
  }

  // Edit/Update a product
  void updateProduct(Product product) {
    int index = _groceryList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      _groceryList[index] = product;
      notifyListeners();
    }
  }
}
