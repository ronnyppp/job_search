import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:job_search/models/job.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._();

  DatabaseService._();

  Database? _database;
  
  // open the local SQlite database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), "jobs.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""
      CREATE TABLE jobs(
        id INTEGER PRIMARY KEY,
        title TEXT,
        company TEXT,
        type TEXT,
        description TEXT,
        favorite INTEGER
      )
    """);
  }

  /// Inserts or replaces a single job.
  Future<void> insertJob(Job job) async {
    final db = await database;

    await db.insert(
      "jobs",
      job.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Saves jobs locally for offline access
  Future<void> insertJobs(List<Job> jobs) async {
    final db = await database;

    final batch = db.batch();

    for (final job in jobs) {
      batch.insert(
        "jobs",
        job.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  /// Returns all cached jobs.
  Future<List<Job>> getJobs() async {
    final db = await database;

    final maps = await db.query("jobs");

    return maps.map((map) => Job.fromMap(map)).toList();
  }

  /// Updates the favorite status of a job.
  Future<void> updateFavorite(int id, bool favorite) async {
    final db = await database;

    await db.update(
      "jobs",
      {
        "favorite": favorite ? 1 : 0,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Removes all cached jobs.
  Future<void> clearJobs() async {
    final db = await database;

    await db.delete("jobs");
  }
}

