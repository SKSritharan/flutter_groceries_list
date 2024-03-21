import 'package:flutter/material.dart';
import 'package:flutter_groceries_list/db/database_helper.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'isChecked': isChecked ? 1 : 0,
      'imageUrl': imageUrl,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        quantity = map['quantity'],
        unitPrice = map['unitPrice'],
        isChecked = map['isChecked'] == 1,
        imageUrl = map['imageUrl'];
}

class GroceryListProvider extends ChangeNotifier {
  List<Product> _groceryList = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Product> get groceryList => _groceryList; // Getter for the list

  // Load products from the database when the provider is initialized
  Future<void> loadProducts() async {
    _groceryList = await _dbHelper.getAllProducts();
    notifyListeners();
  }

  // Add a product
  void addProduct(Product product) {
    _groceryList.add(product);
    notifyListeners();

    DatabaseHelper.instance.insertProduct(product);
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
