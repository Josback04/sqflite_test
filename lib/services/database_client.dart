import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/models/article.dart';
import 'package:sqflite_test/models/item_list.dart';

class DatabaseClient {
  // 2 tables

  //table 1 => Liste des envies: Liste informatique. (nom et identifiant)

  // tab 2=> liste des objets: PS5, un nouvel ordi. (Nom, prix, lieu, image, id de la liste, leur propre id)

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database database, int version) async {
    // table 1
    await database.execute('''
      CREATE TABLE list(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL

      )
       ''');
    // table 2

    await database.execute(''' 
      CREATE TABLE article(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL,
        shop TEXT,
        image TEXT,
        list INTEGER
      )
      ''');
  }

//obtenir données
  Future<List<ItemList>> allItem() async {
    Database db = await database;
    const query = "SELECT *FROM list";
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    return mapList.map((map) => ItemList.fromMap(map)).toList();
  }

  Future<List<Article>> articlesFromId(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList =
        await db.query('article', where: 'list=?', whereArgs: [id]);

    return mapList.map((map) => Article.fromMap(map)).toList();
  }

  //get data
  Future<bool> addItemList(String text) async {
    Database db = await database;
    await db.insert("list", {"name": text});
    return true;
  }

  Future<bool> upsert(Article article) async {
    Database db = await database;
    (article.id == null)
        ? article.id = await db.insert('article', article.toMap())
        : await db.update('article', article.toMap(),
            where: 'id=?', whereArgs: [article.id]);

    return true;
  }

  //sup list

  Future<bool> removeItem(ItemList itemList) async {
    Database db = await database;
    await db.delete('list', where: 'id=?', whereArgs: [itemList.id]);

    // supp all articles
    return true;
  }
}
