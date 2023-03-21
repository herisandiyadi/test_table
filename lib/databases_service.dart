import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:test_table/model/table_model.dart';

class DatabaseService {
  static DatabaseService? databaseService;
  static Database? _database;

  DatabaseService._createObject();

  factory DatabaseService() {
    databaseService ??= DatabaseService._createObject();
    return databaseService!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tabletest.db');

    // await deleteDatabase(path);

    var todoDatabase = openDatabase(path, version: 1, onCreate: createDatabase);

    return todoDatabase;
  }

  void createDatabase(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE tabletest (
    itemid INTEGER PRIMARY KEY,
    itemname TEXT,
    barcode TEXT
    )
    ''');
  }

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await database;

    var mapList = await db.query('tabletest', orderBy: 'itemid');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectById(int id) async {
    Database db = await database;
    // var mapList = await db.query('tabletest', where: 'itemid = $id');
    var mapList = await db
        .rawQuery("SELECT * FROM tabletest WHERE itemid LIKE ?;", ['%$id']);

    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectByName(String name) async {
    Database db = await database;
    var mapList = await db
        .rawQuery("SELECT * FROM tabletest WHERE itemname LIKE ?;", ['%$name']);

    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectByBarcode(String barcode) async {
    Database db = await database;
    var mapList = await db.rawQuery(
        "SELECT * FROM tabletest WHERE barcode LIKE ?;", ['%$barcode']);

    return mapList;
  }

  Future<int> insert(TableModel object) async {
    Database db = await database;
    int count = await db.insert('tabletest', object.toJson());
    return count;
  }

  Future<int> update(TableModel object) async {
    Database db = await database;
    int count = await db.update('tabletest', object.toJson(),
        where: 'itemid = ?', whereArgs: [object.itemid]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    int count =
        await db.delete('tabletest', where: 'itemid = ?', whereArgs: [id]);
    return count;
  }

  Future<List<TableModel>> readAllData() async {
    Database db = await database;
    final result = await db.query('tabletest');
    return result.map((e) => TableModel.fromJson(e)).toList();
  }
}
