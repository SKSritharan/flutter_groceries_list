import 'package:flutter/material.dart';

import '../models/product.dart';

class GroceryListProvider extends ChangeNotifier {
  List<Product> _groceryList = [];

  List<Product> get groceryList => _groceryList; // Getter for the list

  // Add a product
  void addProduct(Product product) {
    _groceryList.add(product);
    notifyListeners(); // Notify listeners of the change

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
