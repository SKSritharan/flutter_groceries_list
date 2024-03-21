import 'package:flutter/material.dart';
import 'package:flutter_groceries_list/utils/widgets/edit_product_form.dart';
import 'package:flutter_groceries_list/utils/widgets/product_item.dart';
import 'package:flutter_groceries_list/utils/widgets/total_bill_card.dart';
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
              const TotalBillCard(),
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
                      return ProductItem(
                          product: product,
                          onEditPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  EditProductForm(product: product),
                            );
                          },
                          onDeletePressed: () {
                            groceryProvider.removeProduct(product);
                          });
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
