import 'dart:async';
import 'package:excelapp/Models/event_card.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Singleton class
class DBProvider {
  // only instance to DBProvider object
  static final DBProvider _instance = DBProvider.internal();
  DBProvider.internal();
  factory DBProvider() => _instance;

  // Database object
  Database _db;
  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initDB();
    return _db;
  }

  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'TestDB.db');
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  // Create tables in database
  void _onCreate(Database db, int version) async {
    // Multiple tables can be added here
    await db.execute("CREATE TABLE Competitions ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "icon TEXT,"
        "category TEXT"
        ")");
  }


  // Add multiple records(events) to table
  addEvents(List<Event> events,String table) async {
    final db = await database;
    Batch batch = db.batch();
    for (var event in events) {
      batch.insert(
        // 'EventList',
        table,
        event.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Retrieve all events from table
  Future<List<Event>> getEvents(String table) async {
    final db = await database;
    final List<Map<String,dynamic>> res = await db.query(table);
    return res.map<Event>((row) => Event.fromJson(row)).toList();
  }

  // TODO: Add one record using id

  // TODO: Retrieve one record using id
  
}