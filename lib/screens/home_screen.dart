import 'package:flutter/material.dart';
import 'package:flutter_groceries_list/providers/grocery_list_provider.dart';
import 'package:flutter_groceries_list/utils/widgets/add_product_form.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double calculateTotalBill(List<Product> products) {
      double total = 0.0;
      for (var product in products) {
        total += (product.quantity * product.unitPrice);
      }
      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Grocery List'),
      ),
      body: Consumer<GroceryListProvider>(
        builder: (context, groceryProvider, child) {
          return Column(
            children: [
              // Total Bill Display
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Bill:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        'Rs. ${calculateTotalBill(groceryProvider.groceryList)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: groceryProvider.groceryList.length,
                  itemBuilder: (context, index) {
                    Product product = groceryProvider.groceryList[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${product.quantity}'),
                          Text('Unit Price: Rs. ${product.unitPrice}'),
                          Text(
                              'Total: Rs.${(product.quantity * product.unitPrice).toStringAsFixed(2)}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AddProductForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
