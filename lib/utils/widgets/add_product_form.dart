import 'package:flutter/material.dart';
import 'package:flutter_groceries_list/providers/grocery_list_provider.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the dialog compact
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _unitPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Unit Price'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ), 
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String name = _productNameController.text;
              int quantity = int.parse(_quantityController.text);
              double unitPrice = double.parse(_unitPriceController.text);

              Product newProduct =
                  Product(name: name, unitPrice: unitPrice, quantity: quantity);

              Provider.of<GroceryListProvider>(context, listen: false)
                  .addProduct(newProduct);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
