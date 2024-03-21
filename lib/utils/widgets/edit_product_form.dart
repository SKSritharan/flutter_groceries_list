import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

import '../../models/product.dart';

class EditProductForm extends StatefulWidget {
  final Product product;
  const EditProductForm({required this.product, super.key});

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.product.name;
    _quantityController.text = widget.product.quantity.toString();
    _unitPriceController.text = widget.product.unitPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _scanBarcode() async {
      ScanResult result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        String barcode = result.rawContent;
        _productNameController.text = barcode;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('No barcode found')));
      }
    }

    return AlertDialog(
      title: const Text('Edit Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                  labelText: 'Product Name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.barcode_reader),
                    onPressed: _scanBarcode,
                  )),
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

              String productId = widget.product.id; // Add this line

              Product newProduct =
                  Product(id: productId, name: name, unitPrice: unitPrice, quantity: quantity);

              Provider.of<GroceryListProvider>(context, listen: false)
                  .updateProduct(newProduct);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
