import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:risky_coin/data/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProduct {
  DatabaseProduct._();
  static final DatabaseProduct db = DatabaseProduct._();
  static Database? _database;

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MyDatabase.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE product_table (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, workshop TEXT, price TEXT, quantity TEXT)"
      );
    });
  }


  Future<Database> get database async {
    if (_database != null)
      return _database!;

    _database = await _initDatabase();
    return _database as Database;
  }

// Thêm mới sản phẩm
  Future<int> insert(ProductModel productModel) async {
    Database db = await database;
    int id = await db.insert('product_table', productModel.toJson());
    return id;
  }

  // Cập nhật sản phẩm
  Future<int> update(ProductModel productModel) async {
    final db = await database;
    int result = await db.update(
      'product_table',
      productModel.toJson(),
      where: 'id = ?',
      whereArgs: [productModel.id],
    );
    return result;
  }

// Xoá user
  delete(int id) async {
    final db = await database;
    db.delete("product_table", where: "id = ?", whereArgs: [id]);
  }

// Lấy 1 sản phẩm
  Future<ProductModel> getProduct(int id) async {
    final db = await database;
    var product = await db.query('product_table', where: 'id = ?', whereArgs: [id]);
    return ProductModel.fromJson(product.first);
  }

// Lấy tất cả sản phẩm
  Future<List<ProductModel>> products() async {
    final db = await database;
    final List<Map<String, dynamic>> productMaps = await db.query('product_table');

    return List.generate(productMaps.length, (i) {
      return ProductModel(
        id: productMaps[i]['id'],
        name: productMaps[i]['name'],
        description: productMaps[i]['description'],
        workshop: productMaps[i]['workshop'],
        price: productMaps[i]['price'],
        quantity: productMaps[i]['quantity'],
      );
    });
  }
}