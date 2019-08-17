import 'dart:async';
import 'dart:io';

import 'package:my_barcode_scanner/models/item_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tblItem = "itemTable";
  final String columnId = "itemID";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "maindb.db"); //home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
           CREATE TABLE $tblItem
           (
             $columnId INTEGER PRIMARY KEY,
             itemPicturePath TEXT,
             itemName TEXT,
             itemQty INTEGER,
             itemPrice REAL,
             itemTotalPrice REAL,
             itemTag TEXT,
             itemNotes TEXT
           )
           ''');
  }

  // CRUD - CREATE, READ, UPDATE , DELETE

  //Insertion
  Future<int> addItem(ItemModel item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tblItem", item.toMap());
    return res;
  }

  //Get items
  Future<List> getAllItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tblItem");

    return result.toList();
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database dbClient = await db;
    return await dbClient.query(tblItem);
  }

  Future fetchEveryone() async {
    Database dbClient = await db;
    List results = await dbClient.query(tblItem);
    List people = new List();
    results.forEach((map) {
      people.add(ItemModel.fromMap(map));
    });
    return people;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tblItem"));
  }

  Future<ItemModel> getItem(int id) async {
    var dbClient = await db;

    var result =
        await dbClient.rawQuery("SELECT * FROM $tblItem WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new ItemModel.fromMap(result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;

    return await dbClient
        .delete(tblItem, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateItem(ItemModel item) async {
    var dbClient = await db;
    return await dbClient.update(tblItem, item.toMap(),
        where: "$columnId = ?", whereArgs: [item.itemID]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}

// import 'dart:io';

// import 'package:my_barcode_scanner/models/item_model.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = new DatabaseHelper.internal();

//   factory DatabaseHelper() => _instance;

//   DatabaseHelper.internal();

//   static Database _db;

//   Future<Database> get db async {
//     if (_db!=null) {
//       return _db;
//     }
//     _db = await init();
//     return _db;
//   }

//   init() async {
//     Directory documentDir = await getApplicationDocumentsDirectory();
//     final path = join(documentDir.path, "items.db");

//    var myDb = await openDatabase(path, version: 1,
//         onCreate: (Database newDb, int version) {
//       newDb.execute('''
//           CREATE TABLE Items
//           (
//             id TEXT PRIMARY KEY,
//             itemPicturePath TEXT,
//             itemName TEXT,
//             itemQty INTEGER,
//             itemPrice REAL,
//             itemTotalPrice REAL,
//             itemTag TEXT,
//             itemNotes TEXT
//           )
//           ''');
//     });
//   }

//   fetchItem(int id) async {
//     final maps = await _db.query(
//       "Items",
//       columns: null,
//       where: 'id = ?',
//       whereArgs: [id],
//     );

//     if (maps.length > 0) {
//       return ItemModel.fromMap(maps.first);
//     }
//     return null;
//   }

//   Future<int> addItem(ItemModel item) {
//     return _db.insert('Items', item.toMap());
//   }
// }
