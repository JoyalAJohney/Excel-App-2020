import 'dart:async';
import 'package:excelapp/Models/event_card.dart';
import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/Services/Database/Tables/events_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Singleton class
class DBProvider {
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

  void _onCreate(Database db, int version) async {
    // TODO: execute all table creation as batch - for single transaction
    await db.execute(DBEventsTable.createEventTable('Competitions'));
  }

  void dispose() async {
    final db = await database;
    db.close();
  }

  // Add multiple records(events) to table
  addEvents(List<Event> events, String table) async {
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
    final List<Map<String, dynamic>> res = await db.query(table);
    return res.map<Event>((row) => Event.fromJson(row)).toList();
  }

  // add single event details to table
  addEventDetails(EventDetails eventDetails,String table) async {
    final db = await database;
    await db.insert(table, eventDetails.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Retrieve one event details using id
    Future<EventDetails> getEventDetails(String table,int id) async {
    final db = await database;
    List<Map<String,dynamic>> res = await db.query(table,where: 'id = ?',whereArgs: [id]);
    Map<String,dynamic> event = res[0];
    EventDetails eventDetails = EventDetails.fromJson(event);
    return eventDetails;
  }

}