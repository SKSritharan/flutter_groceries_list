import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final void Function(bool?) onChecked;

  const ProductItem({
    super.key,
    required this.product,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: product.isChecked, onChanged: onChecked),
            // Product Image (if available)
            if (product.imageUrl != null)
              Center(
                child: Image.network(
                  product.imageUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 8),

            // Product Name
            Text(
              product.name,
              // style: Theme.of(context).textTheme.headline6,
              style: product.isChecked
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 4),

            // Quantity and Unit Price
            Row(
              children: [
                Text('Quantity: ${product.quantity}'),
                const SizedBox(width: 20),
                Text('Unit Price: Rs. ${product.unitPrice.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 4),

            // Total Price
            Text(
              'Total: Rs. ${(product.quantity * product.unitPrice).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Edit and Delete Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEditPressed,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDeletePressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
