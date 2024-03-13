import 'dart:io';
import 'package:sqflite/sqflite.dart';
import '../features/home/models/item_model.dart';


class DatabaseHelper{
  static final String _databaseName = "my_database.db";
  static final String _tableName = "notes";
  static final int _databaseVersion = 1;

  // Create the necessary instance variables
  Database? _database;

  // Private constructor to prevent direct instantiation
  DatabaseHelper._privateConstructor();

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Getter for the database instance
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDatabase();
    }
    return _database!;
  }
  // Initialize the database
  Future<Database> _initializeDatabase() async {
    // Get the path to the database file
    try {
      print('DB initialised.');
      print('Initializing database: $_databaseName');
      print('Creating table (if needed): $_tableName');
      final directoryPath = await getDatabasesPath();
      final path = Directory(directoryPath).path + _databaseName;

      // Create or open the database
      return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
    } on DatabaseException catch (e) {
      print("Database Exception: $e");
      throw e; //
    }
  }

  // Create the table on database creation
  void _onCreate(Database db, int version) {
    db.execute('''CREATE TABLE $_tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT
  )''');
    print('DB created.');

  }


  // Insert a new item into the database
  Future<int> insertItem(Item item) async {
    print('Initializing database: $_databaseName');
    print('Creating table (if needed): $_tableName');
    final database = await instance.database;
    return await database.insert(_tableName, item.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all items from the database
  Future<List<Item>> getItems() async {
    final database = await instance.database;
    final maps = await database.query(_tableName);
    return maps.map((map) => Item.fromMap(map)).toList();
  }

  Future<int> deleteItems(int id) async {
    final database = await instance.database;
    final maps = await database.rawDelete('''DELETE FROM $_tableName WHERE id=$id''');
    return maps;
  }

// Get a specific item by ID
  Future<Item?> getItemById(int id) async {
    final database = await instance.database;
    final maps = await database.query(_tableName,
        where: "id = ?", whereArgs: [id]);
    return maps.isNotEmpty ? Item.fromMap(maps.first) : null;
  }

  // Update an existing item
  Future<int> updateItem(Item item) async {
    final database = await instance.database;
    return await database.update(_tableName, item.toMap(),
        where: "id = ?", whereArgs: [item.id]);
  }


}