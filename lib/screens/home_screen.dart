import 'package:flutter/material.dart';
import 'package:flutter_groceries_list/utils/widgets/edit_product_form.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../utils/widgets/add_product_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load products from the database when the app starts
    Provider.of<GroceryListProvider>(context, listen: false).loadProducts();
  }

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
        title: Text(
          'My Grocery List',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
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
                    if (groceryProvider.groceryList.isEmpty) {
                      return const Center(
                        child: Text('Your grocery list is empty!'),
                      );
                    } else {
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
                        trailing: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      EditProductForm(product: product),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                groceryProvider.removeProduct(product);
                              },
                            ),
                          ],
                        ),
                      );
                    }
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
