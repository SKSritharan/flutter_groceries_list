import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/product.dart';

class DatabaseHelper {
  static const _databaseName = 'grocery_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'products';

  static Database? _database;

  // Singleton pattern to ensure single instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get database storage path
    String path = join(await getDatabasesPath(), _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tableName (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          quantity INTEGER NOT NULL,
          unitPrice REAL NOT NULL,
          isChecked INTEGER NOT NULL, 
          imageUrl TEXT
        )
      ''');
  }

  // Insert a product
  Future<int> insertProduct(Product product) async {
    Database db = await instance.database;
    debugPrint("Inserting product: ${product.name} with id: ${product.id}");
    return await db.insert(_tableName, product.toMap());
  }

  // Update a product
  Future<int> updateProduct(Product product) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Delete a product
  Future<int> deleteProduct(Product product) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Get all products
  Future<List<Product>> getAllProducts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => Product.fromMap(map)).toList();
  }
}
