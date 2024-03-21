import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class TotalBillCard extends StatelessWidget {
  const TotalBillCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GroceryListProvider>(
      builder: (context, groceryProvider, child) {
        double totalBill = groceryProvider.groceryList
            .fold(0.0, (sum, product) => sum + (product.quantity * product.unitPrice));

        return Card(
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                const Text(
                  'Total Bill',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rs. ${totalBill.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
