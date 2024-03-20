import 'package:uuid/uuid.dart';

class Product {
  String id;
  String name;
  int quantity;
  double unitPrice;
  bool isChecked;
  String? imageUrl;

  Product({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    this.isChecked = false,
    this.imageUrl,
  }) : id = const Uuid().v4();
}