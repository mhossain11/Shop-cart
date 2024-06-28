

import 'package:flutter_task/data/model/modelproduct.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shopping_cart.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cart_items(id INTEGER PRIMARY KEY, name TEXT, salePrice REAL, quantity INTEGER,image TEXT)',
        );
      },
    );
  }

  Future<ModelProduct> insertItem(ModelProduct item) async {
    final db = await database;
    await db.insert(
      'cart_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return item;
  }

  Future<void> updateItem(ModelProduct item) async {
    final db = await database;
    await db.update(
      'cart_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ModelProduct>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_items');

    return List.generate(maps.length, (i) {
      return ModelProduct(
        id: maps[i]['id'],
        name: maps[i]['name'],
        image: maps[i]['image'],
        quantity: maps[i]['quantity'],
        salePrice: maps[i]['salePrice'],
      );
    });
  }
}
