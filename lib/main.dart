import 'package:flutter/material.dart';
import 'package:flutter_groceries_list/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GroceryListProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Grocery List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
